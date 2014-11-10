//
//  InboxCustomCell.m
//  SidebarDemo
//
//  Created by Shane Sniteman on 10/10/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "InboxCustomCell.h"
#import "InboxTVC.h"
#import <Parse/Parse.h>

@implementation InboxCustomCell


-(void)setMyMessagesCell:(NSDictionary *)myMessagesCell {
   
    _myMessagesCell = myMessagesCell;
    
    
    PFUser * user = myMessagesCell[@"user"];

    PFQuery * userQuery = [PFUser query];

    PFUser * conversationUser = (PFUser *)[userQuery getObjectWithId:user.objectId];

    
    self.inboxMessageName.text = conversationUser.username;
    
    self.inboxMessagePhoto.layer.cornerRadius = 30;
    self.inboxMessagePhoto.userInteractionEnabled = false;
    self.inboxMessagePhoto.clipsToBounds = YES;
    
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    
    
    

    
}

@end
