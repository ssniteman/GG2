//
//  ConversationsVC.h
//  SidebarDemo
//
//  Created by Shane Sniteman on 10/10/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConversationsVC : UIViewController

@property (strong,nonatomic) NSDictionary * conversationThread;
@property (weak, nonatomic) IBOutlet UITextView *conversationNew;


- (IBAction)conversationNewSendButton:(id)sender;


@property (weak, nonatomic) IBOutlet UITableView *conversationTableView;


@property (weak, nonatomic) IBOutlet UIView *conversationBottomView;


@end
