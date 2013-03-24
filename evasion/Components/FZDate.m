//
//  FZDate.m
//  evasion
//
//  Created by Aymeric on 24/03/13.
//  Copyright (c) 2013 Fuzzze. All rights reserved.
//

#import "FZDate.h"

@implementation FZDate

+ (NSString*)timeSinceAtToday:(int)date{
    
    int dateNow = [[NSDate date] timeIntervalSince1970];
    
    int time = dateNow - date;
    
    
    if(time < 60){
        return [self timeToSecond:time];
    }
    else if(time < 3600){
        return [self timeToMinute:time];
    }
    else if(time < 86400){
        return [self timeToHour:time];
    }
    else if(time < 604800){
        return [self timeToDay:time];
    }
    else if(time < 2419200){
        return [self timeToWeek:time];
    }
    else if(time < 31536000){
        return [self timeToMonth:time];
    }
    else{
        return [self timeToYear:time];
    }
    
    return nil;
}


+ (NSString*)timeToSecond:(int)time{
    
    NSString *string = [[NSString alloc] init];
    
    if(time == 1 || time == 0){
        string = [NSString stringWithFormat:@"1 second"];
    }
    else{
        string = [NSString stringWithFormat:@"%d seconds", time];
    }
    
    return string;
}


+ (NSString*)timeToMinute:(int)time{
    
    NSString *string = [[NSString alloc] init];
    
    time = (int)(floor(time/60));
    
    if(time == 1){
        string = [NSString stringWithFormat:@"1 minute"];
    }
    else{
        string = [NSString stringWithFormat:@"%d minutes", time];
    }
    
    return string;
}


+ (NSString*)timeToHour:(int)time{
    
    NSString *string = [[NSString alloc] init];
    
    time = (int)(floor(time/(60*60)));
    
    if(time == 1){
        string = [NSString stringWithFormat:@"1 hour"];
    }
    else{
        string = [NSString stringWithFormat:@"%d hours", time];
    }
    
    return string;
}


+ (NSString*)timeToDay:(int)time{
    
    NSString *string = [[NSString alloc] init];
    
    time = (int)(floor(time/(60*60*24)));
    
    if(time == 1){
        string = [NSString stringWithFormat:@"1 day"];
    }
    else{
        string = [NSString stringWithFormat:@"%d days", time];
    }
    
    return string;
}


+ (NSString*)timeToWeek:(int)time{
    
    NSString *string = [[NSString alloc] init];
    
    time = (int)(floor(time/(60*60*24*7)));
    
    if(time == 1){
        string = [NSString stringWithFormat:@"1 week"];
    }
    else{
        string = [NSString stringWithFormat:@"%d weeks", time];
    }
    
    return string;
}


+ (NSString*)timeToMonth:(int)time{
    
    NSString *string = [[NSString alloc] init];
    
    time = (int)(floor(time/(60*60*24*7*4)));
    
    if(time == 1){
        string = [NSString stringWithFormat:@"1 month"];
    }
    else{
        string = [NSString stringWithFormat:@"%d months", time];
    }
    
    return string;
}


+ (NSString*)timeToYear:(int)time{
    
    NSString *string = [[NSString alloc] init];
    
    time = (int)(floor(time/(60*60*24*365)));
    
    if(time == 1){
        string = [NSString stringWithFormat:@"1 year"];
    }
    else{
        string = [NSString stringWithFormat:@"%d years", time];
    }
    
    return string;
}

@end
