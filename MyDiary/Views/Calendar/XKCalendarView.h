//
//  XKCalendarView.h
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/26.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol XKCalendarViewDelegate <NSObject>

@optional

// 获取日历是翻往前一天还是后一天

- (void)calendarViewscrollToFrontOrLater:(NSDictionary *)dayDict;

@end

@interface XKCalendarView : UIView

@property (nonatomic, weak) id <XKCalendarViewDelegate> delegate;

- (void)calenderOfToday;

@end
