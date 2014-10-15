//
//  ProfileViewController.h
//  SidebarDemo
//
//  Created by Shane Sniteman on 9/7/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController


//----------------------------------------------------------------


//Profile Social Accounts

//Button Actions

//Profile SoundCloud Button
- (IBAction)soundcloudButton:(id)sender;

//Profile Facebook Button
- (IBAction)facebookButton:(id)sender;

//Profile Instagram Button
- (IBAction)instagramButton:(id)sender;

//Button Properties

@property (weak, nonatomic) IBOutlet UIButton *photosButton;

@property (weak, nonatomic) IBOutlet UIButton *soundButton;

@property (weak, nonatomic) IBOutlet UIButton *videoButton;


//Array for other profiles
@property (nonatomic, strong) NSMutableArray * searchResultsForProfile;




@property (nonatomic,strong) NSString * whatProfileToLoad;


@end