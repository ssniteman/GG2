//
//  SearchViewController.h
//  SidebarDemo
//
//  Created by Shane Sniteman on 9/7/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController

@property (nonatomic,strong) NSString * savedSearchGenres;
@property (nonatomic,strong) NSString * savedSearchAvailability;

@property (nonatomic,strong) NSMutableArray * searchArrayGenres;
@property (nonatomic,strong) NSMutableArray * searchArrayAvailability;

@property (nonatomic, strong) NSString * savedFormatAddress;
@property (nonatomic) double latitudeSetter;
@property (nonatomic) double longitudeSetter;
@property (nonatomic,strong) NSNumber * savedRateSetter;
@property (nonatomic,strong) NSNumber * savedRadius;
//NIGHLY is going to be TRUE and HOURLY is FALSE

@property (nonatomic ,assign) BOOL nightlyOrHourly;


// Passing array to the QUERY RESULTS TVC

@property (nonatomic, strong) NSMutableArray * searchResults;


#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height



@end
