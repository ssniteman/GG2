//
//  EditGenreTVC.h
//  SidebarDemo
//
//  Created by Shane Sniteman on 9/27/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

//Declare the delegate

@protocol GenreTVCDelegate;

@interface EditGenreTVC : UITableViewController

//Another declare
@property (nonatomic,assign) id<GenreTVCDelegate> delegate;

@end



// METHODS FOR DELEGATE

@protocol GenreTVCDelegate <NSObject>

-(void)setGenreString:(NSString *)genreString;

@end


