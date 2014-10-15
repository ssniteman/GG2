//
//  AvailabilityTVC.h
//  SidebarDemo
//
//  Created by Rene Candelier on 9/26/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@protocol AvailableTVCDelegate;

@interface AvailabilityTVC : UITableViewController

@property (nonatomic,assign) id<AvailableTVCDelegate> delegate;


@property (nonatomic, strong) NSMutableArray * available;

@end

@protocol AvailableTVCDelegate <NSObject>

-(void)setDaysAvailable:(NSString *)daysAvailable;


@end
