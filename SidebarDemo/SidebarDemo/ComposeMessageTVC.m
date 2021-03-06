//
//  ComposeMessageTVC.m
//  SidebarDemo
//
//  Created by Shane Sniteman on 10/9/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "ComposeMessageTVC.h"
#import "SearchResultsProfileViewController.h"
#import <Parse/Parse.h>

@interface ComposeMessageTVC () <UITextFieldDelegate>

@end

@implementation ComposeMessageTVC {

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.toWhomWeSend.text = self.toWhomWeSendString;
    self.toWhomWeSend.textColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    [self.toWhomWeSend setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0]];
    
   // NSLog(@"listen here %@",self.toWhomWeSendString);

    self.sendMessageText.text = @"";
    
    [self.sendMessageText becomeFirstResponder];
    

    // SEND BUTTON
    
    UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleBordered target:self action:@selector(sendButton)];
    
    [sendButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0], NSFontAttributeName,
                                          [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f], NSForegroundColorAttributeName,
                                          nil]
                                forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = sendButton;
    
    
    // CANCEL BUTTON
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButton)];
    
    [cancelButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0], NSFontAttributeName,
                                        [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f], NSForegroundColorAttributeName,
                                        nil]
                              forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
  
    SearchResultsProfileViewController * searchResultProfile = [[SearchResultsProfileViewController alloc] init];
   
}


-(void)sendButton {
    
    // Send Message to user
    
    PFObject * message = [PFObject objectWithClassName:@"Messages"];
    
    message[@"sender"] = [PFUser currentUser];
    message[@"reciever"] = self.toUser;
    message[@"messageContent"] = self.sendMessageText.text;
    message[@"S_R"] = @[self.toUser, [PFUser currentUser]];
    message[@"date"] = [NSDate date];
    
    [message saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        [self cancelButton];

    }];
    
    
    // RUN PUSH
    
    
    PFQuery * deviceQuery = [PFInstallation query];
    
    [deviceQuery whereKey:@"user" equalTo:self.toUser];
    
    NSString * alert = [NSString stringWithFormat:self.sendMessageText.text, [PFUser currentUser].username];
    
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          alert, @"alert",[PFUser currentUser].username,
                          @"sender",
                          @"Increment", @"badge",
                          nil];
    
    
    
    PFPush *push = [[PFPush alloc] init];
    [push setQuery:deviceQuery];
    

    [push setData:data];
    [push sendPushInBackground];
    
}

-(void)cancelButton{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}



@end
