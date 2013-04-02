//
//  SigninViewController.m
//  evasion
//
//  Created by Aymeric on 01/04/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import "SigninViewController.h"
#import "FZUser.h"


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
    
    UIButton *buttonTumblr = [[UIButton alloc] initWithFrame:CGRectMake(60, 300, 200, 40)];
    [buttonTumblr setBackgroundColor:[UIColor colorWithRed:64.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0]];
    [buttonTumblr addTarget:self action:@selector(actionOAuth) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonTumblr];
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

- (void)OAuthCallback:(NSDictionary *)OAuthData{
    [[FZUser sharedUser] getAccessTokenWithData:OAuthData];
}

@end
