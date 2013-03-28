//
//  PostViewController.h
//  evasion
//
//  Created by Aymeric on 24/03/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import "FZViewController.h"

#import "Post.h"

@interface PostViewController : FZViewController <UIScrollViewDelegate>

@property (strong, nonatomic) Post *post;

@property (strong, nonatomic) UIScrollView *scrollView;

- (id)initWithPost:(Post *)post;

@end
