//
//  FZViewController.m
//  evasion
//
//  Created by Aymeric on 23/03/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import "FZViewController.h"

#import "FZImage.h"

@interface FZViewController ()

@end

@implementation FZViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // NavBar Background
    [[UINavigationBar appearance] setBackgroundImage:[FZImage imageWithColor:[UIColor colorWithRed:32.0/255.0 green:32.0/255.0 blue:32.0/255.0 alpha:1.0]] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[FZImage imageWithColor:[UIColor colorWithWhite:1.0 alpha:0.0]]];
    
    // NavBar Text
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary: [[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIFont fontWithName:@"Gibson-SemiBold" size:18] forKey:UITextAttributeFont];
    [titleBarAttributes setValue:[NSValue valueWithUIOffset:UIOffsetMake(0, 0)] forKey:UITextAttributeTextShadowOffset];
    [titleBarAttributes setValue:[UIColor colorWithRed:183.0/255.0 green:183.0/255.0 blue:183.0/255.0 alpha:1.0] forKey:UITextAttributeTextColor];
    [[UINavigationBar appearance] setTitleTextAttributes:titleBarAttributes];
    [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:4.0 forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
     

- (UIBarButtonItem *)buttonSignin{
    UIButton *buttonNow = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonNow addTarget:self action:@selector(actionBack) forControlEvents:UIControlEventTouchUpInside];
    [buttonNow setBackgroundImage:[UIImage imageNamed:@"nav-home.png"] forState:UIControlStateNormal];
    [buttonNow setFrame:CGRectMake(-5, 0, 44, 44)];
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [containerView addSubview:buttonNow];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:containerView];
    
    return barButtonItem;
}

- (UIBarButtonItem *)buttonBack{
    UIButton *buttonNow = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonNow addTarget:self action:@selector(actionBack) forControlEvents:UIControlEventTouchUpInside];
    [buttonNow setBackgroundImage:[UIImage imageNamed:@"nav-back.png"] forState:UIControlStateNormal];
    [buttonNow setFrame:CGRectMake(-5, 0, 44, 44)];
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [containerView addSubview:buttonNow];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:containerView];
    
    return barButtonItem;
}

- (UIBarButtonItem *)buttonClose{
    UIButton *buttonNow = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonNow addTarget:self action:@selector(actionClose) forControlEvents:UIControlEventTouchUpInside];
    [buttonNow setBackgroundImage:[UIImage imageNamed:@"nav-close.png"] forState:UIControlStateNormal];
    [buttonNow setFrame:CGRectMake(-5, 0, 44, 44)];
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [containerView addSubview:buttonNow];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:containerView];
    
    return barButtonItem;
}


- (void)actionBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)actionClose{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
