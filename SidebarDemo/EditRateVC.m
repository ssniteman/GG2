//
//  EditRateVC.m
//  SidebarDemo
//
//  Created by Shane Sniteman on 9/30/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "EditRateVC.h"
#import "EditProfileViewController.h"
#import <Parse/Parse.h>

@interface EditRateVC () <UITextFieldDelegate>

@end

@implementation EditRateVC {
    
    UISegmentedControl * segmentControl;
    UITextField * rateTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //RIGHT MENU BUTTON
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveButton)];
    
    [saveButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0], NSFontAttributeName,
                                        [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f], NSForegroundColorAttributeName,
                                        nil]
                              forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = saveButton;
    
    
    //    saveButton.tintColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    //Left MENU BUTTON
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButton)];
    
    [cancelButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0], NSFontAttributeName,
                                          [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f], NSForegroundColorAttributeName,
                                          nil]
                                forState:UIControlStateNormal];
    
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    //    cancelButton.tintColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    // SEGMENT CONTROL
    
    segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"Nightly",@"Hourly"]];
    [segmentControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    segmentControl.frame = CGRectMake(20, 100, SCREEN_WIDTH - 40, 50);
    
    UIColor *newTintColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    segmentControl.tintColor = newTintColor;
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0], UITextAttributeFont, nil] forState:UIControlStateNormal];
    [segmentControl setSelectedSegmentIndex:0];
    [self.view addSubview:segmentControl];
    
    // RATE TEXT FIELD
    

    rateTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT - 400, 100, 50)];
    rateTextField.backgroundColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    rateTextField.textAlignment = NSTextAlignmentCenter;
    rateTextField.layer.cornerRadius = 5;
    rateTextField.font = [UIFont systemFontOfSize:18];
    rateTextField.placeholder = @"Rate";
    [rateTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [rateTextField setValue:[UIFont fontWithName: @"HelveticaNeue-Light" size: 18] forKeyPath:@"_placeholderLabel.font"];
    [rateTextField setTextColor:[UIColor whiteColor]];
    rateTextField.keyboardType = UIKeyboardTypeNumberPad;
    rateTextField.delegate = self;
    [rateTextField becomeFirstResponder];
    
    
    
    [self.view addSubview:rateTextField];
    
}

- (void) cancelButton{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveButton{
    
    PFUser * user = [PFUser currentUser];
    
    if (segmentControl.selectedSegmentIndex == 0) {
        
        user[@"nightlyRate"] = [NSString stringWithFormat:@"%@/nightly", rateTextField.text];
         [self.delegate setRate:[NSString stringWithFormat:@"%@/nightly", rateTextField.text]];
    
        // Saving Rate as number in Parse
        
        int rateIntNightly = [rateTextField.text intValue];

        
        user[@"nightlyRateNumber"] = @(rateIntNightly);

    } else {
    
        user[@"hourlyRate"] = [NSString stringWithFormat:@"%@/hourly", rateTextField.text];
        [self.delegate setRate:[NSString stringWithFormat:@"%@/hourly", rateTextField.text]];
        
        // Saving Rate as number in Parse
        
        int rateIntHourly = [rateTextField.text intValue];
        
        user[@"hourlyRateNumber"] = @(rateIntHourly);

    }
    
    [[PFUser currentUser] saveInBackground];
    
    [self cancelButton];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end
