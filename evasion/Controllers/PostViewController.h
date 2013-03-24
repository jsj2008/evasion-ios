//
//  PostViewController.h
//  evasion
//
//  Created by Aymeric on 24/03/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import "FZViewController.h"

#import "Post.h"

@interface PostViewController : FZViewController

@property (strong, nonatomic) Post *post;

- (id)initWithPost:(Post *)post;

@end
