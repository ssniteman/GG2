//
//  QueryResultsTVC.m
//  SidebarDemo
//
//  Created by Shane Sniteman on 10/4/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "QueryResultsTVC.h"
#import "QueryResultsCell.h"
#import "SWRevealViewController.h"
#import "ProfileViewController.h"
#import "SearchResultsProfileViewController.h"
#import <Parse/Parse.h>

@interface QueryResultsTVC () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation QueryResultsTVC {
    
    UIButton * resuzltPhoto;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    self.searchResults = [@[@{}]mutableCopy];

}

- (void)setSearchResults:(NSMutableArray *)searchResults {
    _searchResults = searchResults;

    NSLog(@"setter method : %@",searchResults);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return self.searchResults.count;
    

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QueryResultsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"profilesCell"];
    
//    PFObject * user = [self.searchResults objectAtIndex:indexPath.row];
//    PFFile *imageFile = user[@"image"];
//    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//        UIImage * image = [UIImage imageWithData:data];
//        [resultPhoto setBackgroundImage:image forState:UIControlStateNormal];
//    }];
//    resultPhoto.layer.cornerRadius = 70;
//    resultPhoto.userInteractionEnabled = false;
//    resultPhoto.clipsToBounds = YES;
//    cell.resultBandName.text = user[@"bandName"];
//    cell.resultGenreLabel.text = user[@"genre"];
//    cell.resultCityLabel.text = do delegate for address[formatted address];
//    cell.resultAvailabilityLabel.text = user[@"availability"];
//    cell.resultRateLabel.text = user[@"nightly or hourly depending"];
    
    
    cell.usersContent = self.searchResults[indexPath.row];

    NSLog(@"these are the %@",self.searchResults);

    if (cell == nil) {
        
        cell = [[QueryResultsCell alloc]init];
    }
    // Configure the cell...
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
//    SearchResultsProfileViewController * sendingData = [[SearchResultsProfileViewController alloc]init];
    
//    sendingData.whatProfileToLoad = NO;

    
    
//        sendingData.searchResultsForProfile = self.searchResults[indexPath.row];

    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"searchResultsProfile" bundle: nil];
    
    SearchResultsProfileViewController * resultProfile = [storyboard instantiateViewControllerWithIdentifier:@"resultProfile"];
    
//    sendingData.messageButton.hidden = false;
    
    resultProfile.searchResultsForProfile = self.searchResults[indexPath.row];

    
    [self.navigationController pushViewController:resultProfile animated:YES];
    
//    ((UINavigationController *)self.presentingViewController).viewControllers = @[revealVC];
    
    [self dismissViewControllerAnimated:YES completion:nil];

    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
