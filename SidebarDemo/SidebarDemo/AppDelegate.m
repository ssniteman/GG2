//
//  AppDelegate.m
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <GoogleMaps/GoogleMaps.h>
#import <Accelerate/Accelerate.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

    // Change the background color of navigation bar
    
    [GMSServices provideAPIKey:@"AIzaSyB4ofpcgXU4uuuyHpADlh2xsvx26emV3qg"];

    
    [Parse setApplicationId:@"3iYwTMywkleelnVUpiZdaXPPqVpvDsxw5qsJ1pev"
                            clientKey:@"urfBXQFyT2Ur3bYuIZYAaqBppcmnY1buRw7EDOKU"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [PFUser enableAutomaticUser];
    
    // Register for Push Notitications, if running iOS 8
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                        UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else {
        // Register for Push Notifications before iOS 8
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeAlert |
                                                         UIRemoteNotificationTypeSound)];
    }
    
    
    
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    

    
    
    
    // Change the font style of the navigation bar
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 0);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:10.0/255.0 green:10.0/255.0 blue:10.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"Helvetica-Light" size:21.0], NSFontAttributeName, nil]];
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    
    NSLog(@"%@",deviceToken);
    currentInstallation[@"user"] = [PFUser currentUser];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    
    //See what this prints and
    NSLog(@"this is the user info %@",userInfo);
    
    
    NSLog(@"daddy got it");
    
    //DO THIS CODE BASED OFF The USER INFO
    
    
    //TEST this with TWO Phones
    
//     add sender to my people spoken to
    
//    [[PFUser currentUser] refreshInBackgroundWithBlock:^(PFObject * object, NSError * error) {
//       
//        PFQuery * senderQuery = [PFUser query];
//        [senderQuery whereKey:@"username" equalTo:userInfo[@"sender"]];
//        
//        [senderQuery findObjectsInBackgroundWithBlock:^(NSArray * objects, NSError * error) {
//            
//            
//            if (objects.count > 0) {
//                
//                PFUser * currentUser = (PFUser *)object;
//                PFUser * sender = objects[0];
//                
//                NSMutableArray * peopleSpokenTo = [currentUser[@"peopleSpoken"] mutableCopy];
//                
//                if (peopleSpokenTo == nil) {
//                    peopleSpokenTo = [@[] mutableCopy];
//                }
//                
//                BOOL foundUser = NO;
//                for (PFUser * user in peopleSpokenTo)
//                {
//                    if ([user.objectId isEqualToString:sender.objectId]) foundUser = YES;
//                }
//                
//                if (!foundUser)
//                {
//                    [peopleSpokenTo addObject:sender];
//                }
//                
//                currentUser[@"peopleSpoken"] = peopleSpokenTo;
//                
//                [currentUser saveInBackground];
//                
//            }
//            
//        }];
//        
//    }];
    
    
//    NSMutableArray * peopleSpokenTo = [self.toUser[@"peopleSpoken"] mutableCopy];
//
//    [peopleSpokenTo addObject:self.currentUser];


    
    //Displays the alert
    
    [PFPush handlePush:userInfo];

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
