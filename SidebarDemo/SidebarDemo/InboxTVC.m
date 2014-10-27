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
#import "ConversationsVC.h"

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
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu3.png"]style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    
    revealButtonItem.tintColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    // QUERYING FOR PEOPLE YOU'RE CHATTING WITH
    
    PFQuery * inboxQuery = [PFQuery queryWithClassName:@"Messages"];
    
//    [inboxQuery whereKey:@"reciever" equalTo:[PFUser currentUser]]; // find all the recievers

    [inboxQuery whereKey:@"S_R" containsAllObjectsInArray:@[[PFUser currentUser]]];
    
    [inboxQuery includeKey:@"sender"];
    
    [inboxQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        PFQuery * userQuery = [PFUser query];

        PFUser * currentUser = (PFUser *)[userQuery getObjectWithId:[PFUser currentUser].objectId];
        
        NSArray * people = currentUser[@"peopleSpoken"];
        
        
        for (PFUser * user in people)
        {
            NSMutableDictionary * conversation = [@{
                                                    
                                                    @"user": user,
                                                    @"messages":[@[] mutableCopy]
                                                    
                                                    } mutableCopy];
            
            for (PFObject * message in objects)
            {
                
                PFUser * sender = (PFUser *)message[@"sender"];
                PFUser * reciever = (PFUser *)message[@"reciever"];
                
                if ([sender.objectId isEqualToString:user.objectId] || [reciever.objectId isEqualToString:user.objectId]) {
                    
                    [conversation[@"messages"] addObject:message];
                }
            }
            
            [myConversations addObject:conversation];
            
        }
        
        //TO DO
        for (NSDictionary * conversation in myConversations) {
            
            
            //NSLog(@"my messages are %@", conversation[@"messages"]);
            
            for (PFObject * message in conversation[@"messages"]) {
                
                NSString * text = message[@"messageContent"];
                
                NSLog(@"The actual MESSAGE: %@",text);
            }
            
            
        }
        
        [self.tableView reloadData];
        

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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ConversationsVC * conversation = [[ConversationsVC alloc]init];
    
    conversation.conversationThread = myConversations [indexPath.row];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
