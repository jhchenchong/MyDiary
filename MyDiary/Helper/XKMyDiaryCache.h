//
//  XKMyDiaryCache.h
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/29.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKMyDiaryCache : UIView

+ (void)setDiaryCacheWithdate:(NSString *)dateString diaryData:(id)data;

+ (id)getDataWithDateString:(NSString *)dateString;

@end
