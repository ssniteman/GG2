//
//  AvailabilityTVC.m
//  SidebarDemo
//
//  Created by Rene Candelier on 9/26/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "AvailabilityTVC.h"
#import "EditProfileViewController.h"
#import <Parse/Parse.h>

@interface AvailabilityTVC ()
@end

@implementation AvailabilityTVC{
    NSMutableArray * daysOfTheWeek;

}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.available=[@[@"",
                 @"",
                 @"",
                 @"",
                 @"",
                 @"",
                 @""]mutableCopy];
    
    daysOfTheWeek=[@[
                     @"Monday",
                     @"Tuesday",
                     @"Wednesday",
                     @"Thursday",
                     @"Friday",
                     @"Saturday",
                     @"Sunday",
                     ]mutableCopy];
    
    //RIGHT MENU BUTTON
    
  UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveButton)];
    
    self.navigationItem.rightBarButtonItem = saveButton;
    
    
    //Left MENU BUTTON
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButton)];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

-(void) saveButton{
    
    
    
    
    NSMutableString *stringOfDays = [[NSMutableString alloc] init];
    
    //Getting each day and appending it to one string
    for (NSString * days in self.available) {
        
        [stringOfDays appendFormat:@"%@ ", days];
        
        
    }
    
    
//    if ([self.available containsObject: @"Monday"]&&[self.available containsObject: @"Tuesday"]&&[self.available containsObject: @"Wednesday"]&&[self.available containsObject: @"Thursday"]&& self.available.count <=3) {
//        
//        [self.delegate setDaysAvailable:@"Weekdays"];
//        
//        
//    } else if ([self.available containsObject: @"Friday"]&&[self.available containsObject: @"Saturday"]&&[self.available containsObject: @"Sunday"]&& self.available.count <=2){
//        
//        [self.delegate setDaysAvailable:@"Weekends"];
//        
//    }else if () {
//        [self.delegate setDaysAvailable:@"Weekdays"];
//
//    }
    
    
    PFUser * user = [PFUser currentUser];
    
    user[@"availability"] = stringOfDays;
    
    [self.available removeObject:@""];
    
    user[@"availabilityArray"] = self.available;
    
    [[PFUser currentUser] saveInBackground];
    
    NSLog(@"%@",user);
    


    
    [self.delegate setDaysAvailable:stringOfDays];

    
//    editProfile.daysAvailableLabel.text = string;
//    
//    [editProfile.tableView reloadData];

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
