//
//  XKMyDiaryTypingCalendarView.m
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/28.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "XKMyDiaryTypingCalendarView.h"

@interface XKMyDiaryTypingCalendarView ()

@property (nonatomic, strong) UILabel *monthLabel;

@property (nonatomic, strong) UILabel *dayLabel;

@property (nonatomic, strong) UILabel *weekLabel;

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UILabel *smallLabel;

@end

@implementation XKMyDiaryTypingCalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUserInterface];
    }
    return self;
}

- (void)initUserInterface {
    
    [self addSubview:self.monthLabel];
    
    [self addSubview:self.weekLabel];
    
    [self addSubview:self.dayLabel];
    
    [self addSubview:self.leftButton];
    
    [self addSubview:self.rightButton];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(5);
        
        make.width.offset(20);
        
        make.height.offset(20);
        
        make.centerY.equalTo(self.mas_centerY).offset(0);
        
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(- 5);
        
        make.width.offset(20);
        
        make.height.offset(20);
        
        make.centerY.equalTo(self.mas_centerY).offset(0);
        
    }];
    
    [self.monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self).offset(10 * PROPORTION);
        
        make.height.offset(25 * PROPORTION);
        
        make.width.offset(200 * PROPORTION);
        
        make.centerX.equalTo(self.mas_centerX).offset(0);
    }];
    
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.monthLabel.mas_bottom).offset(15 * PROPORTION);
        
        make.height.offset(40 * PROPORTION);
        
        make.width.offset(200 * PROPORTION);
        
        make.centerX.equalTo(self.mas_centerX).offset(0);
    }];
    
    [self.weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.dayLabel.mas_bottom).offset(15 * PROPORTION);
        
        make.height.offset(25 * PROPORTION);
        
        make.width.offset(200 * PROPORTION);
        
        make.centerX.equalTo(self.mas_centerX).offset(0);
    }];
    
    [super updateConstraints];
}

#pragma mark -- 公开的方法

- (void)transformToSmallMood {
    
    self.backgroundColor = MyDiaryThemeBlueColor;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self addSubview:self.smallLabel];
    
    self.dicDate ? (self.smallLabel.text = [NSString stringWithFormat:@"%@%@日，%@", self.dicDate[MYDIARYMONTH], self.dicDate[MYDIARYDAY], self.dicDate[MYDIARYWEEK]]) : (self.smallLabel.text = [NSString stringWithFormat:@"%@%@日，%@", [NSDate getDayDicAfterDays:0 fromDate:[NSDate getTodayDate]][MYDIARYMONTH], [NSDate getDayDicAfterDays:0 fromDate:[NSDate getTodayDate]][MYDIARYDAY], [NSDate getDayDicAfterDays:0 fromDate:[NSDate getTodayDate]][MYDIARYWEEK]]);
    
    [self.smallLabel sizeToFit];
    
    self.smallLabel.center = self.center;
}

- (void)transformToNormalMood {
    
    self.backgroundColor = [UIColor clearColor];
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self initUserInterface];
}


#pragma mark -- 事件处理

- (void)handleLeftBtnClick {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(leftButtonPressed)]) {
        
        [self.delegate leftButtonPressed];
    }
}

- (void)handleRightBtnClick {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(rightButtonPressed)]) {
        
        [self.delegate rightButtonPressed];
    }
}

#pragma mark -- 懒加载
- (UILabel *)monthLabel {
    
    if (!_monthLabel) {
        
        _monthLabel = [UILabel configLabelWithFont:@"STHeitiSC-Medium" fontSize:20 textAlignment:NSTextAlignmentCenter];
        _monthLabel.textColor = [UIColor whiteColor];
    }
    return _monthLabel;
}

- (UILabel *)dayLabel {
    
    if (!_dayLabel) {
        
        _dayLabel = [UILabel configLabelWithFont:@"STHeitiTC-Light" fontSize:40 textAlignment:NSTextAlignmentCenter];
        _dayLabel.textColor = [UIColor whiteColor];
    }
    return _dayLabel;
}

- (UILabel *)weekLabel {
    
    if (!_weekLabel) {
        
        _weekLabel = [UILabel configLabelWithFont:@"STHeitiTC-Light" fontSize:20 textAlignment:NSTextAlignmentCenter];
        _weekLabel.textColor = [UIColor whiteColor];
    }
    return _weekLabel;
}

- (UILabel *)smallLabel {
    
    if (!_smallLabel) {
        _smallLabel = [UILabel configLabelWithFont:@"STHeitiSC-Light" fontSize:15 textAlignment:NSTextAlignmentCenter];
        _smallLabel.textColor = [UIColor whiteColor];
    }
    
    return _smallLabel;
}

- (UIButton *)leftButton {
    
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(handleLeftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(handleRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}


- (void)setDicDate:(NSDictionary *)dicDate {
    
    if (!dicDate) {
        
        return;
    }
    
    _dicDate = dicDate;
    
    self.monthLabel.text = dicDate[MYDIARYMONTH];
    
    self.dayLabel.text = dicDate[MYDIARYDAY];
    
    self.weekLabel.text = dicDate[MYDIARYWEEK];
}

@end
