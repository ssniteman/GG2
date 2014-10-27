//
//  ConversationsVC.m
//  SidebarDemo
//
//  Created by Shane Sniteman on 10/10/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "ConversationsVC.h"
#import "ConversationCell.h"
#import <Parse/Parse.h>
@interface ConversationsVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ConversationsVC


-(void)setConversationThread:(NSDictionary *)conversationThread{
    _conversationThread = conversationThread;
//    
//    NSLog(@"The conversation Thread :%@",conversationThread[@"messages"]);
//    
//    
//    for (PFObject * message in conversationThread[@"messages"]) {
//        
//        NSString * text = message[@"messageContent"];
//        
//        NSLog(@"The actual MESSAGE: %@",text);
//    }

    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.conversationThread.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"conversationCell" forIndexPath:indexPath];
    
    for (PFObject * message in self.conversationThread[@"messages"]) {
        
        NSString * text = message[@"messageContent"];
        
        NSLog(@"The actual MESSAGE: %@",text);
    }
    cell.messageLabel.text = @"hey";
    
    
    if (cell == nil) {
        
        cell = [[ConversationCell alloc]init];
    }
    
    
    
    //     Configure the cell...
    
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.conversationTableView.dataSource = self;
    
    self.conversationTableView.delegate = self;
    
    NSLog(@"The conversation Thread :%@",self.conversationThread[@"messages"]);
    
    
    for (PFObject * message in self.conversationThread[@"messages"]) {
        
        NSString * text = message[@"messageContent"];
        
        NSLog(@"The actual MESSAGE: %@",text);
    }
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
