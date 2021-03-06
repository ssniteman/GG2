//
//  LoginViewController.m
//  SidebarDemo
//
//  Created by Shane Sniteman on 9/26/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "LoginViewController.h"
#import "ProfileViewController.h"
#import <Parse/Parse.h>

#import "SWRevealViewController.h"
#import "MainViewController.h"

@interface LoginViewController () <UITextFieldDelegate>

@end

@implementation LoginViewController {
    
    UIButton * loginFinalButton;
    UITextField * loginUsernameTextField;
    UITextField * loginPasswordTextField;
    
    UIImageView *gLogo;
    UIButton * cancelButton;
    
    UIView * loginView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    
    self.view.backgroundColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    gLogo = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 80.0f, 140.0f)];
    [gLogo setImage:[UIImage imageNamed:@"bigG.png"]];
    gLogo.center = CGPointMake(self.view.center.x, 150);

    [self.view addSubview:gLogo];
    //

    
    cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 10, 40, 40)];
    UIImage *cancel = [UIImage imageNamed:@"close.png"];
    [cancelButton setBackgroundImage:cancel forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelTouched) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cancelButton];
    
    
    // USERNAME TEXT FIELD
    
    loginUsernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 50)];
    loginUsernameTextField.backgroundColor = [UIColor whiteColor];
    loginUsernameTextField.layer.cornerRadius = 5;
    loginUsernameTextField.font = [UIFont systemFontOfSize:18];
    loginUsernameTextField.placeholder = @"USERNAME";
    loginUsernameTextField.autocapitalizationType = FALSE;
    [loginUsernameTextField setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size: 24]];

    [loginUsernameTextField setValue:[UIFont fontWithName: @"HelveticaNeue-Thin" size: 24] forKeyPath:@"_placeholderLabel.font"];
    [loginUsernameTextField setTextColor:[UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f]];

    [loginUsernameTextField setValue:[UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    
    UIView * paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    loginUsernameTextField.leftView = paddingView;
    loginUsernameTextField.leftViewMode = UITextFieldViewModeAlways;
    loginUsernameTextField.delegate = self;
    

    // PASSWORD TEXT FIELD
    
    loginPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH - 40, 50)];
    loginPasswordTextField.backgroundColor = [UIColor whiteColor];
    loginPasswordTextField.layer.cornerRadius = 5;
    loginPasswordTextField.font = [UIFont systemFontOfSize:18];
    loginPasswordTextField.placeholder = @"PASSWORD";
    loginPasswordTextField.autocapitalizationType = FALSE;
    [loginPasswordTextField setValue:[UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    [loginPasswordTextField setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size: 24]];
    [loginPasswordTextField setTextColor:[UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f]];

    [loginPasswordTextField setValue:[UIFont fontWithName: @"HelveticaNeue-Thin" size: 24] forKeyPath:@"_placeholderLabel.font"];

    
    loginPasswordTextField.secureTextEntry = YES;
    loginPasswordTextField.delegate = self;
    
    UIView * paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    loginPasswordTextField.leftView = paddingView2;
    loginPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    // LOGIN BUTTON
    
    
    loginFinalButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH - 40, 50)];
    
    loginFinalButton.backgroundColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    loginFinalButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [loginFinalButton setTitle:@"LOGIN" forState:UIControlStateNormal];
    [loginFinalButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    loginFinalButton.layer.cornerRadius = 5;
    loginFinalButton.layer.borderWidth = 1;
    loginFinalButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    [loginFinalButton setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:24]];

    
    [loginFinalButton addTarget:self action:@selector(loginFinalTouched) forControlEvents:UIControlEventTouchUpInside];
    
    
    loginView = [[UIView alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 220, SCREEN_WIDTH - 40, 170)];
    loginView.backgroundColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    [self.view addSubview:loginView];

    
    loginUsernameTextField.delegate = self;
    loginPasswordTextField.delegate = self;
    loginUsernameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    loginPasswordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [loginView addSubview:loginUsernameTextField];
    [loginView addSubview:loginPasswordTextField];
    [loginView addSubview:loginFinalButton];
    

}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    return YES; }


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [loginView endEditing:YES];
    return YES; }


- (void)keyboardWillChangeFrame:(NSNotification *)notification
{

    CGSize kbSize = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.view.frame = CGRectMake(0, -kbSize.height, self.view.frame.size.width, self.view.frame.size.height);
    
    
    
//    [UIView animateWithDuration:0.3 animations:^{
//        [loginView setFrame:CGRectMake(20,232,loginView.bounds.size.width,loginView.bounds.size.height)];
//    }];
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
//    [UIView animateWithDuration:0.3 animations:^{
//        [loginView setFrame:CGRectMake(20,SCREEN_HEIGHT - 220,loginView.bounds.size.width,loginView.bounds.size.height)];
//    }];
    
    
//    gLogo.hidden = NO;
//    cancelButton.hidden = NO;
}


-(void)loginFinalTouched {
    
    
    [PFUser logInWithUsernameInBackground:loginUsernameTextField.text password:loginPasswordTextField.text block:^(PFUser *user, NSError *error) {
        
        if (user) {
            // Do stuff after successful login.
            
//            ProfileViewController * profileView = [[ProfileViewController alloc] init];
//            
//            profileView.whatProfileToLoad = TRUE;
//
//           [self presentViewController:profileView animated:YES completion:nil];

            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboardTwo" bundle: nil];
            
            SWRevealViewController * revealVC = [storyboard instantiateViewControllerWithIdentifier:@"revealVC"];

//            UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:profileView];
            
            
            ((UINavigationController *)self.presentingViewController).viewControllers = @[revealVC];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
//            [((UINavigationController *)self.presentingViewController) pushViewController:revealVC animated:NO];
            
            
            
                 NSLog(@"Hey");
            
        } else {
        // The login failed. Check error to see why.
            
            
        }
    }];
}


-(void)cancelTouched {
   
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
