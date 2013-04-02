//
//  FZUser.m
//  evasion
//
//  Created by Aymeric Gallissot on 02/04/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import "FZUser.h"

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
        
        /*
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        // Connected
        if([defaults objectForKey:DATA_CONNECTED]) {
            if([[defaults objectForKey:DATA_CONNECTED] isEqualToString:@"YES"]){
                self.connected = YES;
            }
            else{
                self.connected = NO;
            }
        }
        else{
            [defaults setObject:@"NO" forKey:DATA_CONNECTED];
            [defaults synchronize];
            self.connected = NO;
        }
        */
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
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSLog(@"Access Token: %@", json);
    });

    //[self performSelector:@selector(secondUpdate) withObject:nil afterDelay:5.0];
}

@end
