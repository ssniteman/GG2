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
    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.messages.count;
    
    // this is returning 0
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newFriendCell"];
    NSLog(@"%@",self.messages[indexPath.row]);

   cell.messageLabel.text = self.messages[indexPath.row][@"messageContent"];
    
    PFUser * user = self.messages[indexPath.row][@"S_R"];
        NSLog(@"messagesss index %@",self.messages[indexPath.row][@"S_R"][0][@"bandName"]);


   cell.fromLabel.text =  self.messages[indexPath.row][@"S_R"][1][@"bandName"];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //        //uncomment to get the time only
    //        //[formatter setDateFormat:@"hh:mm a"];
    //        //[formatter setDateFormat:@"MMM dd, YYYY"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    cell.dateLabel.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate: self.messages[indexPath.row][@"date"]]];

    
    if (cell == nil) {
        
        cell = [[ConversationCell alloc]init];
    }
    
//    cell.usersContent = self.messages[indexPath.row][@"S_R"];
    
    
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
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    PFQuery * conversationQuery = [PFQuery queryWithClassName:@"Messages"];
    
    [conversationQuery whereKey:@"S_R" containsAllObjectsInArray:@[[PFUser currentUser],self.conversationThread[@"user"]]];
    [conversationQuery includeKey:@"sender"];
    [conversationQuery includeKey:@"reciever"];
    [conversationQuery includeKey:@"S_R"];
    [conversationQuery includeKey:@"createdAt"];
    
    [conversationQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        self.messages = [objects mutableCopy];
        
        int unReadNowRead = 0;
        for (PFObject * message in self.messages)
        {
            PFUser * reciever = message[@"reciever"];
            
            // only can read message if you are the reciever //
            
            if ([reciever.objectId isEqualToString:[PFUser currentUser].objectId])
            {
                if (![message[@"read"] boolValue]) { unReadNowRead++; }
                
                message[@"read"] = @YES;
                [message saveInBackground];
            }
            
            
        }
        
        PFInstallation *currentInstallation = [PFInstallation currentInstallation];
        if (currentInstallation.badge != 0) {
            currentInstallation.badge -= unReadNowRead;
            if (currentInstallation.badge < 0) { currentInstallation.badge = 0; }
            [currentInstallation saveEventually];
        }
        
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
