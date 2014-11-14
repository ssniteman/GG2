
//  ProfileViewController.m

//  SidebarDemo

#import "ProfileViewController.h"
#import "SWRevealViewController.h"
#import "EditProfileViewController.h"
#import "QueryResultsTVC.h"
#import <Parse/Parse.h>
#import "Showcase.h"

// WIDTH & HEIGHT

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface ProfileViewController () 

@end

@implementation ProfileViewController {
    
    UIButton * theProfilePicture;
    UILabel * nameLabel ;
    UILabel * genreLabel;
    UIImage *profileImage;
    UILabel * stateLabel;
    
    UILabel * rateLabelParse;
    
    UILabel * availabilityLabelParse;

    
    PFUser * user;
}


// Added view will appear... because the view did load would set the view once on the reveal button... view will appear runs again once the view is called


- (void)viewWillAppear:(BOOL)animated {
   user = [PFUser currentUser];
    
    NSLog(@"TYPE %@",user.username);
    
        if ([user[@"userType"] isEqualToString:@"musician"]) {
            
            self.barUIView.hidden = TRUE;
            
        } else {
            self.barUIView.hidden = FALSE;
        }
        
    
    
   
            
    [super viewDidLoad];
    
    //LEFT MENU BUTTON
    
    SWRevealViewController *revealController = [self revealViewController];
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu3.png"]style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    
    revealButtonItem.tintColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    
    
    //Position for the Photos Button
   
    self.photosButton.frame = CGRectMake(10, SCREEN_HEIGHT-125, 95, 95);

    //Position for the Sound Button
    
    self.soundButton.frame = CGRectMake(SCREEN_WIDTH/2.0-47.5, SCREEN_HEIGHT-125, 95, 95);
   
    //Position for the video Button
    
    self.videoButton.frame = CGRectMake(SCREEN_WIDTH-105, SCREEN_HEIGHT-125, 95, 95);
     
    
 // TOP VIEW BACKGROUND
    
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 150)];
    topView.backgroundColor =  [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    [self.view addSubview:topView];
    
 //Setting the profile picture to be round
    
    theProfilePicture = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-90, 80, 180, 180)];
    
    if (user[@"image"] == nil) {
    
    profileImage = [UIImage imageNamed:@"avatarcopy.jpg"];
    
    [theProfilePicture setBackgroundImage:profileImage forState:UIControlStateNormal];

    
    } else {
        [theProfilePicture setBackgroundImage:profileImage forState:UIControlStateNormal];

        // Image coming back from Parse
        
        PFFile *imageFile = user[@"image"];
        
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            
            UIImage * image = [UIImage imageWithData:data];
            [theProfilePicture setBackgroundImage:image forState:UIControlStateNormal];
        }];
    }
    
    theProfilePicture.layer.cornerRadius = 90;
    theProfilePicture.userInteractionEnabled = false;
    theProfilePicture.clipsToBounds = YES;
    
// NAME LABEL
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, topView.bounds.size.height-140, 200, 21)];
    [nameLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:20]];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    
    

    NSLog(@"TYPE: %@",user[@"userType"] );
    
    if ([user[@"userType"] isEqual:@"musician"] && ([user[@"bandName"] length] <= 0)) {
    
        nameLabel.text = @"Your Band Name";
        
    } else if ([user[@"userType"] isEqual:@"musician"] &&  [user[@"bandName"] length] > 0){
    
        nameLabel.text = user[@"bandName"];
    
    } else if ([user[@"userType"] isEqual:@"bar"] &&  [user[@"barName"] length] <= 0) {
    
        nameLabel.text = @"Bar/Venue Name";

    } else if ([user[@"userType"] isEqual:@"bar"] &&  [user[@"barName"] length] > 0){
    
        nameLabel.text = user[@"barName"];

    }

    
// Genre LABEL
    
    genreLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, topView.bounds.size.height-115, 200, 21)];
    [genreLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20]];
    
    genreLabel.textColor = [UIColor whiteColor];
    genreLabel.textAlignment = NSTextAlignmentCenter;
    
    if ([user[@"genre"] length] <= 0) {
        genreLabel.text = @"Genre";
    } else {
        genreLabel.text = user[@"genre"];
    }
    

 // City & State LABEL
    
    stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, topView.bounds.size.height-90, 200, 21)];
    [stateLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20]];
    
    stateLabel.textColor = [UIColor whiteColor];
    stateLabel.textAlignment = NSTextAlignmentCenter;
    
    if ([user[@"city"] length] <= 0) {
        
        stateLabel.text = @"City, State";
    } else {
    
    stateLabel.text = [NSString stringWithFormat:@"%@, %@",user[@"city"],user[@"state"]];
    
    }
        
    [topView addSubview:nameLabel];
    [topView addSubview:genreLabel];
    [topView addSubview:stateLabel];
    
    [topView addSubview:theProfilePicture];
    
    // Rate Label Parse
    
    rateLabelParse = [[UILabel alloc] initWithFrame:CGRectMake(topView.bounds.size.width - 115, topView.bounds.size.height - 30, 100, 20)];
    [rateLabelParse setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
    rateLabelParse.textColor = [UIColor whiteColor];
    rateLabelParse.textAlignment = NSTextAlignmentCenter;
    
    rateLabelParse.text = user[@"nightlyRate"];
    
    [topView addSubview:rateLabelParse];
    
    
    // Availability Label Parse
    
    availabilityLabelParse = [[UILabel alloc] initWithFrame:CGRectMake(10, topView.bounds.size.height - 30, 100, 20)];
    [availabilityLabelParse setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];

    availabilityLabelParse.textColor = [UIColor whiteColor];
    availabilityLabelParse.textAlignment = NSTextAlignmentCenter;
    
    availabilityLabelParse.text = user[@"availability"];
    
    [topView addSubview:availabilityLabelParse];
    [topView addSubview:self.rateLabel];
    [topView addSubview:self.availabilityLabel];

    
}


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


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"web"])
    {
        Showcase *webController = segue.destinationViewController;
        webController.link = self.link;
        
    }
}


- (IBAction)soundcloudButton:(id)sender {
    self.link = [NSString stringWithFormat:@"https://www.soundcloud.com/%@", user[@"soundcloud"]];
    
    [self performSegueWithIdentifier:@"web" sender:self];
}



- (IBAction)facebookButton:(id)sender {
    
}



- (IBAction)instagramButton:(id)sender {
    self.link = [NSString stringWithFormat:@"https://www.instagram.com/%@", user[@"instagram"]];
    
    [self performSegueWithIdentifier:@"web" sender:self];
}

- (IBAction)messageButton:(id)sender {
}
- (IBAction)youTube:(id)sender {
    self.link = [NSString stringWithFormat:@"https://www.youtube.com/user/%@", user[@"youtube"]];
    
    [self performSegueWithIdentifier:@"web" sender:self];
    
    
}

- (IBAction)barInstagram:(id)sender {
    
    self.link = [NSString stringWithFormat:@"https://www.instagram.com/%@", user[@"instagram"]];
    
    [self performSegueWithIdentifier:@"web" sender:self];
}

- (IBAction)barFacebook:(id)sender {
    self.link = [NSString
                 //doublecheck this URL For Facebook
                 stringWithFormat:@"https://www.facebook.com/%@", user[@"facebook"]];
    
    [self performSegueWithIdentifier:@"web" sender:self];
}

- (IBAction)barTwitter:(id)sender {
    self.link = [NSString stringWithFormat:@"https://www.twitter.com/%@", user[@"twitter"]];
    
    [self performSegueWithIdentifier:@"web" sender:self];
}
@end