//
//  NSDate+XKDate.m
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/27.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "NSDate+XKDate.h"

@implementation NSDate (XKDate)

+ (NSDictionary *)getDayDicAfterDays:(int)days fromDate:(NSDate *)date {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSArray *monthArray = @[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"];
    
    NSArray *weekdayArray = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    
    NSDateComponents *addingDateComponents = [[NSDateComponents alloc] init];
    
    [addingDateComponents setDay:days];
    
    date = [calendar dateByAddingComponents:addingDateComponents toDate:date options:0];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:date];
    
    NSDictionary *dicDay = @{MYDIARYYEAR:[NSString stringWithFormat:@"%ld年", (long)components.year],
                             MYDIARYMONTH:monthArray[components.month - 1],
                             MYDIARYDAY:[NSString stringWithFormat:@"%ld", (long)components.day],
                             MYDIARYWEEK:weekdayArray[components.weekday - 1],
                             MYDIARYDATE:date};
    
    return dicDay;
}

+ (NSDate *)getTodayDate {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *addingDateComponents = [[NSDateComponents alloc] init];
    
    [addingDateComponents setDay:0];
    
    NSDate *date = [calendar dateByAddingComponents:addingDateComponents toDate:[NSDate date] options:0];
    
    return date;
}

+ (NSString *)getTimeFromDate:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"HH:mm"];
    
    NSString *strDate = [dateFormatter stringFromDate:date];
    
    return strDate;
}

+ (NSDate *)dateFromString:(NSString *)string {
    
    NSString *dateString = string;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date=[formatter dateFromString:dateString];
    
    return date;
}

+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
        
        return 1;
        
    } else if (result == NSOrderedAscending){
        
        return -1;
    }
    
    return 0;
    
}

@end
