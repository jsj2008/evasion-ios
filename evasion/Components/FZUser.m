//
//  FZUser.m
//  evasion
//
//  Created by Aymeric Gallissot on 02/04/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import "FZUser.h"

#define DATA_OAUTH_TOKEN @"FZTumblrOAuthToken"
#define DATA_OAUTH_TOKEN_SECRET @"FZTumblrOAuthTokenSecret"

@implementation FZUser

static FZUser *sharedUser = nil;

+ (FZUser *)sharedUser{
    
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedUser = [[FZUser alloc] init];
    });
    
    return sharedUser;
}

- (id)init{
    
	if ((self = [super init]) != nil){
        
        NSLog(@"FZUser: init");
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        // Access token
        if([defaults objectForKey:DATA_OAUTH_TOKEN] && [defaults objectForKey:DATA_OAUTH_TOKEN_SECRET]) {
            self.access_token = [defaults objectForKey:DATA_OAUTH_TOKEN];
            self.access_token_secret = [defaults objectForKey:DATA_OAUTH_TOKEN_SECRET];
            self.connected = YES;
        }
        else{
            self.access_token = nil;
            self.access_token_secret = nil;
            self.connected = NO;
        }
    }
    
	return self;
}

- (void)getAccessTokenWithData:(NSDictionary*)oauthData{
    
    NSString *url = [NSString stringWithFormat:@"http://oauth.summerevasion.com/callback?oauth_token=%@&oauth_verifier=%@&request_token=%@&request_toke_secret=%@",
                     [oauthData objectForKey:@"oauth_token"],
                     [oauthData objectForKey:@"oauth_verifier"],
                     [oauthData objectForKey:@"request_token"],
                     [oauthData objectForKey:@"request_toke_secret"]];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        NSDictionary *access_token = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSLog(@"Access Token: %@", access_token);
        [self saveAccessToken:access_token];
        
    });

    //[self performSelector:@selector(secondUpdate) withObject:nil afterDelay:5.0];
}

- (void)saveAccessToken:(NSDictionary*)accessToken{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[accessToken objectForKey:@"oauth_token"] forKey:DATA_OAUTH_TOKEN];
    [defaults setObject:[accessToken objectForKey:@"oauth_token_secret"] forKey:DATA_OAUTH_TOKEN_SECRET];
    [defaults synchronize];
    
    self.access_token = [accessToken objectForKey:@"oauth_token"];
    self.access_token_secret = [accessToken objectForKey:@"oauth_token_secret"];
    self.connected = YES;
}

- (void)signOut{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:DATA_OAUTH_TOKEN];
    [defaults removeObjectForKey:DATA_OAUTH_TOKEN_SECRET];
    [defaults synchronize];
    
    self.access_token = nil;
    self.access_token_secret = nil;
    self.connected = NO;
}

@end
