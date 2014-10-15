//
//  EditRateVC.h
//  SidebarDemo
//
//  Created by Shane Sniteman on 9/30/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RateDelegate;

@interface EditRateVC : UIViewController

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@property (nonatomic,assign) id<RateDelegate> delegate;

@end

@protocol RateDelegate <NSObject>

-(void)setRate:(NSString *)rate;

@end