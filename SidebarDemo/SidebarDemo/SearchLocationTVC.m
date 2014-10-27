//
//  SearchLocationTVC.m
//  SidebarDemo
//
//  Created by Shane Sniteman on 10/2/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "SearchLocationTVC.h"
#import "SearchViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <Parse/Parse.h>

#import <CoreLocation/CoreLocation.h>



@interface SearchLocationTVC ()<UITableViewDataSource,UITableViewDelegate, UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate, UITextFieldDelegate>

@end

@implementation SearchLocationTVC {
    
    // Location
    
    NSDictionary * location;
    NSDictionary * city;
    NSDictionary * state;

    
    double latitude;
    double longitude;
    
    GMSMapView *mapView_;
    NSMutableArray * radiusMiles;
    
    PFGeoPoint * currentGeoPoint;
    
    NSString * radius;
    
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return  1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return radiusMiles.count;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 120;
    
    return sectionWidth;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    
    return [NSString stringWithFormat:@"%@ Miles",[radiusMiles objectAtIndex:row]];

    
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    
    self.radiusLabel.text = [NSString stringWithFormat:@"%@ Miles",  radiusMiles[row]];
    
    NSLog(@"%@",radiusMiles[row]);
    radius = radiusMiles[row];

    
    NSLog(@"WIDTH: %f , HEIGHT:  %f",self.radiusPicker.bounds.size.width,self.radiusPicker.bounds.size.height);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //RIGHT MENU BUTTON
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveButton)];
    
    [saveButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0], NSFontAttributeName,
                                        [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f], NSForegroundColorAttributeName,
                                        nil]
                              forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = saveButton;
    
    
    //    saveButton.tintColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    //Left MENU BUTTON
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButton)];
    
    [cancelButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0], NSFontAttributeName,
                                          [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f], NSForegroundColorAttributeName,
                                          nil]
                                forState:UIControlStateNormal];
    
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    //    cancelButton.tintColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    self.tableView.delegate = self;
    self.tableView.dataSource =self;

    radiusMiles=[@[@"5",@"10",@"15",@"20",@"25",@"35",@"50",@"75",@"100",@"150",@"250",@"500"]mutableCopy];
    
    
    
    CGSize pickerSize = [self.radiusPicker sizeThatFits:CGSizeZero];
    
    UIView * pickerTransformView= [[UIView alloc] initWithFrame:CGRectMake(2.0f, 2.0f, pickerSize.width, pickerSize.height)];
    
    pickerTransformView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [pickerTransformView addSubview:self.radiusPicker];
 
    self.radiusPicker.delegate = self;
    self.radiusPicker.dataSource =self;
    
    
    NSLog(@"WIDTH: %f , HEIGHT:  %f",self.radiusPicker.bounds.size.width,self.radiusPicker.bounds.size.height);
    
    self.radiusPicker.showsSelectionIndicator = YES;
    self.radiusPicker.transform = CGAffineTransformMakeScale(0.95f, 0.95f);
    
    [self.radiusCell addSubview:pickerTransformView];
    
    if ([self.searchZip.text isEqual:@""]) {
        
        [self.changeZip setHidden:YES];
        [self.enterZipButton setHidden:NO];

    } else {
        self.changeZip.hidden = NO;
        self.enterZipButton.hidden = YES;

    }
 
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 3;
}


- (IBAction)changeZip:(id)sender {
   
    self.searchZip.text = @"";
    self.enterZipButton.hidden = NO;
    self.changeZip.hidden = YES;
}


- (IBAction)enterZipButton:(id)sender {
    
    self.enterZipButton.hidden = YES;
    self.changeZip.hidden = NO;
    
    NSString * urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=true",self.searchZip.text];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLResponse * response = nil;
    
    NSError * error = nil;
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSDictionary *resultsInfo = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    
    NSDictionary * address =resultsInfo[@"results"][0];
    
    self.searchZip.text =address[@"formatted_address"];
    
    NSDictionary * LatAndLong =resultsInfo[@"results"][0][@"geometry"][@"location"];
    
    NSLog(@"lat %@, long %@",LatAndLong[@"lat"],LatAndLong[@"lng"]);
    
    city = resultsInfo[@"results"][0][@"address_components"][1][@"long_name"];
    
    NSLog(@"the city is %@",city);
    
    state = resultsInfo[@"results"][0][@"address_components"][3][@"short_name"];
    
    NSLog(@"state is %@",state);
    
    
    [self.delegate setLatitudeSetter:[LatAndLong[@"lat"]doubleValue]];
    [self.delegate setLongitudeSetter:[LatAndLong[@"lng"]doubleValue]];

}

- (IBAction)currentLocationSwitch:(id)sender {
    
    
    if (self.currentLocationSwitchOutlet.on) {
        
        NSLog(@"Hey");
        
        [self.enterZipButton setHidden:YES];
        self.changeZip.hidden = NO;
        
        [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
            
            NSLog(@"Hello");
            
            NSLog(@"%@",geoPoint);
            currentGeoPoint = geoPoint;
            
            [self.delegate setLatitudeSetter:geoPoint.latitude];
            [self.delegate setLongitudeSetter:geoPoint.longitude];

            self.searchZip.text =[self getAddressFromLatLon:geoPoint.latitude withLongitude:geoPoint.longitude];
            if (!error) {
                
            }
        }];

    } else{
        self.searchZip.text =@"";
        self.enterZipButton.hidden = NO;
        self.changeZip.hidden = YES;
    }
}


-(NSString *)getAddressFromLatLon:(double)currentLatitude withLongitude:(double)currentLongitude
{
    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f",currentLatitude, currentLongitude];
    
    currentGeoPoint = [PFGeoPoint geoPointWithLatitude:currentLatitude longitude:currentLongitude];
    
    NSLog(@"%@",urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLResponse * response = nil;
    
    NSError * error = nil;
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSDictionary * resultsInfo = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    
    NSLog(@"%@",resultsInfo);
    
    NSDictionary * address = resultsInfo[@"results"][0];
    NSLog(@"%@",address);
    
    return address[@"formatted_address"];
}

- (IBAction)changeRadiusButton:(id)sender {
    
    self.radiusCell.hidden = true;
    [self.tableView reloadData];
}

- (void)saveButton {
    
    [self.delegate setSavedFormatAddress:self.searchZip.text];
    
    // set saved radius is a nsnumber, radius WAS a string until now bitch
    
    [self.delegate setSavedRadius:@([radius intValue])];
    
    [self.navigationController popViewControllerAnimated:YES];

}


-(void) cancelButton{
    [self.navigationController popViewControllerAnimated:YES];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}



@end
