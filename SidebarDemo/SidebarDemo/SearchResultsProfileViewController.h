//
//  SearchResultsProfileViewController.h
//  SidebarDemo
//
//  Created by Shane Sniteman on 10/8/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SearchResultsProfileViewController : UIViewController

//Profile SoundCloud Button
- (IBAction)soundcloudButton:(id)sender;

//Profile Facebook Button
- (IBAction)facebookButton:(id)sender;

//Profile Instagram Button
- (IBAction)instagramButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *testlabel;

//Button Properties

@property (weak, nonatomic) IBOutlet UIButton *photosButton;

@property (weak, nonatomic) IBOutlet UIButton *soundButton;

@property (weak, nonatomic) IBOutlet UIButton *videoButton;



//Array for other profiles
@property (nonatomic, strong) PFUser * searchResultsForProfile;

@end
