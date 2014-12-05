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


-(void)setUsersContent:(PFUser *)usersContent {
   
    
    self.mainView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.mainView.layer.borderWidth = 1.0f;
    
    self.mainView.layer.cornerRadius = 3;
    self.mainView.layer.masksToBounds = YES;
   
    
    _usersContent  = usersContent;

    // SETTING LABELS
    
//    resultPhoto
    
    if (self.usersContent[@"image"] == nil) {
        
        [self.resultPhoto setBackgroundImage:[UIImage imageNamed:@"avatarcopy.jpg"] forState:UIControlStateNormal];
        
    } else {

    // Image coming back from Parse
    
    
    NSLog(@"The PICTURE!!!!!!!!!!%@",self.usersContent[@"image"]);
        
        PFFile *imageFile = self.usersContent[@"image"];
        
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            
            UIImage * image = [UIImage imageWithData:data];
            [self.resultPhoto setBackgroundImage:image forState:UIControlStateNormal];
        }];
        
        
    }
   
    self.resultPhoto.layer.cornerRadius = 40;
    self.resultPhoto.userInteractionEnabled = false;
    self.resultPhoto.clipsToBounds = YES;
    
    
    if ([usersContent[@"bandName"] length] <= 0) {
        
        self.resultBandName.text = @"N/A";
        
    } else {
    
    self.resultBandName.text = self.usersContent[@"bandName"];
    
    }
    
//    
//    
//    if ([usersContent[@"barName"] length] <= 0) {
//        
//        self.resultBandName.text = @"N/A";
//        
//    } else {
//        
//        self.resultBandName.text = self.usersContent[@"barName"];
//        
//    }
//    
//    
    
    
    if ([usersContent[@"genre"] length] <= 0) {
        
        self.resultGenreLabel.text = @"N/A";
    } else {
        
        self.resultGenreLabel.text = self.usersContent[@"genre"];

    }

    if ([usersContent[@"availability"] length] <= 0) {
        
        self.resultGenreLabel.text = @"N/A";
    } else {
        
        self.resultGenreLabel.text = self.usersContent[@"availability"];
        
    }
    
    if ([usersContent[@"city"] length] <= 0) {
        
        self.resultCityLabel.text = @"City, State";
        
    } else {
        
        self.resultCityLabel.text = [NSString stringWithFormat:@"%@, %@",usersContent[@"city"],usersContent[@"state"]];
       
    }
}



@end
