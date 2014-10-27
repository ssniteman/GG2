//
//  ComposeMessageTVC.h
//  SidebarDemo
//
//  Created by Shane Sniteman on 10/9/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Parse/Parse.h>

@interface ComposeMessageTVC : UITableViewController

@property (nonatomic) PFObject * toUser;

@property (weak, nonatomic) IBOutlet UITextField *sendToMessage;

@property (weak, nonatomic) IBOutlet UITextView *sendMessageText;

@property (weak, nonatomic) IBOutlet UILabel *toWhomWeSend;



@property (strong, nonatomic) NSString * toWhomWeSendString;

@end
