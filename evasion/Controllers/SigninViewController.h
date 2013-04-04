//
//  SigninViewController.h
//  evasion
//
//  Created by Aymeric on 01/04/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import "FZViewController.h"
#import "OAuthViewController.h"

@interface SigninViewController : FZViewController <OAuthDelegate>

@property (strong, nonatomic) UIButton *buttonSignin;
@property (strong, nonatomic) UIButton *buttonSignout;
@property (strong, nonatomic) UIButton *buttonExplore;
@property (strong, nonatomic) UIButton *buttonNoSign;

@end
