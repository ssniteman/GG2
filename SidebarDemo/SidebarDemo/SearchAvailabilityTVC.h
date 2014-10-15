//
//  SearchAvailabilityTVC.h
//  SidebarDemo
//
//  Created by Shane Sniteman on 9/29/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchAvailabilityTVCDelegate;

@interface SearchAvailabilityTVC : UITableViewController

@property (nonatomic, strong) NSMutableArray * available;

@property (nonatomic,assign) id<SearchAvailabilityTVCDelegate> delegate;


@end

@protocol SearchAvailabilityTVCDelegate <NSObject>

- (void)setSavedSearchAvailability:(NSString *)savedSearchAvailability;
-(void)setSearchArrayAvailability:(NSMutableArray *)searchArrayAvailability;


@end