//
//  NSDate+XKDate.h
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/27.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XKDate)

+ (NSDictionary *)getDayDicAfterDays:(int)days fromDate:(NSDate *)date;

+ (NSDate *)getTodayDate;

+ (NSString *)getTimeFromDate:(NSDate *)date;

+ (NSDate *)dateFromString:(NSString *)string;

+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

@end
