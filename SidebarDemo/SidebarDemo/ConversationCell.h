//
//  ConversationCell.h
//  SidebarDemo
//
//  Created by Shane Sniteman on 10/10/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConversationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong,nonatomic) NSString * text;
@end
