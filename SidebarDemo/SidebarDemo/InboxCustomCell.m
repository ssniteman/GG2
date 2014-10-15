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


-(void)setMyMessagesCell:(PFObject *)myMessagesCell {
   
    _myMessagesCell = myMessagesCell;
    
    PFUser * sender = myMessagesCell[@"sender"];
    
    self.inboxMessageName.text = sender.username;
    
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    
    
    

    
}

@end
