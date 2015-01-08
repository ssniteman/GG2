//
//  EditProfileViewController.m
//  SidebarDemo
//
//  Created by Shane Sniteman on 9/7/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "EditProfileViewController.h"
#import "ProfileViewController.h"
#import "SWRevealViewController.h"
#import "AvailabilityTVC.h"
#import "EditGenreTVC.h"
#import <Parse/Parse.h>
#import <GoogleMaps/GoogleMaps.h>
#import <Accelerate/Accelerate.h>
#import "EditRateVC.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "Showcase.h"

@interface EditProfileViewController ()<UITableViewDataSource,UITableViewDelegate, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AvailableTVCDelegate, RateDelegate, GenreTVCDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableViewCell *availabilityCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *editGenreCell;
@property (weak, nonatomic) IBOutlet UITextField *nameCell;
@property (weak, nonatomic) IBOutlet UIView *rateCell;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
//SHOWCASE

@property (weak, nonatomic) IBOutlet UITextField *photosTextField;
@property (weak, nonatomic) IBOutlet UITextField *soundTextField;
@property (weak, nonatomic) IBOutlet UITextField *videosTextField;

@end

@implementation EditProfileViewController {
   
    UIImagePickerController * picker;
    UIImage *image;
    
    NSDictionary * location;
    
    double latitude;
    double longitude;
    
    NSDictionary * address;
    
    NSDictionary * city;
    
    NSDictionary * state;


}

// RATE SETTER

-(void)setRate:(NSString *)rate{
    _rate = rate;
    
    self.rateLabel.text = self.rate;
}


// AVAILABILITY SETTER

-(void)setDaysAvailable:(NSString *)daysAvailable {
    _daysAvailable = daysAvailable;
  
    self.daysAvailableLabel.text = daysAvailable;
    
}


-(void)setGenreString:(NSString *)genreString{
    _genreString = genreString;
    
    self.genreLabel.text = genreString;
    
    NSLog(@"this is %@", genreString);
}
    

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PFUser * user = [PFUser currentUser];
    
    if ([user[@"userType"] isEqualToString:@"musician"]) {
        
        self.facebookView.hidden = TRUE;
        self.twitterView.hidden = TRUE;
        self.photosLabel.text =@"Photos";
    
    }
    
    else {
        self.facebookView.hidden = FALSE;
        self.twitterView.hidden = FALSE;
        self.photosLabel.text =@"Instagram";

    }
    
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(editSaveButton)];

    //RIGHT MENU BUTTON
    
    [saveButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                              [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0], NSFontAttributeName,
                                              [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f], NSForegroundColorAttributeName,
                                              nil]
                                    forState:UIControlStateNormal];
    
    
    self.navigationItem.rightBarButtonItem = saveButton;
    

//    if ([self.zipTextBox.text isEqualToString:@""]) {
//        self.changeZipButton.hidden = YES;
//        self.zipButton.hidden = NO;
//    } else {
//        self.changeZipButton.hidden = NO;
//        self.zipButton.hidden = YES;
//        
//    }
    
    
    
    if ([self.zipTextBox.text isEqual:@""]) {
        
        [self.changeZipButton setHidden:YES];
        [self.zipButton setHidden:NO];
        
    } else {
        [self.changeZipButton setHidden:NO];
        self.zipButton.hidden = YES;
        
    }
    
    
    
    
    
    
    
    user = [PFUser currentUser];
   
    self.nameCell.text = user[@"bandName"];
    self.zipTextBox.text = user[@"zip"];
    self.genreLabel.text = user[@"genre"];
    self.rateLabel.text = user[@"nightlyRate"];
    self.daysAvailableLabel.text = user[@"availability"];
    
    if ([user[@"userType"] isEqualToString:@"musician"]) {
        
        self.nameCell.text = user[@"bandName"];
        self.photosTextField.text = user[@"instagram"];
        self.soundTextField.text = user[@"soundcloud"];
        self.videosTextField.text = user[@"youtube"];
        
    } else {
        self.nameCell.text = user[@"bandName"];
        self.photosTextField.text = user[@"instagram"];
        self.facebookTextField.text = user[@"facebook"];
        self.twitterTextField.text = user[@"twitter"];
        
    }
    

    
    [user saveInBackground];
    
    PFFile *imageFile = user[@"image"];
    
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        
        NSLog(@"data loaded");
        
        UIImage * image = [UIImage imageWithData:data];
        self.editImageView.image = image;

    }];

    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    
    
    SWRevealViewController *revealController = [self revealViewController];
    
    //[self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
    
    
    
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu3.png"]style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    
    revealButtonItem.tintColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];

    
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;

}


- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    UITableViewCell *theCellClicked = [self.tableView cellForRowAtIndexPath:indexPath];
    if (theCellClicked == self.availabilityCell) {
    
        AvailabilityTVC * openAvailability = [[AvailabilityTVC alloc] init];
    
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:openAvailability];
        
        openAvailability.delegate = self;

        [self.navigationController pushViewController:openAvailability animated:YES];
        
    } else if (theCellClicked == self.editGenreCell) {
    
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"genre" bundle: nil];
        
        EditGenreTVC * editGenre = [storyboard instantiateViewControllerWithIdentifier:@"editGenreID"];
        
        editGenre.delegate = self;
        
        [self.navigationController pushViewController:editGenre animated:YES];

    } else if (theCellClicked == self.rateCell) {
        
        EditRateVC * editRate = [[EditRateVC alloc] init];
        
        editRate.delegate = self;
        
        [self.navigationController pushViewController:editRate animated:YES];
        
    }
    
}


- (IBAction)changeZipButton:(id)sender {
    
    self.zipTextBox.text = @"";
    self.changeZipButton.hidden = YES;
    self.zipButton.hidden = NO;

//    if ([self.zipTextBox.text isEqual:@""]) {
//       
//        self.changeZipButton.hidden = YES;
//        self.zipButton.hidden = NO;
//    } else {
//        
//        self.zipButton.hidden = YES;
//        self.changeZipButton.hidden = NO;
//        
//    }
    
    
}

- (IBAction)zipButton:(id)sender {
    if ([self.zipTextBox.text length]>0) {
        NSString * urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=true",self.zipTextBox.text];
        
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        NSURLResponse * response = nil;
        
        NSError * error = nil;
        NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        NSDictionary *resultsInfo = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
        
        address =resultsInfo[@"results"][0];
        
        city = resultsInfo[@"results"][0][@"address_components"][1][@"long_name"];
        
        NSLog(@"the city is %@",city);
        
        state = resultsInfo[@"results"][0][@"address_components"][3][@"short_name"];
        
        NSLog(@"state is %@",state);
        
        location = resultsInfo[@"results"][0][@"geometry"][@"location"];
        
        NSLog(@"lat %@, long %@",location[@"lat"],location[@"lng"]);
        
        latitude =[location[@"lat"]doubleValue];
        
        longitude = [location[@"lng"]doubleValue];
        
        self.zipTextBox.text = address[@"formatted_address"];
        
        self.zipButton.hidden = YES;
        self.changeZipButton.hidden = NO;
        
        PFUser * user = [PFUser currentUser];

        
            PFGeoPoint * point = [PFGeoPoint geoPointWithLatitude:latitude longitude:longitude];
        
            user[@"location"] = point;
            user[@"city"] = city;
            user[@"state"] = state;
            user[@"zip"] = self.zipTextBox.text;

    }
    
    [self.view endEditing:YES];


    
}

-(void)editSaveButton {
    
    PFUser * user = [PFUser currentUser];
    
    
    if ([user[@"userType"] isEqualToString:@"musician"]) {
        user[@"bandName"] = self.nameCell.text;
        user[@"instagram"] = self.photosTextField.text;
        user[@"soundcloud"] = self.soundTextField.text;
        user[@"youtube"] = self.videosTextField.text;
        
        
        NSLog(@" photo: %@ sound: %@ video: %@",self.photosTextField.text, self.soundTextField.text,self.videosTextField.text);
        
        [[PFUser currentUser] saveInBackground];
    } else {
        user[@"bandName"] = self.nameCell.text;
        user[@"instagram"] = self.photosTextField.text;
        user[@"facebook"] = self.facebookTextField.text;
        user[@"twitter"] = self.twitterTextField.text;
        
        
        NSLog(@" photo: %@ sound: %@ video: %@",self.photosTextField.text, self.soundTextField.text,self.videosTextField.text);
        
        [[PFUser currentUser] saveInBackground];
    }
    
    
    
//    [self.navigationController popViewControllerAnimated:YES];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboardTwo" bundle: nil];
    ProfileViewController * profileView = [storyboard instantiateViewControllerWithIdentifier:@"profileView"];
    [self.navigationController pushViewController:profileView animated:YES];
  
}

- (IBAction)editPhotoButton:(id)sender {
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select Photo option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Take Photo",
                            @"Choose Existing",
                            nil];
    popup.tag = 1;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
    
    
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    
                    if ([UIImagePickerController isSourceTypeAvailable:
                         UIImagePickerControllerSourceTypeCamera])
                    {
                        UIImagePickerController *imagePicker =
                        [[UIImagePickerController alloc] init];
                        imagePicker.delegate = self;
                        imagePicker.sourceType =
                        UIImagePickerControllerSourceTypeCamera;
                        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
                        imagePicker.allowsEditing = NO;
                        [self presentViewController:imagePicker animated:YES completion:nil];
                        _newMedia = YES;
                    }
                    break;
                case 1:
                    [self pickImage];
                    
                    break;
                    
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        image = info[UIImagePickerControllerOriginalImage];
        
        self.editImageView.image = image;
        
        if (_newMedia)
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
        
        
        NSData *imageData = UIImagePNGRepresentation(image);
        PFFile *imageFile = [PFFile fileWithData:imageData];
        
        PFUser * user = [PFUser currentUser];
        user[@"image"] = imageFile;
        [user saveInBackground];
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
    
    
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void) pickImage {
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentModalViewController:picker animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}


@end
