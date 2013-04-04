//
//  AppDelegate.h
//  evasion
//
//  Created by Aymeric on 23/03/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *mainNav;
@property (strong, nonatomic) MainViewController *mainController;

@property (assign, nonatomic) int mainScreeniPhone5;

@property (strong, nonatomic) UIColor *likeBackgroundColor;
@property (strong, nonatomic) UIColor *likeActiveBackgroundColor;
@property (strong, nonatomic) UIColor *likeColor;
@property (strong, nonatomic) UIColor *likeActiveColor;
@property (strong, nonatomic) UIImage *likeIcon;
@property (strong, nonatomic) UIImage *likeActiveIcon;
@property (strong, nonatomic) UIImage *likeIconSmall;
@property (strong, nonatomic) UIImage *likeActiveIconSmall;

@end
