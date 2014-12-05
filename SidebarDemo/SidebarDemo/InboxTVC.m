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

- (void)viewWillAppear:(BOOL)animated
{
    
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];

    myConversations = [@[] mutableCopy];
    
    SWRevealViewController *revealController = [self revealViewController];
    
    //[self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu3.png"]style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    
    revealButtonItem.tintColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    PFQuery * inboxQueryOne = [PFQuery queryWithClassName:@"Messages"];
    
    [inboxQueryOne findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
       
        NSLog(@"des nuts %@",[objects[0] createdAt]);
        
    }];

    
    
    // QUERYING FOR PEOPLE YOU'RE CHATTING WITH
    
    PFQuery * inboxQuery = [PFQuery queryWithClassName:@"Messages"];
    
    [inboxQuery whereKey:@"S_R" containsAllObjectsInArray:@[[PFUser currentUser]]];
    [inboxQuery includeKey:@"sender"];
    [inboxQuery includeKey:@"reciever"];
    [inboxQuery includeKey:@"S_R"];
    
    
    [inboxQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
//        NSLog(@"%@",objects);
//        PFQuery * userQuery = [PFUser query];
//
//        currentUser = (PFUser *)[userQuery getObjectWithId:[PFUser currentUser].objectId];
//        
//        NSLog(@"current user %@", currentUser);
//        
//        NSArray * people = currentUser[@"peopleSpoken"];
       
        if (objects.count > 0) {
            
            NSMutableArray * people = [@[] mutableCopy];
            
            for (PFObject * message in objects) {
                
//                NSLog(@"sender %@",message[@"sender"]);
//                NSLog(@"reciever %@",message[@"reciever"]);
//                NSLog(@"S_R %@",message[@"S_R"]);
                
                NSArray * participants = @[message[@"sender"],message[@"reciever"]];
                
                
                for (PFUser * user in participants) {
                    
                    if (![user.objectId isEqual:[PFUser currentUser].objectId]) {
                        
                        BOOL foundUser = NO;
                        
                        for (PFUser * person in people)
                        {
                            if ([person.objectId isEqualToString:user.objectId])
                            {
                                foundUser = YES;
                            }
                        }
                        
                        if (!foundUser)
                        {
                            [people addObject:user];
                        }
                        
                    }
                    
                }
                
            }
            NSLog(@"hello");
            NSLog(@"%@",people);
            
            [self layoutConversationsWithPeople:people andMessages:objects];
            
        }
        
        

    }];

}

- (void)layoutConversationsWithPeople:(NSArray *)people andMessages:(NSArray *)messages {
    
    /*
     
    - user
        - grabbed preople spoken to
            - used them to get messages
                - ordered conversations by people spoken to
     
     - grabbing all messages that have me in S_R
        - loop through those and grab unique participants
             - ordered conversations by unique participants
     
     
    
    */
    
    for (PFUser * user in people)
        
    {
        
        NSMutableDictionary * conversation = [@{
                                                @"date":[NSDate date],
                                                @"user": user,
                                                @"messages":[@[] mutableCopy]
                                                } mutableCopy];
        
        for (PFObject * message in messages)
        {
            NSDate *createdDate = [message createdAt];
            
            PFUser * sender = (PFUser *)message[@"sender"];
            PFUser * reciever = (PFUser *)message[@"reciever"];
//            PFUser * createdAt = (PFUser *)message[@"createdAt"];
            
            if ([sender.objectId isEqualToString:user.objectId] || [reciever.objectId isEqualToString:user.objectId]) {
                
                conversation[@"date"] = createdDate;
                
                [conversation[@"messages"] insertObject:message atIndex:0];
            }
        }
        
        //NSLog(@"DATE IS THIS %@",conversation[@"date"]);
        
        // orders inbox by date -- last recieved first
        
        [myConversations insertObject:conversation atIndex:0];
        
//        NSLog(@"my conversations are %@",myConversations);
        
        
    }
    
   // NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"beginDate" ascending:TRUE];
   // [myConversations sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];

    
//    for (NSDictionary * conversation in myConversations) {
//        
//        
//        for (PFObject * message in conversation[@"messages"]) {
//            
//            NSString * text = message[@"messageContent"];
//            
//            NSLog(@"The actual MESSAGE: %@",text);
//        }
//        
//        
//    }
    
    [self.tableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return myConversations.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InboxCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messagePeople" forIndexPath:indexPath];
    
    NSArray * messages = myConversations[indexPath.row][@"messages"];
    
    int unReadCount = 0;
    
    for (PFObject * message in messages)
    {
        PFUser * reciever = message[@"reciever"];
        
        // if the message is to me and unread... then update unread count
        if (![message[@"read"] boolValue] && [reciever.objectId isEqualToString:[PFUser currentUser].objectId]) { unReadCount++; }
    }
    
    if (unReadCount > 0)
    {
        cell.inboxMessagePhoto.layer.borderColor = [UIColor redColor].CGColor;
        cell.inboxMessagePhoto.layer.borderWidth = 2.0;
        // show red line on right
    } else {
        
        cell.inboxMessagePhoto.layer.borderWidth = 0.0;
    }
    
    
    NSString * lastMessage = myConversations[indexPath.row][@"messages"][0][@"messageContent"];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //        //uncomment to get the time only
    //        //[formatter setDateFormat:@"hh:mm a"];
    //        //[formatter setDateFormat:@"MMM dd, YYYY"];
   [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    cell.inboxMessageDate.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate: myConversations[indexPath.row][@"date"]]];
    
    cell.messagePreviewLabel.text = lastMessage;
    
    cell.myMessagesCell = myConversations[indexPath.row];
    
    NSLog(@"CONVO %@", myConversations[indexPath.row]);
    
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
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//
//    
//    
//    
//    ConversationsVC * conversation = [[ConversationsVC alloc]init];
// 
//    // This is the array that contains just the conversation that you select
//    self.messages = [@[]mutableCopy];
//
//    
//    //Going through all your messages in your inbox
//    for (PFObject * messageAndUser in myConversations[indexPath.row][@"messages"]) {
//        
//        //adding to the messages array just the messages from the cell you select ... IndexPath.Row
//        [self.messages addObject:messageAndUser[@"messageContent"]];
//      
//    }
//    
//    
//    UINavigationController *navigationController =
//        [[UINavigationController alloc] initWithRootViewController:conversation];
//    
//        //now present this navigation controller modally
//        [self presentViewController:navigationController animated:YES completion:nil];
//    
//  //  After you get the mesages from that cell or person, you pass it to the next view...This is just the array of that one conversation
//    
//    NSLog(@"%d",(int)self.messages.count);
//    
//    conversation.messages = self.messages;
//
//}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        PFQuery * deleteQuery = [PFQuery queryWithClassName:@"Messages"];

        NSDictionary * conversation = myConversations[indexPath.row];
        
        PFUser * user = conversation[@"user"];
        
        [deleteQuery whereKey:@"S_R" containsAllObjectsInArray:@[user,[PFUser currentUser]]];
        
        [deleteQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
           
            [PFObject deleteAllInBackground:objects];
            
        }];
        
        [myConversations removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    ConversationsVC * convoVC = segue.destinationViewController;
    
    InboxCustomCell * cell = (InboxCustomCell *)sender;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
//    NSMutableArray * messages = [@[] mutableCopy];
//    
//    for (PFObject * messageAndUser in myConversations[indexPath.row][@"messages"]) {
//        
//        //adding to the messages array just the messages from the cell you select ... IndexPath.Row
//        [messages addObject:messageAndUser[@"messageContent"]];
//        
//    }
//    
//    //  After you get the mesages from that cell or person, you pass it to the next view...This is just the array of that one conversation
//    
//    NSLog(@"%d",(int)self.messages.count);
    
    convoVC.messages = myConversations[indexPath.row][@"messages"];
    convoVC.conversationThread = myConversations[indexPath.row];

    
    //NSLog(@"convoVC messages are %@", convoVC.messages);
   // NSLog(@"convoVC conversation thread is %@", convoVC.conversationThread);

    
}

@end
