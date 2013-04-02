//
//  OAuthViewController.h
//  evasion
//
//  Created by Aymeric on 01/04/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import "FZViewController.h"

@class OAuthViewController;

@protocol OAuthDelegate <NSObject>

@optional
- (void)OAuthCallback:(NSDictionary*)OAuthData;

@end

////////////////////////////////////////////////////////////


@interface OAuthViewController : FZViewController <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@property (strong, nonatomic) NSString *request_token;
@property (strong, nonatomic) NSString *request_toke_secret;
@property (strong, nonatomic) NSString *oauth_token;
@property (strong, nonatomic) NSString *oauth_verifier;

@property (nonatomic, weak) id<OAuthDelegate> delegate;

@end

