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
    
    UIButton * resultPhoto;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];

    
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
    
    cell.usersContent = self.searchResults[indexPath.row];

//    NSLog(@"these are the %@",self.searchResults);

    if (cell == nil) {
        
        cell = [[QueryResultsCell alloc]init];
    }
    // Configure the cell...
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"searchResultsProfile" bundle: nil];
    
    SearchResultsProfileViewController * resultProfile = [storyboard instantiateViewControllerWithIdentifier:@"resultProfile"];
    
    resultProfile.searchResultsForProfile = self.searchResults[indexPath.row];
    
    [self.navigationController pushViewController:resultProfile animated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
 
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
