//
//  InboxCustomCell.h
//  SidebarDemo
//
//  Created by Shane Sniteman on 10/10/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Parse/Parse.h>

@interface InboxCustomCell : UITableViewCell

@property (nonatomic,strong) NSDictionary * myMessagesCell;

@property (weak, nonatomic) IBOutlet UIButton *inboxMessagePhoto;

@property (weak, nonatomic) IBOutlet UILabel *inboxMessageName;

@property (weak, nonatomic) IBOutlet UILabel *inboxMessageDate;

@property (weak, nonatomic) IBOutlet UILabel *messagePreviewLabel;


@end
