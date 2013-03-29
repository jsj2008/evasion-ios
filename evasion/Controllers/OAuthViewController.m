//
//  OAuthViewController.m
//  evasion
//
//  Created by Aymeric on 28/03/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import "OAuthViewController.h"

#import <RestKit/RestKit.h>
#import "STLOAuthClient.h"

static NSString *const api_key = @"GCBoybPwsGdolRRM8ZnnoV8R8BYdmo5STjVSwFHsfoLqCeSVdC";
static NSString *const api_secret = @"DyIG65Imaz2sP1Sh4l6GfwhJzE2hJgIc3gm1bB6o2yl2hXhQVt";

@interface OAuthViewController ()

@end

@implementation OAuthViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    STLOAuthClient *client = [[STLOAuthClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.tumblr.com/"]];
    [client setConsumerKey:api_key secret:api_secret];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"m@aymericgallissot.fr", @"x_auth_username",
                            @"1234", @"x_auth_password",
                            @"client_auth", @"x_auth_mode",
                            nil];
    
    [client getPath:@"oauth/access_token/" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"SUccess %@", operation.responseString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure, %@", error);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
