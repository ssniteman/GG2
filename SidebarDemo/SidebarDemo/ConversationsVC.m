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

@implementation ConversationsVC

-(void)setMessages:(NSMutableArray *)messages {
    _messages = messages;
    
    
    [self.conversationTableView reloadData];
    
    NSLog(@"COUNT NUMBER ROWS IN NEW VIEW :%d",self.messages.count);
    // this NSLog is coming back correctly
}

-(void)setConversationThread:(NSDictionary *)conversationThread {
    _conversationThread = conversationThread;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.

    NSLog(@"COUNT NUMBER ROWS :%d",self.messages.count);
    return self.messages.count;
    
    // this is returning 0
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"conversationCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        
        cell = [[ConversationCell alloc]init];
            }
    
    cell.text = self.messages[indexPath.row];
    
    NSLog(@"messagesss index %@",self.messages[indexPath.row]);
    
    // this is returning (null)
    
    //     Configure the cell...
    
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.conversationTableView.dataSource = self;
    self.conversationTableView.delegate = self;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)conversationNewSendButton:(id)sender {
}
@end
