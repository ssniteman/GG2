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
- (IBAction)youTube:(id)sender;

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

- (IBAction)barInstagram:(id)sender;

- (IBAction)barFacebook:(id)sender;

- (IBAction)barTwitter:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *barUIView;


@property (weak, nonatomic) IBOutlet UILabel *availabilityLabel;

@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@property (weak, nonatomic) IBOutlet UILabel *availabilityLabelParse2;

@property (weak, nonatomic) IBOutlet UILabel *rateLabelParse2;


//Array for other profiles
@property (nonatomic, strong) NSMutableArray * searchResultsForProfile;


@property (nonatomic,strong) NSString * whatProfileToLoad;

//Link for SHOWCASE

@property (nonatomic) NSString * link;

#define   IsIphone5     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define   IsIphone6     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
#define   IsIphone6plus     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )


@end