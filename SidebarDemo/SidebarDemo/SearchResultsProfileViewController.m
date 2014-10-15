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
    topView.backgroundColor = [UIColor colorWithRed:0.753f green:0.251f blue:0.208f alpha:1.0f];
    [self.view addSubview:topView];
    
    //Setting the profile picture to be round
    
    theProfilePicture = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-70, 90, 140, 140)];
    profileImage = [UIImage imageNamed:@"avatarcopy.jpg"];
    [theProfilePicture setBackgroundImage:profileImage forState:UIControlStateNormal];
    
    // Image coming back from Parse
    
    PFFile *imageFile = searchResultsForProfile[@"image"];
    
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        
        UIImage * image = [UIImage imageWithData:data];
        [theProfilePicture setBackgroundImage:image forState:UIControlStateNormal];
        
        
    }];
    
    theProfilePicture.layer.cornerRadius = 70;
    theProfilePicture.userInteractionEnabled = false;
    theProfilePicture.clipsToBounds = YES;
    
    
    // BAND NAME LABEL
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, topView.bounds.size.height-100, 200, 21)];
    [nameLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:20]];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = searchResultsForProfile[@"bandName"];
    
    // Genre LABEL
    
    genreLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, topView.bounds.size.height-75, 200, 21)];
    [genreLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20]];
    genreLabel.textColor = [UIColor whiteColor];
    genreLabel.textAlignment = NSTextAlignmentCenter;
    genreLabel.text = searchResultsForProfile[@"genre"];
    
    //City & State LABEL
    
    stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, topView.bounds.size.height-50, 200, 21)];
    [stateLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20]];
    
    stateLabel.textColor = [UIColor whiteColor];
    stateLabel.textAlignment = NSTextAlignmentCenter;
    stateLabel.text = @"City, State";
    
    [topView addSubview:nameLabel];
    [topView addSubview:genreLabel];
    [topView addSubview:stateLabel];
    
    [topView addSubview:theProfilePicture];
    
    
    // MESSAGE BUTTON
    
    messageButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 300, 100, 30)];
    messageButton.backgroundColor = [UIColor grayColor];
    [messageButton setTitle:@"Message" forState:UIControlStateNormal];

    [messageButton addTarget:self action:@selector(sendMessageTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:messageButton];

}

    // MESSAGE BUTTON ACTION

-(void)sendMessageTapped {
    
    ComposeMessageTVC * newMessage = [[ComposeMessageTVC alloc]init];
    
    newMessage.toWhomWeSendString = self.searchResultsForProfile[@"bandName"];
    
    NSLog(@"%@", self.searchResultsForProfile[@"bandName"]);
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"composeMessage" bundle: nil];
    
    ComposeMessageTVC * composeTVC = [storyboard instantiateViewControllerWithIdentifier:@"composeNew"];
    
    composeTVC.toUser = self.searchResultsForProfile;
    
    
    
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:composeTVC];
    
    //now present this navigation controller modally
    [self presentViewController:navigationController animated:YES completion:nil];
    
}



- (void)viewDidLoad {
    
    // TRIED BOOL VALUE... EPIC FAILURE
    
//    user = [PFUser currentUser];
    //    NSLog(self.whatProfileToLoad ? @"VIEW DID LOAD Yes" : @" VIEW DID LOAD No");
    //    self.whatProfileToLoad = YES;
    
    //    self.messageButton.hidden = TRUE;
    
    //    if (self.whatProfileToLoad==FALSE) {
    //        // nameLabel.text = user[@"bandName"];
    //
    //
    //    }else{
    //        // nameLabel.text = user[@"bandName"];
    //        self.messageButton.hidden = FALSE;
    //
    //    }
    
    
    [super viewDidLoad];
   
    
    //***************************************************** FIX
    
    
    //RIGHT MENU BUTTON   SLIDER INFO
    
    //    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(editProfileButtonTickled)];
    //
    //    self.navigationItem.rightBarButtonItem = editButton;
    
    
    //***************************************************** FIX
    
    
    //Position for the Photos Button
    
    self.photosButton.frame = CGRectMake(10, SCREEN_HEIGHT-105, 95, 95);
    self.photosButton.backgroundColor = [UIColor colorWithRed:0.753f green:0.251f blue:0.208f alpha:1.0f];
    
    
    
    //Position for the Sound Button
    
    self.soundButton.frame = CGRectMake(SCREEN_WIDTH/2.0-47.5, SCREEN_HEIGHT-105, 95, 95);
    self.soundButton.backgroundColor = [UIColor colorWithRed:0.753f green:0.251f blue:0.208f alpha:1.0f];
    
    
    
    //Position for the video Button
    
    self.videoButton.frame = CGRectMake(SCREEN_WIDTH-105, SCREEN_HEIGHT-105, 95, 95);
    self.videoButton.backgroundColor = [UIColor colorWithRed:0.753f green:0.251f blue:0.208f alpha:1.0f];
    
    

//- (void)editProfileButtonTickled {
//
//    EditProfileViewController * editProfileSegue = [[EditProfileViewController alloc] init];
//
//    [self.navigationController pushViewController:editProfileSegue animated:YES];
//
//
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboardTwo" bundle: nil];
//
//    EditProfileViewController * editProfile = [storyboard instantiateViewControllerWithIdentifier:@"editProfileID"];
//
//    [self presentViewController:editProfile animated:YES completion:nil];
//
//}
    
    

    

}

- (IBAction)soundcloudButton:(id)sender {
    
}



- (IBAction)facebookButton:(id)sender {
    
}



- (IBAction)instagramButton:(id)sender {
    
}

- (IBAction)messageButton:(id)sender {
}
@end
