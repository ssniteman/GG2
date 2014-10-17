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

-(void)setToWhomWeSendString:(NSString *)toWhomWeSendString {
    
    _toWhomWeSendString = toWhomWeSendString;
    NSLog(@"listen here %@",toWhomWeSendString);
    self.sendMessageText.text = toWhomWeSendString;
    
    [self.tableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    // SEND BUTTON
    
    UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleBordered target:self action:@selector(sendButton)];
    
    self.navigationItem.rightBarButtonItem = sendButton;
    
    
    // CANCEL BUTTON
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButton)];
    
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
    
    [message saveInBackground];
    
    // add reciever to people spoken to
    
    PFQuery * userQuery = [PFUser query];
    [userQuery includeKey:@"peopleSpoken"];
    PFUser * currentUser = (PFUser *)[userQuery getObjectWithId:[PFUser currentUser].objectId];
    
    NSMutableArray * peopleSpokenTo = [currentUser[@"peopleSpoken"] mutableCopy];
    
    if (peopleSpokenTo == nil) {
        peopleSpokenTo = [@[] mutableCopy];
    }
    
    BOOL foundUser = NO;
    for (PFUser * user in peopleSpokenTo)
    {
        if ([user.objectId isEqualToString:self.toUser.objectId]) foundUser = YES;
    }
    
    if (!foundUser)
    {
        [peopleSpokenTo addObject:self.toUser];
    }
    
//    if (![peopleSpokenTo containsObject:self.toUser])
//    {
//        [peopleSpokenTo addObject:self.toUser];
//    }
    
    currentUser[@"peopleSpoken"] = peopleSpokenTo;
    
    [currentUser saveInBackground];
    
    // run push
    
    
    NSLog(@"message is working");
    NSLog(@"this is the array of conversation %@", message[@"S_R"]);

    
    [self cancelButton];
    
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