//
//  PostViewController.m
//  evasion
//
//  Created by Aymeric on 24/03/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import "PostViewController.h"

#import <SDWebImage/UIImageView+WebCache.h>

#import <Social/Social.h>

#import "FZDate.h"
#import "FZImage.h"

static int image_padding_top = 10;
static int image_padding_bottom = 10 + 40 + 10;

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
	
    int scrollViewHeight = 416;
    if(sharedAppDelegate.mainScreeniPhone5){
        scrollViewHeight += 88;
    }
    
    int scrollViewContentHeight = image_padding_top + self.post.image.height + image_padding_bottom;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, scrollViewHeight)];
    [self.scrollView setDelegate:self];
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, scrollViewContentHeight)];
    [self.view addSubview:self.scrollView];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(10, image_padding_top, self.post.image.width, self.post.image.height)];
    [image setImageWithURL:[NSURL URLWithString:self.post.image.url] placeholderImage:[FZImage imageWithColor:[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0]]];
    
    int buttonY = image.frame.origin.y + image.frame.size.height + 10;
    
    // Like count format to String
    NSString *likesCountString;
    if(self.post.likes > 9999){
        NSString *likesString = [NSString stringWithFormat:@"%d", self.post.likes];
        likesCountString = [NSString stringWithFormat:@"%@k", [likesString substringToIndex:likesString.length-3]];
    }
    else{
        likesCountString = [NSString stringWithFormat:@"%d", self.post.likes];
    }
    
    // Button Likes
    UIButton *buttonLike = [[UIButton alloc] initWithFrame:CGRectMake(10, buttonY, 80, 40)];
    [buttonLike setBackgroundColor:[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0]];
    [buttonLike addTarget:self action:@selector(actionLike) forControlEvents:UIControlEventTouchUpInside];
    
    // Button Likes icon
    UIImageView *likeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(7, 11, 21, 19)];
    [likeIcon setImage:[UIImage imageNamed:@"like-darkgrey.png"]];
    [buttonLike addSubview:likeIcon];
    
    // Button Likes text
    UILabel *likeText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    [likeText setText:likesCountString];
    [likeText setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [likeText setTextColor:[UIColor colorWithRed:112.0/255.0 green:111.0/255.0 blue:111.0/255.0 alpha:1.0]];
    [likeText setTextAlignment:NSTextAlignmentCenter];
    [likeText setBackgroundColor:[UIColor clearColor]];
    [likeText sizeToFit];
    float likeTextWidth = likeText.frame.size.width;
    float likeTextHeight = likeText.frame.size.height;
    float likeTextX = 35+(20 - (likeTextWidth/2));
    float likeTextY = 20-(likeTextHeight/2);
    [likeText setFrame:CGRectMake(likeTextX, likeTextY, likeTextWidth, likeTextHeight)];
    [buttonLike addSubview:likeText];
    
    
    // Button Tweet
    UIButton *buttonTweet = [[UIButton alloc] initWithFrame:CGRectMake(100, buttonY, 100, 40)];
    [buttonTweet setBackgroundColor:[UIColor colorWithRed:64.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0]];
    [buttonTweet addTarget:self action:@selector(actionTweet) forControlEvents:UIControlEventTouchUpInside];
    
    // Button Tweet icon
    UIImageView *buttonTweetIcon = [[UIImageView alloc] initWithFrame:CGRectMake(6, 10, 23, 19)];
    [buttonTweetIcon setImage:[UIImage imageNamed:@"twitter.png"]];
    [buttonTweet addSubview:buttonTweetIcon];
    
    // Button Tweet text
    UILabel *textTweet = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    [textTweet setText:@"Tweet"];
    [textTweet setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [textTweet setTextColor:[UIColor whiteColor]];
    [textTweet setTextAlignment:NSTextAlignmentCenter];
    [textTweet setBackgroundColor:[UIColor clearColor]];
    [textTweet sizeToFit];
    float textTweetWidth = textTweet.frame.size.width;
    float textTweetHeight = textTweet.frame.size.height;
    float textTweetX = 35+(32 - (textTweetWidth/2));
    float textTweetY = 20-(textTweetHeight/2);
    [textTweet setFrame:CGRectMake(textTweetX, textTweetY, textTweetWidth, textTweetHeight)];
    [buttonTweet addSubview:textTweet];
    
    
    // Button Share
    UIButton *buttonShare = [[UIButton alloc] initWithFrame:CGRectMake(210, buttonY, 100, 40)];
    [buttonShare setBackgroundColor:[UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0]];
    [buttonShare addTarget:self action:@selector(actionShare) forControlEvents:UIControlEventTouchUpInside];
    
    // Button Share icon
    UIImageView *buttonShareIcon = [[UIImageView alloc] initWithFrame:CGRectMake(13, 11, 10, 18)];
    [buttonShareIcon setImage:[UIImage imageNamed:@"facebook.png"]];
    [buttonShare addSubview:buttonShareIcon];
    
    // Button Share text
    UILabel *textShare = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    [textShare setText:@"Share"];
    [textShare setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [textShare setTextColor:[UIColor whiteColor]];
    [textShare setTextAlignment:NSTextAlignmentCenter];
    [textShare setBackgroundColor:[UIColor clearColor]];
    [textShare sizeToFit];
    float textShareWidth = textShare.frame.size.width;
    float textShareHeight = textShare.frame.size.height;
    float textShareX = 35+(32 - (textShareWidth/2));
    float textShareY = 20-(textShareHeight/2);
    [textShare setFrame:CGRectMake(textShareX, textShareY, textShareWidth, textShareHeight)];
    [buttonShare addSubview:textShare];
    
    [self.scrollView addSubview:buttonLike];
    [self.scrollView addSubview:buttonShare];
    [self.scrollView addSubview:buttonTweet];
    [self.scrollView addSubview:image];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)actionLike{
    NSLog(@"Like");
}

- (void)actionTweet{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:[NSString stringWithFormat:@"Nice photo %@ (via @plougy)", self.post.shortURL]];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}


- (void)actionShare{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *shareSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeFacebook];
        [shareSheet setInitialText:[NSString stringWithFormat:@"Nice photo %@", self.post.shortURL]];
        [self presentViewController:shareSheet animated:YES completion:nil];
    }
}

@end
