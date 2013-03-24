//
//  Post.h
//  evasion
//
//  Created by Aymeric on 23/03/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Image.h"

@interface Post : NSObject

@property (assign, nonatomic) int post_id;
@property (assign, nonatomic) int timestamp;
@property (strong, nonatomic) NSString *shortURL;
@property (strong, nonatomic) NSArray *images;
@property (assign, nonatomic) int likes;
@property (strong, nonatomic) Image *image;

@end
