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
@interface ConversationsVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ConversationsVC{
    UITableView *conversationTableView;
}

-(void)setMessages:(NSMutableArray *)messages {
    _messages = messages;
    
    
    [conversationTableView reloadData];
    
    
}

-(void)setConversationThread:(NSDictionary *)conversationThread {
    _conversationThread = conversationThread;
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
    
     NSString *CellIdentifier = @"newFriendCell";
    ConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newFriendCell"];
    
    if (cell == nil) {
        cell = [[ConversationCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    
    cell.text = self.messages[indexPath.row];
    
    NSLog(@"messagesss index %@",self.messages[indexPath.row]);
    
    
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    conversationTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    
    [self.view addSubview:conversationTableView];
    
conversationTableView.dataSource = self;
    conversationTableView.delegate = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    
}



- (IBAction)conversationNewSendButton:(id)sender {
}
@end
