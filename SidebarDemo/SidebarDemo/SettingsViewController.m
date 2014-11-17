//
//  SettingsViewController.m
//  SidebarDemo
//
//  Created by Shane Sniteman on 9/7/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "SettingsViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>
#import "MainViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SWRevealViewController *revealController = [self revealViewController];
    
    //[self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu3.png"]style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    
    revealButtonItem.tintColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;

    
    UIButton * signOutButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 50)];
    signOutButton.backgroundColor = [UIColor grayColor];
    [signOutButton setTitle:@"Sign Out" forState:UIControlStateNormal];
    signOutButton.titleLabel.textColor = [UIColor whiteColor];
    
    [signOutButton addTarget:self action:@selector(signOutTouched) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:signOutButton];


    
}


-(void)signOutTouched {
    
    NSLog(@"touched");
    
    [PFUser logOut];
    
    // send back to login page
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboardTwo" bundle: nil];
    
    MainViewController * mainVC = [storyboard instantiateViewControllerWithIdentifier:@"mainID"];
    
    [self.navigationController setViewControllers:@[mainVC]];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
