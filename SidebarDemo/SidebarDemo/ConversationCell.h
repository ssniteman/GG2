//
//  ConversationCell.h
//  SidebarDemo
//
//  Created by Shane Sniteman on 10/10/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Parse/Parse.h>


@interface ConversationCell : UITableViewCell
@property (strong,nonatomic) NSString * text;
@property (strong,nonatomic) NSString * text2;
@property(strong,nonatomic) NSString * whoSending;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UITextView *messageLabel;
@property(strong,nonatomic) NSArray * messages;

@property (weak, nonatomic) IBOutlet UILabel *fromLabel;

@end
