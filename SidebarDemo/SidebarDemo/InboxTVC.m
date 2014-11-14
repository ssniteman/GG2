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
#import "ConversationsVC.h"
#import <Parse/Parse.h>


@interface InboxTVC ()

@end

@implementation InboxTVC {
 
    NSMutableArray * myConversations;
    PFUser * friends;
    PFUser * currentUser;
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

        currentUser = (PFUser *)[userQuery getObjectWithId:[PFUser currentUser].objectId];
        
        NSLog(@"current user %@", currentUser);
        
        NSArray * people = currentUser[@"peopleSpoken"];
       

        
        for (PFUser * user in people)
            
        {

            NSMutableDictionary * conversation = [@{
                                            
                                            @"date":[NSDate date],
                                            @"user": user,
                                            @"messages":[@[] mutableCopy]
                                                    } mutableCopy];
            
            for (PFObject * message in objects)
            {
                NSDate *createdDate = [message createdAt];

                PFUser * sender = (PFUser *)message[@"sender"];
                PFUser * reciever = (PFUser *)message[@"reciever"];
                
                if ([sender.objectId isEqualToString:user.objectId] || [reciever.objectId isEqualToString:user.objectId]) {
                    
                    conversation[@"date"] = createdDate;
                    
                    [conversation[@"messages"] addObject:message];
                }
            }
            
            [myConversations addObject:conversation];
            
        }
        
        for (NSDictionary * conversation in myConversations) {
            
            
            for (PFObject * message in conversation[@"messages"]) {
                
                NSString * text = message[@"messageContent"];
                
                NSLog(@"The actual MESSAGE: %@",text);
            }
            
            
        }
        
        [self.tableView reloadData];
        

    }];

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return myConversations.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InboxCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messagePeople" forIndexPath:indexPath];
    
    NSString * lastMessage;
    
    for (PFObject * messageAndUser in myConversations[indexPath.row][@"messages"]) {
        
        lastMessage = messageAndUser[@"messageContent"];
        
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //        //uncomment to get the time only
    //        //[formatter setDateFormat:@"hh:mm a"];
    //        //[formatter setDateFormat:@"MMM dd, YYYY"];
   [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    cell.inboxMessageDate.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate: myConversations[indexPath.row][@"date"]]];
    
    cell.messagePreviewLabel.text = lastMessage;
    
    cell.myMessagesCell = myConversations[indexPath.row];
    
    if(currentUser[@"image"] == nil) {
        
        [cell.inboxMessagePhoto setBackgroundImage:[UIImage imageNamed:@"avatarcopy.jpg"] forState:UIControlStateNormal];
        
        
    }
    
    PFFile *imageFile = currentUser[@"image"];
    
            [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
    
                UIImage * image = [UIImage imageWithData:data];
                [cell.inboxMessagePhoto setBackgroundImage:image forState:UIControlStateNormal];
            }];

    if (cell == nil) {
        
        cell = [[InboxCustomCell alloc]init];
    }

   
    return cell;
}



//Cell You Select
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
    
    
    ConversationsVC * conversation = [[ConversationsVC alloc]init];
 
    // This is the array that contains just the conversation that you select
    self.messages = [@[]mutableCopy];

    
    //Going through all your messages in your inbox
    for (PFObject * messageAndUser in myConversations[indexPath.row][@"messages"]) {
        
        //adding to the messages array just the messages from the cell you select ... IndexPath.Row
        [self.messages addObject:messageAndUser[@"messageContent"]];
      
    }
    
    
    UINavigationController *navigationController =
        [[UINavigationController alloc] initWithRootViewController:conversation];
    
        //now present this navigation controller modally
        [self presentViewController:navigationController animated:YES completion:nil];
    
  //  After you get the mesages from that cell or person, you pass it to the next view...This is just the array of that one conversation
    
    NSLog(@"%d",self.messages.count);
    
    conversation.messages = self.messages;

}


@end
