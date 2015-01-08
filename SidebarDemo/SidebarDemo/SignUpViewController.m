//
//  SignUpViewController.m
//  SidebarDemo
//
//  Created by Shane Sniteman on 9/21/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "SignUpViewController.h"
#import "ProfileViewController.h"
#import "SWRevealViewController.h"

@interface SignUpViewController () <UITextFieldDelegate>

@end

@implementation SignUpViewController {
    UITextField * usernameTextField;
    UITextField * passwordTextField;
    UITextField * emailField;
    UISegmentedControl * segmentControl;
    NSString * usernameText;
    
    UIButton * signUpFinalButton;
    UIView * signUpView;
    
    UIButton * cancelButton;
    UIImageView *gLogo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    usernameTextField.delegate = self;
    passwordTextField.delegate = self;
    emailField.delegate = self;
    usernameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    emailField.autocorrectionType = UITextAutocorrectionTypeNo;

    
    
    self.view.backgroundColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    // Do any additional setup after loading the view.
    
    gLogo = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 80.0f, 140.0f)];
    [gLogo setImage:[UIImage imageNamed:@"bigG.png"]];
    gLogo.center = CGPointMake(self.view.center.x, 120);
    
    [self.view addSubview:gLogo];
    
    
    cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 45, 5, 40, 40)];
    UIImage *cancel = [UIImage imageNamed:@"close.png"];
    [cancelButton setBackgroundImage:cancel forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelTouched) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cancelButton];
    
    
    // USERNAME TEXT FIELD
    
    usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH - 40, 50)];
    usernameTextField.backgroundColor = [UIColor whiteColor];
    usernameTextField.layer.cornerRadius = 5;
    usernameTextField.font = [UIFont systemFontOfSize:18];
    usernameTextField.placeholder = @"USERNAME";
    usernameTextField.autocapitalizationType = FALSE;

    [usernameTextField setValue:[UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    [usernameTextField setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size: 24]];
    [usernameTextField setTextColor:[UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f]];

    
    UIView * paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    usernameTextField.leftView = paddingView;
    usernameTextField.leftViewMode = UITextFieldViewModeAlways;
    usernameTextField.delegate = self;

    [usernameTextField setValue:[UIFont fontWithName: @"HelveticaNeue-Thin" size: 24] forKeyPath:@"_placeholderLabel.font"];

//    [usernameTextField becomeFirstResponder];
    
    
    // PASSWORD TEXT FIELD
    
    passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH - 40, 50)];
    passwordTextField.backgroundColor = [UIColor whiteColor];
    passwordTextField.layer.cornerRadius = 5;
    passwordTextField.font = [UIFont systemFontOfSize:18];
    passwordTextField.placeholder = @"PASSWORD";
    passwordTextField.autocapitalizationType = FALSE;

    [passwordTextField setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size: 24]];
    [passwordTextField setTextColor:[UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f]];

    passwordTextField.secureTextEntry = YES;
    
    [passwordTextField setValue:[UIFont fontWithName: @"HelveticaNeue-Thin" size: 24] forKeyPath:@"_placeholderLabel.font"];

    
    [passwordTextField setValue:[UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    
    UIView * paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    passwordTextField.leftView = paddingView2;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    passwordTextField.delegate = self;

    
    // VERIFY PASSWORD TEXT FIELD
    
    emailField = [[UITextField alloc] initWithFrame:CGRectMake(0, 130, SCREEN_WIDTH - 40, 50)];
    emailField.backgroundColor = [UIColor whiteColor];
    emailField.layer.cornerRadius = 5;
    emailField.font = [UIFont systemFontOfSize:18];
    emailField.placeholder = @"EMAIL";
    emailField.autocapitalizationType = FALSE;
    [emailField setValue:[UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    UIView * paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    emailField.leftView = paddingView3;
    emailField.leftViewMode = UITextFieldViewModeAlways;
    emailField.delegate = self;
    [emailField setTextColor:[UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f]];
    [emailField setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size: 24]];

    [emailField setValue:[UIFont fontWithName: @"HelveticaNeue-Thin" size: 24] forKeyPath:@"_placeholderLabel.font"];

    
    
    // USERTYPE
    
    segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"Musician/Band",@"Bar/Venue"]];
    [segmentControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    segmentControl.frame = CGRectMake(0, 190, SCREEN_WIDTH - 40, 50);
        segmentControl.tintColor = [UIColor whiteColor];
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0], UITextAttributeFont, nil] forState:UIControlStateNormal];
    segmentControl.layer.borderWidth = 0;
    [segmentControl setSelectedSegmentIndex:0];
    
    
    
    // SIGN UP FINAL BUTTON
    
    signUpFinalButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 250, SCREEN_WIDTH - 40, 50)];
    
    signUpFinalButton.backgroundColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    signUpFinalButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [signUpFinalButton setTitle:@"SIGN UP" forState:UIControlStateNormal];
    [signUpFinalButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    signUpFinalButton.layer.cornerRadius = 5;
    signUpFinalButton.layer.borderWidth = 1;
    signUpFinalButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    [signUpFinalButton addTarget:self action:@selector(signUpFinalTouched) forControlEvents:UIControlEventTouchUpInside];
    
    [signUpFinalButton setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:24]];

    
    signUpView = [[UIView alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 320, SCREEN_WIDTH - 40, 330)];
    signUpView.backgroundColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    [self.view addSubview:signUpView];
    
    [signUpView addSubview:usernameTextField];
    [signUpView addSubview:emailField];
    [signUpView addSubview:passwordTextField];
    [signUpView addSubview:segmentControl];
    [signUpView addSubview:signUpFinalButton];

}


- (void)signUpFinalTouched {
    
    NSLog(@"%@",usernameTextField.text);
    
    NSLog(@"SignUpFinal Tappedity Tapped");
    
    PFUser *user = [PFUser user];
    
    user.username = usernameTextField.text;
    user.password = passwordTextField.text;
    user.email = emailField.text;
//    user[@"badgeNumber"] = @(0);
    
    
    
    if (segmentControl.selectedSegmentIndex == 0)
    {
        user[@"userType"] = @"musician";
        
    }
    else {
        
        user[@"userType"] = @"bar";
        

        
    }
    
    NSLog(@"user type on sign up %@",user[@"userType"]);
    
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
        } else {
            NSString *errorString = [error userInfo][@"error"];
            
            NSLog(@"%@",errorString);
            // Show the errorString somewhere and let the user try again.
        }
    }];
    
        PFInstallation * installation = [PFInstallation currentInstallation];
        installation[@"user"] = user;
        [installation saveInBackground];
    
    

//     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboardTwo" bundle: nil];
//    
//    ProfileViewController * profileView = [storyboard instantiateViewControllerWithIdentifier:@"profileView"];
//    
//    [self presentViewController:profileView animated:YES completion:nil];
    
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    sleep(1);

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboardTwo" bundle: nil];
    
    SWRevealViewController * revealVC = [storyboard instantiateViewControllerWithIdentifier:@"revealVC"];
    
    // this giving problems on the logout, then signup issue
    
    ((UINavigationController *)self.presentingViewController).viewControllers = @[revealVC];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    

    
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}


-(void)cancelTouched {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
//    return YES; }
//
//
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
//    
//    [signUpView endEditing:YES];
//    return YES; }
//
//
//- (void)keyboardDidShow:(NSNotification *)notification
//{
//    
//    
////    [UIView animateWithDuration:0.3 animations:^{
//        [signUpView setFrame:CGRectMake(20,10,signUpView.bounds.size.width,signUpView.bounds.size.height)];
//        
//        gLogo.hidden = YES;
//        cancelButton.hidden = YES;
////    }];
//    
//}
//
//-(void)keyboardDidHide:(NSNotification *)notification
//{
//    
//    
////    [UIView animateWithDuration:0.3 animations:^{
//        [signUpView setFrame:CGRectMake(20,SCREEN_HEIGHT - 360,signUpView.bounds.size.width,signUpView.bounds.size.height)];
//        
//        gLogo.hidden = NO;
//        cancelButton.hidden = NO;
////}];
//    
//    
//}


/// ui view going up

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    return YES; }


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [signUpView endEditing:YES];
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





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
