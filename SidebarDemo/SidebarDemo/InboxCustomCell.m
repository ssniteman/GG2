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
    
    if ([user[@"userType"] isEqualToString:@"musician"]) {
    
        if ([user[@"bandName"] length]==0) {
            self.inboxMessageName.text = @"N/A";
        } else {
        
            self.inboxMessageName.text = user[@"bandName"];
        }
     
    } else {
        
        if ([user[@"barName"] length]==0) {
            self.inboxMessageName.text = @"N/A";
        } else {
        self.inboxMessageName.text = user[@"barName"];
        }
    }
    
    
    
    PFFile *imageFile = user[@"image"];
    
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        
        UIImage * image = [UIImage imageWithData:data];
        [self.inboxMessagePhoto setBackgroundImage:image forState:UIControlStateNormal];
    }];
    
    


    self.inboxMessagePhoto.layer.cornerRadius = 30;
    self.inboxMessagePhoto.userInteractionEnabled = false;
    self.inboxMessagePhoto.clipsToBounds = YES;
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    
    
    

    
}

@end
