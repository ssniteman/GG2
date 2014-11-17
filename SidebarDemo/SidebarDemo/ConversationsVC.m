//
//  ConversationsVC.m
//  SidebarDemo
//
//  Created by Shane Sniteman on 10/10/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "ConversationsVC.h"
#import "ConversationCell.h"
#import "InboxTVC.h"
#import <Parse/Parse.h>
#import "ComposeMessageTVC.h"

@interface ConversationsVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ConversationsVC {
    
    UITableView *conversationTableView;
    
}

-(void)setMessages:(NSMutableArray *)messages {
    _messages = messages;
    
    
    [self.tableView reloadData];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.messages.count;
    
    // this is returning 0
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newFriendCell"];
    
    cell.text = self.messages[indexPath.row][@"messageContent"];
    
//    NSLog(@"messagesss index %@",self.messages[indexPath.row]);
    
    
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    // refresh conversation messages
    
    PFQuery * conversationQuery = [PFQuery queryWithClassName:@"Messages"];
    
    [conversationQuery whereKey:@"S_R" containsAllObjectsInArray:@[[PFUser currentUser],self.conversationThread[@"user"]]];
    [conversationQuery includeKey:@"sender"];
    [conversationQuery includeKey:@"reciever"];
    [conversationQuery includeKey:@"S_R"];
    
    [conversationQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        self.messages = [objects mutableCopy];
        
    }];
    
}



- (IBAction)conversationNewSendButton:(id)sender {
}

- (IBAction)composeNewMessage:(id)sender {
    
    PFUser * user = self.conversationThread[@"user"];
    
    // create and present a new ComposeMessageTVC
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"composeMessage" bundle: nil];
    
    ComposeMessageTVC * composeTVC = [storyboard instantiateViewControllerWithIdentifier:@"composeNew"];
    
    composeTVC.toUser = user;
    composeTVC.toWhomWeSendString = user[@"bandName"];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:composeTVC];
    
    //now present this navigation controller modally
    [self presentViewController:navigationController animated:YES completion:nil];

    
}
@end
