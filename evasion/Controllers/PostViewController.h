//
//  PostViewController.h
//  evasion
//
//  Created by Aymeric on 24/03/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import "FZViewController.h"

#import <RestKit/RestKit.h>

#import "Post.h"

@interface PostViewController : FZViewController <UIScrollViewDelegate>

@property (strong, nonatomic) Post *post;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIButton *like;
@property (strong, nonatomic) UIImageView *likeIcon;
@property (strong, nonatomic) UILabel *likeText;

- (id)initWithPost:(Post *)post;

@end
