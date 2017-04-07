//
//  XKMyDiaryCache.m
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/29.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "XKMyDiaryCache.h"

static NSString *const XKMyDiaryCacheName = @"XKMyDiaryCacheName";

static YYCache *_dataCache;

@implementation XKMyDiaryCache

+ (void)initialize {
    
    _dataCache = [YYCache cacheWithName:XKMyDiaryCacheName];
}

+ (void)setDiaryCacheWithdate:(NSString *)dateString diaryData:(id)data {
    
    [_dataCache setObject:data forKey:dateString];
}

+ (id)getDataWithDateString:(NSString *)dateString {
    
    return [_dataCache objectForKey:dateString];
}

@end
