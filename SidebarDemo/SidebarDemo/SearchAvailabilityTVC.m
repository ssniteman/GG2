//
//  SearchAvailabilityTVC.m
//  SidebarDemo
//
//  Created by Rene Candelier on 9/26/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "AvailabilityTVC.h"
#import "EditProfileViewController.h"
#import "SearchAvailabilityTVC.h"
#import "SearchViewController.h"
#import <Parse/Parse.h>

@interface SearchAvailabilityTVC ()

@end

@implementation SearchAvailabilityTVC{
    NSMutableArray * daysOfTheWeek;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.available=[@[@"",
                      @"",
                      @"",
                      @"",
                      @"",
                      @"",
                      @""]mutableCopy];
    
    daysOfTheWeek=[@[
                     @"Sunday",
                     @"Monday",
                     @"Tuesday",
                     @"Wednesday",
                     @"Thursday",
                     @"Friday",
                     @"Saturday"
                     
                     
                     ]mutableCopy];
    
    //RIGHT MENU BUTTON
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveButton)];
    
    self.navigationItem.rightBarButtonItem = saveButton;
    
    saveButton.tintColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    
    //Left MENU BUTTON
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButton)];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    cancelButton.tintColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

-(void) saveButton {
    
    
    NSMutableString * stringOfDays = [[NSMutableString alloc] init];
    
    //Getting each day and appending it to one string
    for (NSString * days in self.available) {
        
        [stringOfDays appendFormat:@"%@ ", days];
        
    }
    
    [self.delegate setSavedSearchAvailability:stringOfDays];
    
    [self.delegate setSearchArrayAvailability:self.available];
    
    [self cancelButton];
}


- (void) cancelButton{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *thisCell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    if (thisCell.accessoryType == UITableViewCellAccessoryNone) {
        thisCell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        
        [self.available insertObject:[daysOfTheWeek[indexPath.row] substringToIndex:3] atIndex:indexPath.row];
    }else{
        thisCell.accessoryType = UITableViewCellAccessoryNone;
        [self.available removeObjectAtIndex: indexPath.row];
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    }
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    //add your own code to set the cell accesory type.
    return UITableViewCellAccessoryNone;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    cell.textLabel.text = daysOfTheWeek[indexPath.row];
    
    return cell;
    
}



@end
