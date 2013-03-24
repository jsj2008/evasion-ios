//
//  Image.h
//  evasion
//
//  Created by Aymeric on 23/03/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Image : NSObject

@property (strong, nonatomic) NSString *url;
@property (assign, nonatomic) int width;
@property (assign, nonatomic) int height;

@end
