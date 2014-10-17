//
//  SearchGenreTVC.m
//  SidebarDemo
//
//  Created by Shane Sniteman on 9/27/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "SearchGenreTVC.h"
#import "SearchViewController.h"

@interface SearchGenreTVC ()

@end

@implementation SearchGenreTVC {
    
    NSArray * searchGenreList;
    NSMutableArray  * availableGenres;
    
    int maxGenres;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    maxGenres =0;
    
    availableGenres=[@[] mutableCopy];
    
    searchGenreList = @[@"Acoustic", @"Alternative Rock", @"Ambient", @"Americana", @"Blues", @"Bluegrass", @"Classical", @"Classic Rock", @"Country", @"Dance", @"DJ", @"Disco", @"Dubstep", @"Electro", @"Electronic", @"Folk", @"Gospel", @"Hip-Hop", @"House", @"Indie", @"Jazz", @"Latin", @"Metal", @"Oldies", @"Other", @"Piano", @"Pop", @"Pop/Country", @"Progressive House", @"Punk", @"R&B", @"Rap", @"Reggae", @"Rock", @"Singer-Songwriter", @"Soul", @"Southern Rock", @"Techno", @"Trance"];
    
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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *thisCell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    if (thisCell.accessoryType == UITableViewCellAccessoryNone) {
        
        if (maxGenres<=2){
            
            thisCell.accessoryType = UITableViewCellAccessoryCheckmark;
            [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            
            if(![availableGenres containsObject:searchGenreList[indexPath.row]]) [availableGenres addObject:[NSString stringWithFormat:@"%@", searchGenreList[indexPath.row]]];
            
//            for parse saving
//            [availableGenres componentsJoinedByString:@"/"];
            
            maxGenres++;
            
        
        }else{
            NSLog(@"no more than 3 genres");
        }
        
        
    }else{
        
        maxGenres--;
        
        thisCell.accessoryType = UITableViewCellAccessoryNone;
        [availableGenres removeObject:searchGenreList[indexPath.row]];
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return searchGenreList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    
    if ([availableGenres containsObject:searchGenreList[indexPath.row]]) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
    } else {
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    
    // Configure the cell...
    
    cell.textLabel.text = searchGenreList[indexPath.row];
    
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancelButton {
    
    [self.navigationController popViewControllerAnimated:YES];

    
}

-(void)saveButton {
    
    NSLog(@"%@",[availableGenres componentsJoinedByString:@"/"]);
    
    [self.delegate setSavedSearchGenres:[availableGenres componentsJoinedByString:@"/"]];
    
    [self.delegate setSearchArrayGenres:availableGenres];
    

    
    [self cancelButton];
    
}



@end
