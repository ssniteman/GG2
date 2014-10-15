//
//  SearchLocationTVC.h
//  SidebarDemo
//
//  Created by Shane Sniteman on 10/2/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchLocationTVCDelegate;

@interface SearchLocationTVC : UITableViewController

@property (nonatomic,assign) id<SearchLocationTVCDelegate> delegate;

// AFTER DELEGATE

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)changeRadiusButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *searchZip;

- (IBAction)changeZip:(id)sender;

- (IBAction)currentLocationSwitch:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *currentLocationSwitchOutlet;
@property (weak, nonatomic) IBOutlet UIPickerView *radiusPicker;

@property (weak, nonatomic) IBOutlet UIView *radiusCell;
@property (weak, nonatomic) IBOutlet UIButton *changeZip;
@property (weak, nonatomic) IBOutlet UIButton *enterZipButton;


- (IBAction)enterZipButton:(id)sender;

@end

@protocol SearchLocationTVCDelegate <NSObject>

-(void)setSavedFormatAddress:(NSString *)savedFormatAddress;
-(void)setLatitudeSetter:(double)latitudeSetter;
-(void)setLongitudeSetter:(double)longitudeSetter;
-(void)setSavedRadius:(NSNumber *)savedRadius;

@end
