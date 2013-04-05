//
//  FZUser.h
//  evasion
//
//  Created by Aymeric Gallissot on 02/04/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FZUser : NSObject

+ (FZUser *)sharedUser;

@property (strong, nonatomic) NSString *access_token;
@property (strong, nonatomic) NSString *access_token_secret;
@property (assign, nonatomic) BOOL connected;

- (void)getAccessTokenWithData:(NSDictionary*)oauthData;
- (void)signOut;

- (BOOL)appAlreadyStarted;
- (void)appStarted;

@end
