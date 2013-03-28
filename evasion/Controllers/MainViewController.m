//
//  MainViewController.m
//  evasion
//
//  Created by Aymeric on 23/03/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import "MainViewController.h"
#import "PostViewController.h"

#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIButton+WebCache.h>

#import "FZDate.h"
#import "FZImage.h"

#import "Info.h"
#import "Post.h"
#import "Image.h"

static int image_with = 300;
static int image_padding_top = 10;
static int image_padding_bottom = 55;

static NSString *api_base = @"https://api.tumblr.com";
static NSString *api_endpoint_posts = @"/v2/blog/summerevasion.tumblr.com/posts/photo";
static NSString *api_endpoint_info = @"/v2/blog/summerevasion.tumblr.com/info";

static NSString *api_key = @"GCBoybPwsGdolRRM8ZnnoV8R8BYdmo5STjVSwFHsfoLqCeSVdC";

static int posts_limit = 10;
static int post_offset_start = 0;

@interface MainViewController ()

@end

@implementation MainViewController

- (id)init{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"EVASION";
        
        self.navigationItem.leftBarButtonItem = [self buttonSignin];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    int tableViewSizeHeight = 416;
    if(sharedAppDelegate.mainScreeniPhone5){
        tableViewSizeHeight += 88;
    }
    
    // TableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, tableViewSizeHeight)];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.view addSubview:self.tableView];
    
    // TableView RefreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getRefreshPost) forControlEvents:UIControlEventValueChanged];
    [self.refreshControl setTintColor:[UIColor colorWithRed:112.0/255.0 green:112.0/255.0 blue:112.0/255.0 alpha:1.0]];
    [self.tableView addSubview:self.refreshControl];
    
    
    
    //let AFNetworking manage the activity indicator
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:api_base]];

    RKObjectManager *manager = [[RKObjectManager alloc] initWithHTTPClient:client];

    
    
    RKObjectMapping *postMapping = [RKObjectMapping mappingForClass:[Post class]];
    [postMapping addAttributeMappingsFromDictionary:@{
        @"id":@"post_id",
        @"timestamp":@"timestamp",
        @"short_url":@"shortURL",
        @"note_count":@"likes",
        @"photos.alt_sizes":@"images"

     }];
    
    
    RKObjectMapping *imageMapping = [RKObjectMapping mappingForClass:[Image class]];
    [imageMapping addAttributeMappingsFromDictionary:@{
        @"url":@"image",
        @"width":@"width",
        @"height":@"height"
    }];
    
        
    //RKRelationshipMapping* relationShipMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"photos.alt_sizes" toKeyPath:@"images" withMapping:imageMapping];
    // [postMapping addPropertyMapping:relationShipMapping];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:postMapping pathPattern:api_endpoint_posts keyPath:@"response.posts" statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    RKObjectMapping *infoMapping = [RKObjectMapping mappingForClass:[Info class]];
    [infoMapping addAttributeMappingsFromArray:@[@"posts"]];
    RKResponseDescriptor *infoResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:infoMapping pathPattern:api_endpoint_info keyPath:@"response.blog" statusCodes:nil];
    [manager addResponseDescriptor:infoResponseDescriptor];
    
    [manager addResponseDescriptor:responseDescriptor];
    
    
    
    [self networkStatus];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getBlogInfo];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getPosts];
    });
}

- (void)networkStatus{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    // No network detect
    [objectManager.HTTPClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection"
                                                            message:@"You must be connected to the internet to use this app."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }];
}
- (void)getBlogInfo{
    
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    [objectManager getObjectsAtPath:api_endpoint_info parameters:@{@"api_key": api_key} success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
        Info *info = [[mappingResult array] objectAtIndex:0];
        self.posts = info.posts;
    }
    failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Loaded this error: %@", [error localizedDescription]);
    }];
}

- (void)getPosts{
    self.loading = YES;
    
    
    if(self.data.count == 0){
        self.offset = post_offset_start;
    }
    else if(self.refresh){
        self.offset = post_offset_start;
    }
    else{
        self.offset = self.offset + posts_limit;
    }
    
    
    RKObjectManager *objectManager = [RKObjectManager sharedManager];    

    [objectManager getObjectsAtPath:api_endpoint_posts parameters:@{@"api_key": api_key, @"limit":[NSString stringWithFormat:@"%d", posts_limit], @"offset":[NSString stringWithFormat:@"%d", self.offset]} success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
        [self dataLoaded:[mappingResult array]];
        
        self.loading = NO;
    }
    failure:^(RKObjectRequestOperation *operation, NSError *error) {
         NSLog(@"Loaded this error: %@", [error localizedDescription]);
        
        self.loading = NO;
    }];
}

- (void)getRefreshPost{
    self.refresh = YES;
    self.offset = 0;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getPosts];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dataLoaded:(NSArray*)dataResult{
    
    NSMutableArray *data = [[NSMutableArray alloc] init];
    
    for (Post *post in dataResult) {
        NSDictionary *imageLarge = [[post.images objectAtIndex:0] objectAtIndex:0];
        
        int widthOrigin = [[imageLarge objectForKey:@"width"] intValue] / 2;
        int heightOrigin = [[imageLarge objectForKey:@"height"] intValue] / 2;
        
        float coef = (float)image_with / (float)widthOrigin;
        
        // Image new size
        int width = widthOrigin * coef;
        int height = heightOrigin * coef;
        
        Image *image = [[Image alloc] init];
        [image setUrl:[imageLarge objectForKey:@"url"]];
        [image setWidth:width];
        [image setHeight:height];
        [post setImage:image];
        
        [data addObject:post];
    }
    
    if(self.data.count == 0){
        self.data = data;
    }
    else if(self.refresh){
        self.data = data;
    }
    else{
        self.data = [self.data arrayByAddingObjectsFromArray:data];
    }
    
    if(self.refresh){
        self.refresh = NO;
        [self.refreshControl endRefreshing];
    }
    
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(self.data.count > 0){
        return self.data.count + 1;
    }
    else{
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }

    
    if(indexPath.row == self.data.count){
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(150, 14, 20, 20)];
        [activity setBackgroundColor:[UIColor clearColor]];
        [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [activity startAnimating];
        
        [cell addSubview:activity];
        
        if(!self.loading){
            [self getPosts];
        }
        
        return cell;
    }
    
    
    Post *post = [self.data objectAtIndex:indexPath.row];
    
    // Cell selection
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    // Image
    UIButton *image = [[UIButton alloc] initWithFrame:CGRectMake(10, image_padding_top, post.image.width, post.image.height)];
    [image setBackgroundImageWithURL:[NSURL URLWithString:post.image.url] forState:UIControlStateNormal placeholderImage:[FZImage imageWithColor:[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0]]];
    [image addTarget:self action:@selector(actionPost:) forControlEvents:UIControlEventTouchUpInside];
    [image setTag:indexPath.row];
    [cell addSubview:image];
    
    // Likes
    int likesY = image.frame.origin.y + image.frame.size.height + 9;
    UIButton *likes = [[UIButton alloc] initWithFrame:CGRectMake(10, likesY, 60, 22)];
    [likes setBackgroundColor:[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0]];
    [likes.layer setCornerRadius:2.0];
    [cell addSubview:likes];
    
    // Like icon
    UIImageView *likesIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 6, 13, 11)];
    [likesIcon setImage:[UIImage imageNamed:@"like-darkgrey-small.png"]];
    [likes addSubview:likesIcon];
    
    // Like count format to String
    NSString *likesCountString;
    if(post.likes > 9999){
        NSString *likesString = [NSString stringWithFormat:@"%d", post.likes];
        likesCountString = [NSString stringWithFormat:@"%@k", [likesString substringToIndex:likesString.length-3]];
    }
    else{
        likesCountString = [NSString stringWithFormat:@"%d", post.likes];
    }
    
    // Like count
    UILabel *likeCount = [[UILabel alloc] initWithFrame:CGRectMake(22, 4, 33, 15)];
    [likeCount setText:likesCountString];
    [likeCount setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    [likeCount setTextColor:[UIColor colorWithRed:112.0/255.0 green:111.0/255.0 blue:111.0/255.0 alpha:1.0]];
    [likeCount setTextAlignment:NSTextAlignmentCenter];
    [likeCount setBackgroundColor:[UIColor clearColor]];
    //[likeCount sizeToFit];
    //float likeCountWidth = likeCount.frame.size.width;
    //[likeCount setFrame:CGRectMake(60-5-likeCountWidth, 4, likeCountWidth, likeCount.frame.size.height)];
    [likes addSubview:likeCount];
    
    
    // Date
    int dateY = image.frame.origin.y + image.frame.size.height + 14;
    UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(170, dateY, 140, 20)];
    [date setText:[FZDate timeSinceAtToday:post.timestamp]];
    [date setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    [date setTextColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0]];
    [date setTextAlignment:NSTextAlignmentRight];
    [date setBackgroundColor:[UIColor clearColor]];
    [date sizeToFit];
    float dateWidth = date.frame.size.width;
    [date setFrame:CGRectMake(320-10-dateWidth, dateY, dateWidth, date.frame.size.height)];
    [cell addSubview:date];
    
    // Date icon
    int dateIconX = date.frame.origin.x - 5 - 10;
    int dateIconY = dateY + 3;
    UIImageView *dateIcon = [[UIImageView alloc] initWithFrame:CGRectMake(dateIconX, dateIconY, 10, 10)];
    [dateIcon setImage:[UIImage imageNamed:@"date.png"]];
    [cell addSubview:dateIcon];
    
        
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == self.data.count){
        return 48;
    }
    else{
        Post *post = [self.data objectAtIndex:indexPath.row];
        
        int height = post.image.height + image_padding_top + image_padding_bottom;
        
        return height;
    }
}

- (void)actionPost:(id)sender{
    UIButton *source = (UIButton *)sender;
    
    Post *post = [self.data objectAtIndex:source.tag];
    
    PostViewController *postView = [[PostViewController alloc] initWithPost:post];
    [self.navigationController pushViewController:postView animated:YES];
}

@end
