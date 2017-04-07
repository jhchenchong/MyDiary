//
//  XKNavigationBar.h
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/25.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XKNavigationBarDelegate <NSObject>

@optional
- (void)didChangeValueOfSegmentControl:(UISegmentedControl *)segment;

@end

@interface XKNavigationBar : UINavigationBar

@property (nonatomic, weak) id <XKNavigationBarDelegate> xkDelegate;

@property (nonatomic, assign) BOOL isHiddenLabel;

@end
