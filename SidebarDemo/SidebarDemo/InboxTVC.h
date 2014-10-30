//
//  InboxTVC.h
//  SidebarDemo
//
//  Created by Shane Sniteman on 10/9/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InboxTVC : UITableViewController


@property(strong,nonatomic) NSMutableArray * messages;
@property (strong,nonatomic) NSDictionary * conversationThread;



@end
