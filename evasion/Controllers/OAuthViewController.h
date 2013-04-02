//
//  OAuthViewController.h
//  evasion
//
//  Created by Aymeric on 01/04/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import "FZViewController.h"

@interface OAuthViewController : FZViewController <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@end
