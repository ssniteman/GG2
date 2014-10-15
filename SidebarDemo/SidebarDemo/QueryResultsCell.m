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
   
    _usersContent  = usersContent;

    // SETTING LABELS
    
//    resultPhoto
    
    self.resultBandName.text = self.usersContent[@"bandName"];
    self.resultGenreLabel.text = self.usersContent[@"genre"];
//    self.resultCityLabel.text = delegate shit
    self.resultAvailabilityLabel.text = self.usersContent[@"availability"];
//    self.resultRateLabel.text = rate stuff
    
//    NSLog(@"%@",usersContent);
    
}



@end
