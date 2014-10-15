//
//  SearchGenreTVC.h
//  SidebarDemo
//
//  Created by Shane Sniteman on 9/27/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchGenreTVCDelegate;

@interface SearchGenreTVC : UITableViewController

@property (nonatomic,assign) id<SearchGenreTVCDelegate> delegate;

@end

@protocol SearchGenreTVCDelegate <NSObject>

- (void)setSavedSearchGenres:(NSString *)savedSearchGenres;
- (void)setSearchArrayGenres:(NSMutableArray *)searchArrayGenres;

@end