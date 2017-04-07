//
//  XKDiaryModel.h
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/25.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKDiaryModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *detail;

@property (nonatomic, copy) NSString *day;

@property (nonatomic, copy) NSString *week;

@property (nonatomic, copy) NSString *year;

@property (nonatomic, copy) NSString *month;

@property (nonatomic, copy) NSDate *date;

@property (nonatomic, copy) NSString *weather;

@property (nonatomic, copy) NSString *emotion;


//date = "2017-03-29 13:15:53 +0000";
//day = 29;
//detail = E;
//emotion = "happy_highlight";
//month = "3\U6708";
//title = R;
//weather = "sunny_highlight";
//week = "\U661f\U671f\U4e09";
//year = "2017\U5e74";

@end
