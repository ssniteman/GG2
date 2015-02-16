//
//  SearchResultsProfileViewController.m
//  SidebarDemo
//
//  Created by Shane Sniteman on 10/8/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "SearchResultsProfileViewController.h"
#import "QueryResultsTVC.h"
#import "SearchResultsProfileViewController.h"
#import "ComposeMessageTVC.h"
#import <Parse/Parse.h>

#import "Showcase.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface SearchResultsProfileViewController () 

@end

@implementation SearchResultsProfileViewController {

UIButton * theProfilePicture;
UILabel * nameLabel;
UILabel * genreLabel;
UIImage *profileImage;
UILabel * stateLabel;

UIButton * messageButton;
//PFUser * user;
    
    NSDictionary * address;
    
    PFUser * user;

    
}
-(void)setSearchResultsForProfile:(NSMutableDictionary *)searchResultsForProfile {
    
    _searchResultsForProfile = searchResultsForProfile;
    
    NSLog(@"Other Users Content%@",searchResultsForProfile);
    
    
    address =[@{}mutableCopy];
    
    address = self.searchResultsForProfile[@"bandName"];
    
    self.testlabel.text =@"hello";

    NSLog (@"%@",self.searchResultsForProfile[@"bandName"]);
    
    // TOP VIEW BACKGROUND
    
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -150)];
    topView.backgroundColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    [self.view addSubview:topView];
    
    // Setting Profile Picture
 
    //Setting the profile picture to be round
    

    NSLog(@"TYPE %@",user.username);
    
    if ([self.searchResultsForProfile[@"userType"] isEqualToString:@"musician"]) {
        
        self.barView.hidden = TRUE;
        
    } else {
        self.barView.hidden = FALSE;
    }
    

    
    
    if (IsIphone5 || IsIphone6 || IsIphone6plus) {
        
        theProfilePicture = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-90, 80, 180, 180)];
        theProfilePicture.layer.cornerRadius = 90;
        
    } else {
        
        theProfilePicture = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-60, 60, 120, 120)];
        theProfilePicture.layer.cornerRadius = 60;
        
        
        
    }
    
    
    if (searchResultsForProfile[@"image"] == nil) {
        
        profileImage = [UIImage imageNamed:@"avatarcopy.jpg"];
        
        [theProfilePicture setBackgroundImage:profileImage forState:UIControlStateNormal];
        
        
    } else {
    
    
        [theProfilePicture setBackgroundImage:profileImage forState:UIControlStateNormal];
        
        // Image coming back from Parse
        
        PFFile *imageFile = searchResultsForProfile[@"image"];
        
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            
            UIImage * image = [UIImage imageWithData:data];
            [theProfilePicture setBackgroundImage:image forState:UIControlStateNormal];
        }];

    
    }
    
    theProfilePicture.userInteractionEnabled = false;
    theProfilePicture.clipsToBounds = YES;
    
    
    
    // NAME LABEL
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, topView.bounds.size.height-140, 200, 21)];
    [nameLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:20]];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = searchResultsForProfile[@"bandName"];
    
    // Genre LABEL
    
    genreLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, topView.bounds.size.height-115, 200, 21)];
    [genreLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20]];
    genreLabel.textColor = [UIColor whiteColor];
    genreLabel.textAlignment = NSTextAlignmentCenter;
    
    if ([searchResultsForProfile[@"genre"] length] <= 0) {
        genreLabel.text = @"Genre";
    } else {
        genreLabel.text = searchResultsForProfile[@"genre"];
    }
    
    //City & State LABEL
    
    stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, topView.bounds.size.height-90, 200, 21)];
    [stateLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20]];
    
    stateLabel.textColor = [UIColor whiteColor];
    stateLabel.textAlignment = NSTextAlignmentCenter;
    
    if ([searchResultsForProfile[@"city"] length] <= 0) {
        
        stateLabel.text = @"City, State";
    } else {
        
        stateLabel.text = [NSString stringWithFormat:@"%@, %@",searchResultsForProfile[@"city"],searchResultsForProfile[@"state"]];
        
    }
    
    
    [topView addSubview:nameLabel];
    [topView addSubview:genreLabel];
    [topView addSubview:stateLabel];
    [topView addSubview:theProfilePicture];

    
    // MESSAGE BUTTON
    
    messageButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, topView.bounds.size.height-50, 200, 35)];
    [messageButton setTitle:@"Message" forState:UIControlStateNormal];
    [messageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    messageButton.layer.borderColor = [UIColor whiteColor].CGColor;
    messageButton.layer.cornerRadius = 5;
    messageButton.layer.borderWidth = .5;
    [messageButton.titleLabel setTextAlignment:UITextAlignmentCenter];
    [messageButton addTarget:self action:@selector(sendMessageTapped) forControlEvents:UIControlEventTouchUpInside];
    [messageButton setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16]];

    [self.view addSubview:messageButton];

}

    // MESSAGE BUTTON ACTION

-(void)sendMessageTapped {
    
// if you alloc init, you have to do the setter method... but below, we only are showing a new view, not making a new one so we don't have to pass info
    
//    ComposeMessageTVC * newMessage = [[ComposeMessageTVC alloc]init];
//    newMessage.toWhomWeSendString = self.searchResultsForProfile[@"bandName"];
    
    NSLog(@"the band name is %@", self.searchResultsForProfile[@"bandName"]);
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"composeMessage" bundle: nil];
    
    ComposeMessageTVC * composeTVC = [storyboard instantiateViewControllerWithIdentifier:@"composeNew"];
    
    composeTVC.toUser = self.searchResultsForProfile;
    composeTVC.toWhomWeSendString =self.searchResultsForProfile[@"bandName"];
    
    
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:composeTVC];
    
    //now present this navigation controller modally
    [self presentViewController:navigationController animated:YES completion:nil];
    
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    self.profilePicture.layer.cornerRadius = 90;
    self.profilePicture.userInteractionEnabled = false;
    self.profilePicture.clipsToBounds = YES;
    
    
    //***************************************************** FIX
    
    
    //RIGHT MENU BUTTON   SLIDER INFO
    
    //    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(editProfileButtonTickled)];
    //
    //    self.navigationItem.rightBarButtonItem = editButton;
    
    
    //***************************************************** FIX
    

    
    //Position for the Photos Button
    //
    self.photosButton.frame = CGRectMake(10, SCREEN_HEIGHT-125, 95, 95);
    
    //Position for the Sound Button
    //
    self.soundButton.frame = CGRectMake(SCREEN_WIDTH/2.0-47.5, SCREEN_HEIGHT-125, 95, 95);
    
    //Position for the video Button
    
    self.videoButton.frame = CGRectMake(SCREEN_WIDTH-105, SCREEN_HEIGHT-125, 95, 95);


}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"web"])
    {
        Showcase *webController = segue.destinationViewController;
        webController.link = self.link;
        
    }
}

- (IBAction)instagramButton:(id)sender {
    
    
    
}
- (IBAction)instagramAction:(id)sender {
    
}

- (IBAction)facebookAction:(id)sender {
    self.link = [NSString stringWithFormat:@"https://www.facebook.com/%@", self.searchResultsForProfile[@"facebook"]];
    
    [self performSegueWithIdentifier:@"web" sender:self];
    
}
- (IBAction)twitterAction:(id)sender {
    
}



- (IBAction)photoAction:(id)sender {
    
}

- (IBAction)soundAction:(id)sender {
    
}

- (IBAction)youtubeAction:(id)sender {
    
}
@end
