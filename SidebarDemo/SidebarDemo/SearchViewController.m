//
//  SearchViewController.m
//  SidebarDemo
//
//  Created by Shane Sniteman on 9/7/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "SearchViewController.h"
#import "SWRevealViewController.h"
#import "SearchGenreTVC.h"
#import "SearchAvailabilityTVC.h"
#import "SearchLocationTVC.h"
#import "SearchRateVC.h"
#import "QueryResultsTVC.h" 
#import <Parse/Parse.h>



@interface SearchViewController () <SearchGenreTVCDelegate, SearchAvailabilityTVCDelegate, SearchLocationTVCDelegate, SearchRateVCDelegate, UITextFieldDelegate>

@end

@implementation SearchViewController {
   
    UISegmentedControl * searchSegmentControl;
    UIView * locationSearch;
    UIButton * searchLocationButton;
    UIView * genreSearch;
    UIButton * genreSearchButton;
    UIView * availabilitySearch;
    UIButton * searchButton;
    UIButton * availabilitySearchButton;
    UIView * rateSearch;
    UIButton * rateSearchButton;
    UILabel * genreSearchs;
    UILabel * rateSearchs;
    UILabel * locationSearchs;
    UILabel * availabilitySearchs;
    
    UIView * line;
    
    UIButton * searchArrow;
    
    PFGeoPoint * currentGeoPoint;
    
}


// NIGHTLY OR HOURLY

-(void)setNightlyOrHourly:(BOOL)nightlyOrHourly {
    _nightlyOrHourly = nightlyOrHourly;
    

    if (self.nightlyOrHourly==TRUE) {
        NSLog(@"Nightly");
    } else {
        NSLog(@"Hourly");

    }
}

// LOCATION SETTER

-(void)setSavedFormatAddress:(NSString *)savedFormatAddress {
    
    _savedFormatAddress = savedFormatAddress;
    
    locationSearchs.text = self.savedFormatAddress;
    
}

-(void)setLatitudeSetter:(double)latitudeSetter {
    
    _latitudeSetter = latitudeSetter;
}

-(void)setLongitudeSetter:(double)longitudeSetter {
    
    _longitudeSetter = longitudeSetter;
    
}

-(void)setSavedRadius:(NSNumber *)savedRadius {
    
    _savedRadius = savedRadius;
}

// GENRES SETTER


- (void)setSearchArrayGenres:(NSMutableArray *)searchArrayGenres {
    _searchArrayGenres = searchArrayGenres;
}

- (void)setSavedSearchGenres:(NSString *)savedSearchGenres {
    
    _savedSearchGenres = savedSearchGenres;
    
    availabilitySearchs.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
    genreSearchs.textColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    genreSearchs.text = savedSearchGenres;

}

// AVAILABILITY SETTER

-(void)setSearchArrayAvailability:(NSMutableArray *)searchArrayAvailability{
    _searchArrayAvailability = searchArrayAvailability;
    
}

- (void)setSavedSearchAvailability:(NSString *)savedSearchAvailability {
    
    _savedSearchAvailability = savedSearchAvailability;

    availabilitySearchs.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
    availabilitySearchs.textColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    availabilitySearchs.text = savedSearchAvailability;
    
}

// RATE SETTER

- (void)setSavedRateSetter:(NSNumber *)savedRateSetter {
    
    _savedRateSetter = savedRateSetter;
    
    if (self.nightlyOrHourly==TRUE) {
       
        NSLog(@"< %@/Nightly",self.savedRateSetter);
        
rateSearchs.text = [NSString stringWithFormat:@"< %@/Nightly",[self.savedRateSetter stringValue]];
    } else {
        
        NSLog(@"< %@/Hourly",self.savedRateSetter);
        
        rateSearchs.text = [NSString stringWithFormat:@"< %@/Hourly",[self.savedRateSetter stringValue]];
        
    }
}


// VIEW DID LOAD

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.searchResults = [@[]mutableCopy];
    // Do any additional "setup after loading the view.
    
    SWRevealViewController *revealController = [self revealViewController];
    
    //[self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu3.png"]
        style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];

    revealButtonItem.tintColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    searchSegmentControl = [[UISegmentedControl alloc]initWithItems:@[@"Musician/Band",@"Bar/Venue"]];
    [searchSegmentControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue-Light" size:20.0], UITextAttributeFont, nil] forState:UIControlStateNormal];
    searchSegmentControl.frame = CGRectMake(20, 60, SCREEN_WIDTH -40, 70);
    searchSegmentControl.layer.borderWidth = 0;
    UIColor *newTintColor = [UIColor whiteColor];
    searchSegmentControl.tintColor = newTintColor;
    [searchSegmentControl setSelectedSegmentIndex:0];
    [self.view addSubview:searchSegmentControl];

    // location view

    locationSearch = [[UIView alloc] initWithFrame:CGRectMake(20, 140, SCREEN_WIDTH - 40, 80)];
    locationSearch.backgroundColor = [UIColor whiteColor];
    locationSearch.layer.borderWidth = 1;
    locationSearch.layer.cornerRadius = 5;
    locationSearch.layer.borderColor = [[UIColor whiteColor]CGColor];
    locationSearchs = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH - 60, 40)];
    locationSearchs.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
    [locationSearchs setTextAlignment: NSTextAlignmentCenter];
    locationSearchs.backgroundColor = [UIColor whiteColor];
    locationSearchs.textColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    UILabel * locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, locationSearch.bounds.size.width, 20)];
    locationLabel.text = @"Location";
    locationLabel.textAlignment = NSTextAlignmentCenter;
    locationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:24];
    locationLabel.textColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(0, 40, locationLabel.bounds.size.width, 1)];
    line.backgroundColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    searchArrow = [[UIButton alloc]initWithFrame:CGRectMake(locationSearch.bounds.size.width/2 - 15, locationSearch.bounds.size.height/2 + 5, 30, 30)];
    [searchArrow setImage:[UIImage imageNamed:@"searcharrows2.png"] forState:UIControlStateNormal];
    [searchArrow addTarget:self action:@selector(locationArrowPressed) forControlEvents:UIControlEventTouchUpInside];
    
    
    searchLocationButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, locationSearch.bounds.size.width, locationSearch.bounds.size.height)];
    [locationSearch addSubview:searchLocationButton];
    [searchLocationButton addTarget:self action:@selector(searchLocationTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [locationSearch addSubview:locationLabel];
    [self.view addSubview:locationSearch];
    [locationSearch addSubview:locationSearchs];
    [locationSearch addSubview:line];
    [locationSearch addSubview:searchArrow];
    
    // GENRE VIEW
    
    genreSearch = [[UIView alloc] initWithFrame:CGRectMake(20, 230, SCREEN_WIDTH - 40, 80)];
    genreSearch.backgroundColor = [UIColor whiteColor];
    genreSearch.layer.borderWidth = 1;
    genreSearch.layer.borderColor = [[UIColor whiteColor]CGColor];
    genreSearch.layer.cornerRadius = 5;

    
    UILabel * genreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, genreSearch.bounds.size.width, 20)];
    genreLabel.text = @"Genre";
    genreLabel.textAlignment = NSTextAlignmentCenter;
    genreLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:24];
    genreLabel.textColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(0, 40, genreLabel.bounds.size.width, 1)];
    line.backgroundColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];

    
    
    // LABEL

    
    genreSearchs = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH - 60, 40)];
    genreSearchs.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    [genreSearchs setTextAlignment: NSTextAlignmentCenter];
    genreSearchs.backgroundColor = [UIColor whiteColor];
    genreSearchs.textColor = [UIColor colorWithRed:0.780f green:0.780f blue:0.800f alpha:1.0f];
    
//    genreSearchs.text = @"choose up to three...";
    
    searchArrow = [[UIButton alloc]initWithFrame:CGRectMake(genreSearch.bounds.size.width - 45, genreSearch.bounds.size.height/2 + 5, 30, 30)];
    [searchArrow setImage:[UIImage imageNamed:@"searcharrows6.png"] forState:UIControlStateNormal];
    [searchArrow addTarget:self action:@selector(genreArrowPressed) forControlEvents:UIControlEventTouchUpInside];

    
    // BUTTON
    
    genreSearchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, genreSearch.bounds.size.width, genreSearch.bounds.size.height)];
    [genreSearch addSubview:genreSearchButton];
    
    [genreSearchButton addTarget:self action:@selector(genreSearchButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [genreSearch addSubview:genreSearchs];
    [genreSearch addSubview:genreLabel];

    [self.view addSubview:genreSearch];
    [genreSearch addSubview:line];
    
    [genreSearch addSubview:searchArrow];


    availabilitySearch = [[UIView alloc] initWithFrame:CGRectMake(20, 320, SCREEN_WIDTH - 40, 80)];
    availabilitySearch.backgroundColor = [UIColor whiteColor];
    availabilitySearch.layer.borderWidth = 1;
    availabilitySearch.layer.borderColor = [[UIColor whiteColor]CGColor];
    availabilitySearch.layer.cornerRadius = 5;

    searchArrow = [[UIButton alloc]initWithFrame:CGRectMake(availabilitySearch.bounds.size.width/2 - 15, availabilitySearch.bounds.size.height/2 + 5, 30, 30)];
//    [searchArrow setImage:[UIImage imageNamed:@"searcharrows3.png"] forState:UIControlStateNormal];
    [searchArrow addTarget:self action:@selector(availabilityArrowPressed) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel * availabilityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, availabilitySearch.bounds.size.width, 25)];
    availabilityLabel.text = @"Availability";
    availabilityLabel.textAlignment = NSTextAlignmentCenter;
    availabilityLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:24];
    availabilityLabel.textColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(0, 40, availabilityLabel.bounds.size.width, 1)];
    line.backgroundColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    // LABEL
    
    availabilitySearchs = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH - 60, 40)];
    availabilitySearchs.backgroundColor = [UIColor whiteColor];
    availabilitySearchs.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    availabilitySearchs.textColor = [UIColor colorWithRed:0.780f green:0.780f blue:0.800f alpha:1.0f];
    
    availabilitySearchs.text = @"Choose";
    
    [availabilitySearchs setTextAlignment: NSTextAlignmentCenter];
    availabilitySearchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, availabilitySearch.bounds.size.width, availabilitySearch.bounds.size.height)];
    [availabilitySearch addSubview:availabilitySearchButton];
    [availabilitySearchButton addTarget:self action:@selector(availabilitySearchButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [availabilitySearch addSubview:availabilityLabel];
    [availabilitySearch addSubview:availabilitySearchs];

    [self.view addSubview:availabilitySearch];
    [availabilitySearch addSubview:availabilityLabel];
    [availabilitySearch addSubview:line];
    [availabilitySearch addSubview:searchArrow];
    
    //// RATE
    
    rateSearch = [[UIView alloc] initWithFrame:CGRectMake(20, 410, SCREEN_WIDTH - 40, 80)];
    rateSearch.backgroundColor = [UIColor whiteColor];
    rateSearch.layer.borderWidth = 1;
    rateSearch.layer.borderColor = [[UIColor whiteColor]CGColor];
    rateSearch.layer.cornerRadius = 5;
    rateSearchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, rateSearch.bounds.size.width, rateSearch.bounds.size.height)];
    [rateSearch addSubview:rateSearchButton];
    rateSearchs = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH - 60, 40)];
    [rateSearchs setTextAlignment: NSTextAlignmentCenter];
    rateSearchs.backgroundColor = [UIColor whiteColor];
    rateSearchs.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
    rateSearchs.textColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    searchArrow = [[UIButton alloc]initWithFrame:CGRectMake(rateSearch.bounds.size.width/2 - 15, rateSearch.bounds.size.height/2 + 5, 30, 30)];
    [searchArrow setImage:[UIImage imageNamed:@"searcharrows2.png"] forState:UIControlStateNormal];
    [searchArrow addTarget:self action:@selector(rateArrowPressed) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel * rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, rateSearch.bounds.size.width, 20)];
    rateLabel.text = @"Rate";
    rateLabel.textAlignment = NSTextAlignmentCenter;
    rateLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:24];
    rateLabel.textColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(0, 40, rateLabel.bounds.size.width, 1)];
    line.backgroundColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    
    [rateSearchButton addTarget:self action:@selector(rateSearchButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [rateSearch addSubview:rateSearchs];
    [self.view addSubview:rateSearch];
    [rateSearch addSubview:rateLabel];
    [rateSearch addSubview:line];
    [rateSearch addSubview:searchArrow];
    
    // SEARCH BUTTON BOTTOM
    
    searchButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 500, SCREEN_WIDTH - 40, 50)];
    searchButton.backgroundColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    [searchButton setTitle:@"SEARCH" forState:UIControlStateNormal];
    [searchButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:24.0]];

    [searchButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    searchButton.layer.cornerRadius = 5;
    searchButton.layer.borderWidth = 1;
    searchButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    [searchButton addTarget:self action:@selector(searchButtonTickled) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:searchButton];
    
}

-(void)searchLocationTapped {
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"MainStoryboardTwo" bundle: nil];
    
    SearchLocationTVC * searchLocation = [storyboard instantiateViewControllerWithIdentifier:@"searchLocationID"];
    
    searchLocation.delegate = self;
    
    [self.navigationController pushViewController:searchLocation animated:YES];
        
}

-(void)genreSearchButtonTapped {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"searchGenre" bundle: nil];
    
    SearchGenreTVC * searchGenre = [storyboard instantiateViewControllerWithIdentifier:@"searchGenreID"];
    
    searchGenre.delegate = self;
    
    [self.navigationController pushViewController:searchGenre animated:YES];
    
}

-(void)availabilitySearchButtonTapped {
    
    SearchAvailabilityTVC * searchAvailability = [[SearchAvailabilityTVC alloc] init];
    
    UINavigationController * navController = [[UINavigationController alloc]initWithRootViewController:searchAvailability];
    
    searchAvailability.delegate = self;
    
    [self.navigationController pushViewController:searchAvailability animated:YES];
    
}


-(void)rateSearchButtonTapped {
   
    SearchRateVC * searchRate = [[SearchRateVC alloc] init];
    
    UINavigationController * navController = [[UINavigationController alloc]initWithRootViewController:searchRate];
    
    searchRate.delegate = self;
    
    [self.navigationController pushViewController:searchRate animated:YES];
    
}

-(void)searchButtonTickled {
    
    PFUser * user = [PFUser user];
    
    
    PFQuery *query = [PFUser query];

    if (searchSegmentControl.selectedSegmentIndex==0)
    {
        user[@"userType"] = @"musician";
        [query whereKey:@"userType" equalTo:@"musician"]; // find all the musicians

    }
    else {
        user[@"userType"] = @"bar";
        [query whereKey:@"userType" equalTo:@"bar"]; // find all the bars

    }
    
    // Querying location
    
    if([self.savedFormatAddress length] > 0) {
        
        
        PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLatitude:self.latitudeSetter longitude:self.longitudeSetter];

        NSLog(@"user geo point %@",userGeoPoint);
    
        [query whereKey:@"location" nearGeoPoint:userGeoPoint withinMiles:[self.savedRadius doubleValue]];
        
        NSLog(@"radius %@",self.savedRadius);
        

       NSArray *placeObjects = [query findObjects];
       
        NSLog(@"place objects %@",placeObjects);
        
    }
    

    if(self.searchArrayGenres.count > 0) {
        [query whereKey:@"genreArray" containedIn:self.searchArrayGenres];
    }
    
    if (self.searchArrayAvailability.count > 0) {
        
        [query whereKey:@"availabilityArray" containedIn:self.searchArrayAvailability];
    }
    
    // WE NEED THE RATE TO BE FILLED -- NEED IF ELSE STATEMENT
    
    if (self.savedRateSetter > 0 ) {
    
        if (self.nightlyOrHourly) {
            
            [query whereKey:@"nightlyRateNumber" lessThanOrEqualTo:self.savedRateSetter];
            [query orderByAscending:@"nightlyRateNumber"];
            
            NSLog(@"Querying Nightly Rate");
            
        } else {
            
            [query whereKey:@"hourlyRateNumber" lessThanOrEqualTo:self.savedRateSetter];
            [query orderByAscending:@"hourlyRateNumber"];
            
            NSLog(@"Querying Hourly Rate");
        }
    }
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (searchSegmentControl.selectedSegmentIndex == 0) {
            
            for (PFUser * object in objects) {
                
                [self.searchResults addObject:object];
            }
            
        } else {
            
            for (PFUser * object in objects) {
                
                [self.searchResults addObject:object];
            }

        }
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"searchQueryResults" bundle: nil];
        
        QueryResultsTVC * queryResults = [storyboard instantiateViewControllerWithIdentifier:@"queryResultsId"];
        
        queryResults.searchResults = self.searchResults;
        
        [self.navigationController pushViewController:queryResults animated:YES];
        
//        NSLog(@"Before the passing %@",self.searchResults);
        
    }];
    
}

-(void)locationArrowPressed{
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"MainStoryboardTwo" bundle: nil];
    
    SearchLocationTVC * searchLocation = [storyboard instantiateViewControllerWithIdentifier:@"searchLocationID"];
    
    searchLocation.delegate = self;
    
    [self.navigationController pushViewController:searchLocation animated:YES];
    
}


-(void)genreArrowPressed {
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"searchGenre" bundle: nil];
    
    SearchGenreTVC * searchGenre = [storyboard instantiateViewControllerWithIdentifier:@"searchGenreID"];
    
    searchGenre.delegate = self;
    
    [self.navigationController pushViewController:searchGenre animated:YES];
    
}


-(void)availabilityArrowPressed {
    
    SearchAvailabilityTVC * searchAvailability = [[SearchAvailabilityTVC alloc] init];
    
    UINavigationController * navController = [[UINavigationController alloc]initWithRootViewController:searchAvailability];
    
    searchAvailability.delegate = self;
    
    [self.navigationController pushViewController:searchAvailability animated:YES];
    
}

-(void)rateArrowPressed {
    
    SearchRateVC * searchRate = [[SearchRateVC alloc] init];
    
    UINavigationController * navController = [[UINavigationController alloc]initWithRootViewController:searchRate];
    
    searchRate.delegate = self;
    
    [self.navigationController pushViewController:searchRate animated:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}



@end
