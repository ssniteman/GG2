//
//  InboxTVC.m
//  SidebarDemo
//
//  Created by Shane Sniteman on 10/9/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "InboxTVC.h"
#import "SWRevealViewController.h"
#import "InboxCustomCell.h"
#import <Parse/Parse.h>

@interface InboxTVC ()

@end

@implementation InboxTVC {
 
    NSMutableArray * myConversations;
    PFUser * friends;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    myConversations = [@[] mutableCopy];
    
    
    SWRevealViewController *revealController = [self revealViewController];
    
    //[self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    // QUERYING FOR PEOPLE YOU'RE CHATTING WITH
    
    PFQuery * inboxQuery = [PFQuery queryWithClassName:@"Messages"];
    
//    [inboxQuery whereKey:@"reciever" equalTo:[PFUser currentUser]]; // find all the recievers

    [inboxQuery whereKey:@"S_R" containsAllObjectsInArray:@[[PFUser currentUser]]];
    
    [inboxQuery includeKey:@"sender"];
    
    [inboxQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        NSArray * people = [PFUser currentUser][@"peopleSpoken"];
        
        
        for (PFUser * user in people)
        {
            NSMutableDictionary * conversation = [@{
                                                    
                                                    @"user": user,
                                                    @"messages":[@[] mutableCopy]
                                                    
                                                    } mutableCopy];
            
            for (PFObject * message in objects)
            {
                
                if (message[@"sender"] == user || message[@"reciever"] == user) {
                    
                    [conversation[@"messages"] addObject:message];
                    
                }
                
            }
            
            
            [myConversations addObject:conversation];
            
            
            
        }
        
        [self.tableView reloadData];
        
        NSLog(@"my messages are %@", myConversations);
        
    }];
    
    

    
    
}



//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    // Return the number of sections.
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return myConversations.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InboxCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messagePeople" forIndexPath:indexPath];
    
    
    cell.myMessagesCell = myConversations[indexPath.row];
    

    if (cell == nil) {
        
        cell = [[InboxCustomCell alloc]init];
    }
 
    
    
//     Configure the cell...
   
    return cell;
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
