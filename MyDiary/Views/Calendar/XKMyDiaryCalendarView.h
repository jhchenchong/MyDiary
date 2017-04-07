//
//  XKMyDiaryCalendarView.h
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/25.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKCalendarView.h"
#import "XKDiaryModel.h"


typedef void(^DidClickCellBlock)(UITableView *tableView, NSIndexPath *indexPath);

@interface XKMyDiaryCalendarView : UIView

@property (nonatomic, strong) XKCalendarView *calendarView;

@property (nonatomic, strong) XKDiaryModel *model;

@property (nonatomic, copy) DidClickCellBlock block;

@end
