//
//  FZLike.m
//  evasion
//
//  Created by Aymeric Gallissot on 04/04/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import "FZLike.h"

@implementation FZLike

+ (void)saveLike:(NSString*)postId{
        
    NSString *plistFile = [self plistFile];
    NSString *bundleFile = [[NSBundle mainBundle]pathForResource:@"Likes" ofType:@"plist"];

    //copy the file from the bundle to the doc directory
    [[NSFileManager defaultManager]copyItemAtPath:bundleFile toPath:plistFile error:nil];
    
    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithContentsOfFile:plistFile];
    
    
    // Add like
    if(![data objectForKey:postId]){
        [data setValue:[NSNumber numberWithBool:YES] forKey:postId];
        [data writeToFile:plistFile atomically:YES];
    }

}


+ (void)removeLike:(NSString*)postId{
        
    NSString *plistFile = [self plistFile];
    NSString *bundleFile = [[NSBundle mainBundle]pathForResource:@"Likes" ofType:@"plist"];
    
    //copy the file from the bundle to the doc directory
    [[NSFileManager defaultManager]copyItemAtPath:bundleFile toPath:plistFile error:nil];
    
    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithContentsOfFile:plistFile];
    
    
    // Remove like
    if([data objectForKey:postId]){
        [data removeObjectForKey:postId];
        [data writeToFile:plistFile atomically:YES];
    }
}


+ (void)removeAllLikes{
    
    NSString *plistFile = [self plistFile];
    NSString *bundleFile = [[NSBundle mainBundle]pathForResource:@"Likes" ofType:@"plist"];
    
    //copy the file from the bundle to the doc directory
    [[NSFileManager defaultManager]copyItemAtPath:bundleFile toPath:plistFile error:nil];
    
    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithContentsOfFile:plistFile];
    
    
    // Remove all like
    [data removeAllObjects];
    [data writeToFile:plistFile atomically:YES];
}

+ (BOOL)getLike:(NSString*)postId{
    
    NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:[self plistFile]];
        
    if([data objectForKey:postId]){
        return YES;
    }
    else{
        return NO;
    }
}


+ (void)getAllLikes{
    NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:[self plistFile]];
    
    NSLog(@"%@", data);
}

+ (NSString *)plistFile{
    NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFolder = [documentPath objectAtIndex:0];
    NSString *newPlistFile = [documentFolder stringByAppendingPathComponent:@"Likes.plist"];
    
    return newPlistFile;
}

@end
