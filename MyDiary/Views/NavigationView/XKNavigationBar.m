//
//  XKNavigationBar.m
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/25.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "XKNavigationBar.h"

@interface XKNavigationBar ()

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) UILabel *label;

@end


@implementation XKNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUserInterface];
    }
    return self;
}

- (void)initUserInterface {
    
    [self setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    [self setShadowImage:[[UIImage alloc] init]];
    
    [self addSubview:self.segmentedControl];
    
    [self addSubview:self.label];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self).offset(40 * PROPORTION);
        
        make.left.equalTo(self).offset(50 * PROPORTION);
        
        make.right.equalTo(self).offset(- 50 * PROPORTION);
        
        make.bottom.equalTo(self).offset(- 44 * PROPORTION);
        
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.segmentedControl.mas_bottom).offset(10 * PROPORTION);
        
        make.left.equalTo(self).offset(10 * PROPORTION);
        
        make.right.equalTo(self).offset(- 10 * PROPORTION);
        
        make.bottom.equalTo(self).offset(- 10 * PROPORTION);
    }];
    
    [super updateConstraints];
}

- (void)changeValueOfSegmentControl:(UISegmentedControl *)segmentedControl {
    
    if (self.xkDelegate && [self.xkDelegate respondsToSelector:@selector(didChangeValueOfSegmentControl:)]) {
        [self.xkDelegate didChangeValueOfSegmentControl:segmentedControl];
    }
}

- (UISegmentedControl *)segmentedControl {
    
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"浏览", @"日历", @"撰写"]];
        _segmentedControl.tintColor = MyDiaryThemeBlueColor;
        [_segmentedControl addTarget:self action:@selector(changeValueOfSegmentControl:) forControlEvents:UIControlEventValueChanged];
        _segmentedControl.selectedSegmentIndex = 0;
    }
    return _segmentedControl;
}

- (UILabel *)label {
    
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:20];
        _label.text = @"日记";
        _label.textColor = MyDiaryThemeBlueColor;
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (void)setIsHiddenLabel:(BOOL)isHiddenLabel {
    
    self.label.hidden = isHiddenLabel;
}

@end
