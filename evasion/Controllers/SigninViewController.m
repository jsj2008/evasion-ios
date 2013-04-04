//
//  SigninViewController.m
//  evasion
//
//  Created by Aymeric on 01/04/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "MainViewController.h"
#import "SigninViewController.h"
#import "FZUser.h"
#import "FZImage.h"


@interface SigninViewController ()

@end

@implementation SigninViewController

- (id)init{
    self = [super init];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor colorWithRed:32.0/255.0 green:32.0/255.0 blue:32.0/255.0 alpha:1.0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Logo
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake((320/2)-100, 87, 200, 26)];
    [logo setImage:[UIImage imageNamed:@"signin-logo.png"]];
    [self.view addSubview:logo];
    
    
    // Button Sign In
    self.buttonSignin = [[UIButton alloc] initWithFrame:CGRectMake(60, 300, 200, 40)];
    [self.buttonSignin  setBackgroundImage:[FZImage imageWithColor:[UIColor colorWithRed:52.0/255.0 green:82.0/255.0 blue:111.0/255.0 alpha:1.0]] forState:UIControlStateNormal];
    [self.buttonSignin  setBackgroundImage:[FZImage imageWithColor:[UIColor colorWithRed:41.0/255.0 green:64.0/255.0 blue:87.0/255.0 alpha:1.0]] forState:UIControlStateHighlighted];
    [self.buttonSignin .layer setCornerRadius:2.0];
    [self.buttonSignin  setClipsToBounds:YES];
    [self.buttonSignin  setTitle:@"Sign in with Tumblr" forState:UIControlStateNormal];
    [self.buttonSignin  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.buttonSignin .titleLabel setFont:[UIFont fontWithName:@"Gibson-SemiBold" size:15]];
    [self.buttonSignin  addTarget:self action:@selector(actionOAuth) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonSignin];
    
    
    // Button Sign out
    self.buttonSignout = [[UIButton alloc] initWithFrame:CGRectMake(60, 300, 90, 40)];
    [self.buttonSignout  setBackgroundImage:[FZImage imageWithColor:[UIColor colorWithRed:179.0/255.0 green:54.0/255.0 blue:54.0/255.0 alpha:1.0]] forState:UIControlStateNormal];
    [self.buttonSignout  setBackgroundImage:[FZImage imageWithColor:[UIColor colorWithRed:154.0/255.0 green:46.0/255.0 blue:46.0/255.0 alpha:1.0]] forState:UIControlStateHighlighted];
    [self.buttonSignout .layer setCornerRadius:2.0];
    [self.buttonSignout  setClipsToBounds:YES];
    [self.buttonSignout  setTitle:@"Sign out" forState:UIControlStateNormal];
    [self.buttonSignout  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.buttonSignout .titleLabel setFont:[UIFont fontWithName:@"Gibson-SemiBold" size:15]];
    [self.buttonSignout  addTarget:self action:@selector(actionSignOut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonSignout];
    
    // Button Explore
    self.buttonExplore = [[UIButton alloc] initWithFrame:CGRectMake(60+90+20, 300, 90, 40)];
    [self.buttonExplore  setBackgroundImage:[FZImage imageWithColor:[UIColor colorWithRed:52.0/255.0 green:82.0/255.0 blue:111.0/255.0 alpha:1.0]] forState:UIControlStateNormal];
    [self.buttonExplore  setBackgroundImage:[FZImage imageWithColor:[UIColor colorWithRed:41.0/255.0 green:64.0/255.0 blue:87.0/255.0 alpha:1.0]] forState:UIControlStateHighlighted];
    [self.buttonExplore .layer setCornerRadius:2.0];
    [self.buttonExplore  setClipsToBounds:YES];
    [self.buttonExplore  setTitle:@"Explore" forState:UIControlStateNormal];
    [self.buttonExplore  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.buttonExplore .titleLabel setFont:[UIFont fontWithName:@"Gibson-SemiBold" size:15]];
    [self.buttonExplore  addTarget:self action:@selector(actionExplore) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonExplore];
    
    
    if([FZUser sharedUser].connected){
        [self.buttonSignin setHidden:YES];
    }
    else{
        [self.buttonSignout setHidden:YES];
        [self.buttonExplore setHidden:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionOAuth{
    
    OAuthViewController *oauthController = [[OAuthViewController alloc] init];
    oauthController.delegate = self;
    UINavigationController *oauthNav = [[UINavigationController alloc] initWithRootViewController:oauthController];
    
    [self presentViewController:oauthNav animated:YES completion:nil];
}

- (void)actionSignOut{
    
    [[FZUser sharedUser] signOut];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.buttonSignout.alpha = 0.0;
        self.buttonExplore.alpha = 0.0;
    }
    completion:^(BOOL finished){
        self.buttonSignin.hidden = NO;
    
        self.buttonSignout.hidden = YES;
        self.buttonSignout.alpha = 1.0;
        self.buttonExplore.hidden = YES;
        self.buttonExplore.alpha = 1.0;
    }];
}

- (void)actionExplore{
    //MainViewController *mainController = [[MainViewController alloc] init];
    [self.navigationController pushViewController:sharedAppDelegate.mainController animated:YES];
}

- (void)OAuthCallback:(NSDictionary *)OAuthData{
    [[FZUser sharedUser] getAccessTokenWithData:OAuthData];
    
    self.buttonSignin.hidden = YES;
    self.buttonSignout.hidden = NO;
    self.buttonExplore.hidden = NO;
}

@end
