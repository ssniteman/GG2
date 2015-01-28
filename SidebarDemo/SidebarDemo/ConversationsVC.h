//
//  ConversationsVC.h
//  SidebarDemo
//
//  Created by Shane Sniteman on 10/10/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConversationsVC : UITableViewController

//The Dictionary
@property (strong,nonatomic) NSDictionary * conversationThread;


//The Array for Messagesx
@property(strong,nonatomic) NSMutableArray * messages;


//Array for Users

@property (weak, nonatomic) IBOutlet UITextView *conversationNew;


- (IBAction)conversationNewSendButton:(id)sender;


- (IBAction)composeNewMessage:(id)sender;



@property (weak, nonatomic) IBOutlet UIView *conversationBottomView;


@end
