//
//  QueryResultsCell.m
//  SidebarDemo
//
//  Created by Shane Sniteman on 10/6/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "QueryResultsCell.h"
#import "QueryResultsTVC.h"
#import <Parse/Parse.h>
@implementation QueryResultsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setUsersContent:(PFUser *)usersContent{
    
    
    
    
    self.mainView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.mainView.layer.borderWidth = 1.0f;
    
    self.mainView.layer.cornerRadius = 3;
    self.mainView.layer.masksToBounds = YES;
   
    
//    self.bottomVIew.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.bottomVIew.layer.borderWidth = 1.0f;
    
    
    _usersContent  = usersContent;

    // SETTING LABELS
    
//    resultPhoto
    
    
    self.resultPhoto.layer.cornerRadius = 40;
    self.resultPhoto.userInteractionEnabled = false;
    self.resultPhoto.clipsToBounds = YES;
    
    self.resultBandName.text = self.usersContent[@"bandName"];
    self.resultGenreLabel.text = self.usersContent[@"genre"];
//    self.resultCityLabel.text = delegate shit
    self.resultAvailabilityLabel.text = self.usersContent[@"availability"];
//    self.resultRateLabel.text = rate stuff
    
//    NSLog(@"%@",usersContent);
    
}



@end
