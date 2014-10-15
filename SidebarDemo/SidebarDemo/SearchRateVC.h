//
//  SearchRateVC.h
//  SidebarDemo
//
//  Created by Shane Sniteman on 10/2/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SearchRateVCDelegate;

@interface SearchRateVC : UIViewController

@property (nonatomic,assign) id<SearchRateVCDelegate> delegate;

@end

@protocol SearchRateVCDelegate <NSObject>
- (void)setNightlyOrHourly:(BOOL)nightlyOrHourly;
- (void)setSavedRateSetter:(NSNumber *)savedRateSetter;

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@end
