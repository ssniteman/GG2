//
//  EditGenreTVC.m
//  SidebarDemo
//
//  Created by Shane Sniteman on 9/27/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "EditGenreTVC.h"
#import "EditProfileViewController.h"
#import <Parse/Parse.h>

@interface EditGenreTVC ()

@end

@implementation EditGenreTVC {
    
    NSArray * editGenreList;
    NSMutableArray  * availableGenres;
    
    int maxGenres;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    maxGenres =0;
    
    availableGenres=[@[@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @""] mutableCopy];
    
    
    editGenreList = @[@"Acoustic", @"Alternative Rock", @"Ambient", @"Americana", @"Blues", @"Bluegrass", @"Classical", @"Classic Rock", @"Country", @"Dance", @"DJ", @"Disco", @"Dubstep", @"Electro", @"Electronic", @"Folk", @"Gospel", @"Hip-Hop", @"House", @"Indie", @"Jazz", @"Latin", @"Metal", @"Oldies", @"Other", @"Piano", @"Pop", @"Pop/Country", @"Progressive House", @"Punk", @"R&B", @"Rap", @"Reggae", @"Rock", @"Singer-Songwriter", @"Soul", @"Southern Rock", @"Techno", @"Trance", @"Weddings"];

    
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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *thisCell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    if (thisCell.accessoryType == UITableViewCellAccessoryNone) {
        
        if (maxGenres<=2){
        
        thisCell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        
        [availableGenres insertObject:[NSString stringWithFormat:@"%@", editGenreList[indexPath.row]] atIndex:indexPath.row];
            
        }else{NSLog(@"no more than 1 genre");}
        
          maxGenres++;
        
    }else{
        
        maxGenres--;
        
        thisCell.accessoryType = UITableViewCellAccessoryNone;
        [availableGenres removeObjectAtIndex: indexPath.row];
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return editGenreList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    if ([availableGenres containsObject:editGenreList[indexPath.row]]) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    } else {
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    
    
    cell.textLabel.text = editGenreList[indexPath.row];
    
    return cell;
}







-(void)saveButton {
    
    NSMutableString * stringOfGenres = [[NSMutableString alloc] init];
    
    //Getting each day and appending it to one string
    
    for (NSString * genres in availableGenres) {
        if ([genres length]!=0) {
            [stringOfGenres appendFormat:@"%@/", genres];

        }
        
    }
    [self.delegate setGenreString:[stringOfGenres substringToIndex:[stringOfGenres length]-1]];

    
    NSLog(@"%@",[stringOfGenres substringToIndex:[stringOfGenres length]-1]);
    
    PFUser * user = [PFUser currentUser];
    
    user[@"genre"] = [stringOfGenres substringToIndex:[stringOfGenres length]-1];
    
    [availableGenres removeObject:@""];
    
    user[@"genreArray"] = availableGenres;
    
    [[PFUser currentUser] saveInBackground];
    

  
    [self cancelButton];

    
}


- (void) cancelButton{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
