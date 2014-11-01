//
//  ViewController.m
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "SignUpViewController.h"
#import "LoginViewController.h"
#import "ProfileViewController.h"
#import <Parse/Parse.h>

@interface MainViewController ()



@end

@implementation MainViewController {
//    UIImageView * gLogo;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Profile";


    
    // Set the gesture
    
//    gLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bigG.png"]];
//    gLogo.center = CGPointMake(self.view.center.x, 200);
//    [self.view addSubview:gLogo];
    
    CGRect myImageRect = CGRectMake(0.0f, 0.0f, 80.0f, 140.0f);
    UIImageView *gLogo = [[UIImageView alloc] initWithFrame:myImageRect];
    [gLogo setImage:[UIImage imageNamed:@"bigG.png"]];
    gLogo.center = CGPointMake(self.view.center.x, 200);

    [self.view addSubview:gLogo];
    
    // SIGN UP BUTTON
    
    UIButton * signUpButton = [[UIButton alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 80, SCREEN_WIDTH - 40, 50)];
    
    signUpButton.backgroundColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    [signUpButton setTitle:@"SIGN UP" forState:UIControlStateNormal];
    [signUpButton setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:24]];
    [signUpButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    signUpButton.layer.cornerRadius = 5;
    
    [self.view addSubview:signUpButton];
    
    [signUpButton addTarget:self action:@selector(signUpTouched) forControlEvents:UIControlEventTouchUpInside];
    
    // LOGIN BUTTON
    
    UIButton * loginButton = [[UIButton alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 150, SCREEN_WIDTH - 40, 50)];
    
    loginButton.backgroundColor = [UIColor whiteColor];
    [loginButton setTitle:@"LOGIN" forState:UIControlStateNormal];
    [loginButton setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:24]];
    [loginButton setTitleColor: [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f] forState:UIControlStateNormal];
    loginButton.layer.cornerRadius = 5;
//    [loginButton.layer setBorderColor:[[UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f] CGColor]];
//    [loginButton.layer setBorderWidth:1];
    
    [self.view addSubview:loginButton];
    
    [loginButton addTarget:self action:@selector(loginTouched) forControlEvents:UIControlEventTouchUpInside];
    
    
    if ([PFUser currentUser].username != nil) {
    
        
        ProfileViewController * profileView = [[ProfileViewController alloc] init];
        
        profileView.whatProfileToLoad = @"userProfile";

        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboardTwo" bundle: nil];
        
        SWRevealViewController * revealVC = [storyboard instantiateViewControllerWithIdentifier:@"revealVC"];
        
        //            UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:profileView];
        
        [self.navigationController setViewControllers:@[revealVC] animated:NO];
        
    }

}


- (void)signUpTouched
{
   SignUpViewController * signUpTVC =[[SignUpViewController alloc] init];
    
    [self presentViewController:signUpTVC animated:YES completion:nil];
}

- (void)loginTouched
{
    LoginViewController * loginTVC =[[LoginViewController alloc] init];
    
    [self presentViewController:loginTVC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
