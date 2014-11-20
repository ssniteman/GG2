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

@property (weak, nonatomic) IBOutlet UIButton *profilePicture;


//Bar Facebook Button


- (IBAction)instagramAction:(id)sender;

- (IBAction)facebookAction:(id)sender;

- (IBAction)twitterAction:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *testlabel;

//Button Properties

@property (weak, nonatomic) IBOutlet UIButton *photosButton;

@property (weak, nonatomic) IBOutlet UIButton *soundButton;

@property (weak, nonatomic) IBOutlet UIButton *videoButton;
@property (weak, nonatomic) IBOutlet UIView *barView;

- (IBAction)photoAction:(id)sender;

- (IBAction)soundAction:(id)sender;

- (IBAction)youtubeAction:(id)sender;

//Array for other profiles
@property (nonatomic, strong) PFUser * searchResultsForProfile;


//Link for SHOWCASE

@property (nonatomic) NSString * link;



@end
