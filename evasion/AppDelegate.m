//
//  AppDelegate.m
//  evasion
//
//  Created by Aymeric on 23/03/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import "AppDelegate.h"

#import "MainViewController.h"
#import "SigninViewController.h"

#import "FZUser.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // Set Like style
    self.likeBackgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0];
    self.likeActiveBackgroundColor = [UIColor colorWithRed:61.0/255.0 green:61.0/255.0 blue:61.0/255.0 alpha:1.0];
    self.likeColor = [UIColor colorWithRed:112.0/255.0 green:111.0/255.0 blue:111.0/255.0 alpha:1.0];
    self.likeActiveColor = [UIColor whiteColor];
    self.likeIcon = [UIImage imageNamed:@"like-darkgrey.png"];
    self.likeActiveIcon = [UIImage imageNamed:@"like-white.png"];
    self.likeIconSmall = [UIImage imageNamed:@"like-darkgrey-small.png"];
    self.likeActiveIconSmall = [UIImage imageNamed:@"like-white-small.png"];
    
    // Screen iPhone 5
    if([[UIScreen mainScreen]bounds].size.height == 568){
        self.mainScreeniPhone5 = YES;
    }
    else{
        self.mainScreeniPhone5 = NO;
    }
    

    
    self.mainController = [[MainViewController alloc] init];
    SigninViewController *signinController = [[SigninViewController alloc] init];
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:signinController];
    
    // IF App already started
    if([[FZUser sharedUser] appAlreadyStarted])
        [mainNav pushViewController:self.mainController animated:NO];
    
    self.window.rootViewController = mainNav;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
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
