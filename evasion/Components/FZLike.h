//
//  FZLike.h
//  evasion
//
//  Created by Aymeric Gallissot on 04/04/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FZLike : NSObject

+ (void)saveLike:(NSString*)postId;
+ (void)removeLike:(NSString*)postId;
+ (void)removeAllLikes;
+ (BOOL)getLike:(NSString*)postId;
+ (void)getAllLikes;

@end
