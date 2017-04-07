//
//  XKMyDiaryTypingCalendarView.h
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/28.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XKMyDiaryTypingCalendarViewDelegate <NSObject>

- (void)leftButtonPressed;

- (void)rightButtonPressed;

@end

@interface XKMyDiaryTypingCalendarView : UIView

@property (nonatomic, strong) NSDictionary *dicDate;

@property (nonatomic, weak) id<XKMyDiaryTypingCalendarViewDelegate> delegate;

- (void)transformToSmallMood;
- (void)transformToNormalMood;

@end
