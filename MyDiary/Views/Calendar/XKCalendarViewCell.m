//
//  XKCalendarViewCell.m
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/25.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "XKCalendarViewCell.h"

@interface XKCalendarViewCell ()

@property (nonatomic, strong) UILabel *monthLabel;

@property (nonatomic, strong) UILabel *dayLabel;

@property (nonatomic, strong) UILabel *weekLabel;

@end


@implementation XKCalendarViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUserInterface];
        
    }
    return self;
}

- (void)initUserInterface {
    
    [self.contentView addSubview:self.monthLabel];
    
    [self.contentView addSubview:self.dayLabel];
    
    [self.contentView addSubview:self.weekLabel];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    
    [self.monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(30 * PROPORTION);
        
        make.left.equalTo(self.contentView).offset(30 * PROPORTION);
        
        make.right.equalTo(self.contentView).offset(- 30 * PROPORTION);
        
        make.height.offset(50);
        
    }];
    
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.monthLabel.mas_bottom).offset(40 * PROPORTION);
        
        make.left.equalTo(self.contentView).offset(30 * PROPORTION);
        
        make.right.equalTo(self.contentView).offset(- 30 * PROPORTION);
        
        make.height.offset(115 * PROPORTION);
        
    }];
    
    [self.weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.dayLabel.mas_bottom).offset(40 * PROPORTION);
        
        make.left.equalTo(self.contentView).offset(30 * PROPORTION);
        
        make.right.equalTo(self.contentView).offset(- 30 * PROPORTION);
        
        make.height.offset(50 * PROPORTION);
        
    }];
    
    [super updateConstraints];
}

- (void)setDateDict:(NSDictionary *)dateDict {
    
    _dateDict = dateDict;
    
    self.monthLabel.text = _dateDict[MYDIARYMONTH];
    
    self.dayLabel.text = _dateDict[MYDIARYDAY];
    
    self.weekLabel.text = _dateDict[MYDIARYWEEK];
}

#pragma maek -- getter
- (UILabel *)monthLabel {
    
    if (!_monthLabel) {
        _monthLabel = [UILabel configLabelWithFont:@"STHeitiSC-Medium" fontSize:30 * PROPORTION textAlignment:NSTextAlignmentCenter];
    }
    return _monthLabel;
}

- (UILabel *)dayLabel {
    
    if (!_dayLabel) {
        _dayLabel = [UILabel configLabelWithFont:@"STHeitiTC-Light" fontSize:100 * PROPORTION textAlignment:NSTextAlignmentCenter];
    }
    return _dayLabel;
}

- (UILabel *)weekLabel {
    
    if (!_weekLabel) {
        _weekLabel = [UILabel configLabelWithFont:@"STHeitiSC-Light" fontSize:28 * PROPORTION textAlignment:NSTextAlignmentCenter];
    }
    return _weekLabel;
}

@end
