//
//  XKMyDiaryHelper.m
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/26.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "XKMyDiaryHelper.h"
#import <AVFoundation/AVFoundation.h>

NSString * const kCurrentVersionKey = @"CurrentVersion";

@interface XKMyDiaryHelper ()

@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation XKMyDiaryHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)playBGMIfFirstOpen {
    
    if (![self isNewVersion]) {
        
        return;
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BGM" ofType:@"mp3"];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    self.player.numberOfLoops = 1;
    
    if ([self.player prepareToPlay]) {
        
        [self.player play];
    }
}

- (BOOL)isNewVersion {
    
    NSString *newVersion =  [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    NSString *currentVersion = [[NSUserDefaults standardUserDefaults] stringForKey:kCurrentVersionKey];
    [[NSUserDefaults standardUserDefaults] setObject:newVersion forKey:kCurrentVersionKey];
    
    return newVersion > currentVersion;
}

@end
