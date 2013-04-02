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

- (void)getAccessTokenWithData:(NSDictionary*)oauthData;

@end
