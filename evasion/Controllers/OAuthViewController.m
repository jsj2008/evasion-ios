//
//  OAuthViewController.m
//  evasion
//
//  Created by Aymeric on 01/04/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import "OAuthViewController.h"

@interface OAuthViewController ()

@end

@implementation OAuthViewController

- (id)init{
    self = [super init];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"Sign in with Tumblr";
        self.navigationItem.leftBarButtonItem = [self buttonClose];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    NSString *authenticateURLString = @"http://oauth.summerevasion.com/signin";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:authenticateURLString]];
    [self.webView loadRequest:request];
    self.webView.scalesPageToFit = YES;
    
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"data: %@",[[request URL] query]);
    
    NSArray *parameters = [[[request URL] query] componentsSeparatedByString:@"&"];
    
    if(parameters.count == 2){
        NSArray *test_oauth_token = [[parameters objectAtIndex:0] componentsSeparatedByString:@"="];
        
        NSArray *test_oauth_verifier = [[parameters objectAtIndex:1] componentsSeparatedByString:@"="];
        
        if([[test_oauth_token objectAtIndex:0] isEqualToString:@"oauth_token"] && [[test_oauth_verifier objectAtIndex:0] isEqualToString:@"oauth_verifier"]){
            NSLog(@"GOOD");
            [self dismissViewControllerAnimated:YES completion:nil];
            return NO;
        }
        else{
            return YES;
        }
    }
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [cookieJar cookies]) {
        if([[cookie name] isEqualToString:@"request_token"]){
           NSLog(@"%@: %@", [cookie name], [cookie value]);
        }
        if([[cookie name] isEqualToString:@"request_token_secret"]){
            NSLog(@"%@: %@", [cookie name], [cookie value]);
        }
        
    }
    //NSString *URLString = [[self.webView.request URL] absoluteString];
    //NSLog(@"--> %@", URLString);
}

@end