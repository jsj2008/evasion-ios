//
//  PostViewController.m
//  evasion
//
//  Created by Aymeric on 24/03/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import "PostViewController.h"

#import "FZDate.h"


@interface PostViewController ()

@end

@implementation PostViewController

- (id)initWithPost:(Post *)post{
    self = [super init];
    if (self) {
        self.post = post;
        self.title = [FZDate timeSinceAtToday:post.timestamp];
        
        self.navigationItem.leftBarButtonItem = [self buttonBack];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
