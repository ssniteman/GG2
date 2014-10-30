//
//  ConversationCell.m
//  SidebarDemo
//
//  Created by Shane Sniteman on 10/10/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "ConversationCell.h"

@implementation ConversationCell

- (void)awakeFromNib {




}

-(void)setText:(NSString *)text{
    _text = text;
    self.messageLabel.text = self.text;
    
    
    //     Configure the cell...
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
