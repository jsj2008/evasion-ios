//
//  MainViewController.h
//  evasion
//
//  Created by Aymeric on 23/03/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import "FZViewController.h"

#import <RestKit/RestKit.h>

@interface MainViewController : FZViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (strong, nonatomic) NSArray *data;
@property (assign, nonatomic) BOOL loading;
@property (assign, nonatomic) BOOL refresh;
@property (assign, nonatomic) int posts;
@property (assign, nonatomic) int offset;

@end
