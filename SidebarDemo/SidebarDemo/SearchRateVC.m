
//
//  SearchRateVC.m
//  SidebarDemo
//
//  Created by Shane Sniteman on 10/2/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "SearchRateVC.h"
#import "SearchViewController.h"
#import <Parse/Parse.h>

@interface SearchRateVC () <UITextFieldDelegate>

@end

@implementation SearchRateVC {
UISegmentedControl * segmentControl;
UITextField * rateTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    //RIGHT MENU BUTTON
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveButton)];
    
    self.navigationItem.rightBarButtonItem = saveButton;
    
    saveButton.tintColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    
    //LEFT MENU BUTTON
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButton)];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    cancelButton.tintColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    // SEGMENT CONTROL
    
    segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"Nightly",@"Hourly"]];
    [segmentControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    segmentControl.frame = CGRectMake(20, 100, SCREEN_WIDTH - 40, 50);
    
    UIColor *newTintColor = [UIColor redColor];
    segmentControl.tintColor = newTintColor;
    
    UIFont * font = [UIFont boldSystemFontOfSize:16.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    [segmentControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    //    [segmentControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [segmentControl setSelectedSegmentIndex:0];
    [self.view addSubview:segmentControl];
    
    rateTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 360, SCREEN_WIDTH - 40, 50)];
    rateTextField.backgroundColor = [UIColor whiteColor];
    rateTextField.layer.cornerRadius = 5;
    rateTextField.font = [UIFont systemFontOfSize:18];
    rateTextField.placeholder = @"Rate";
    [rateTextField setValue:[UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    
    UIView * paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    rateTextField.leftView = paddingView;
    rateTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:rateTextField];
    
}

- (void) cancelButton{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveButton{
    
//    [self.delegate setSavedRateSetter:rateTextField.text];
    
    
    
    if (segmentControl.selectedSegmentIndex == 0) {
        
        [self.delegate  setNightlyOrHourly:TRUE];
        
//        [self.delegate setSavedRateSetter:[NSString stringWithFormat:@"%@/nightly", rateTextField.text]];

    } else {
        
//        [self.delegate setSavedRateSetter:[NSString stringWithFormat:@"%@/hourly", rateTextField.text]];
        
        [self.delegate setNightlyOrHourly:FALSE];

    }
    
    [self.delegate setSavedRateSetter:@([rateTextField.text intValue])];

    [self cancelButton];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end
