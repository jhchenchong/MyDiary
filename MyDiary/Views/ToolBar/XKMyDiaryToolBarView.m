//
//  XKMyDiaryToolBarView.m
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/29.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "XKMyDiaryToolBarView.h"

@interface XKMyDiaryToolBarView ()

@property (nonatomic, strong) UIButton *emotionButton;

@property (nonatomic, strong) UIButton *weatherButton;

@property (nonatomic, strong) UIButton *saveButton;

@end

@implementation XKMyDiaryToolBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = MyDiaryThemeBlueColor;
        
        self.weatherString = @"sunny_highlight";
        
        self.emotionString = @"happy_highlight";
        
        [self initUserInterface];
    }
    return self;
}

- (void)initUserInterface {
    
    [self addSubview:self.emotionButton];
    
    [self addSubview:self.weatherButton];
    
    [self addSubview:self.saveButton];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    
    [self.emotionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(20);
        
        make.width.offset(25);
        
        make.height.offset(25);
        
        make.centerY.equalTo(self.mas_centerY).offset(0);
        
    }];
    
    [self.weatherButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.emotionButton.mas_right).offset(20);
        
        make.width.offset(25);
        
        make.height.offset(25);
        
        make.centerY.equalTo(self.mas_centerY).offset(0);
        
    }];
    
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-20);
        
        make.width.offset(30);
        
        make.height.offset(30);
        
        make.centerY.equalTo(self.mas_centerY).offset(0);
        
    }];
    
    [super updateConstraints];
}

- (UIButton *)configButtonWithImageName:(NSString *)imageName {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(handleButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

#pragma mark -- 事件处理

- (void)handleButtonEvent:(UIButton *)sender {
    
    NSInteger tag = sender.tag;
    
    MyDiaryToolBarButtonType type = 0;
    
    switch (tag) {
            
        case 500:
            
            type = MyDiaryToolBarEmotionButton;
            
            break;
            
        case 501:
            
            type = MyDiaryToolBarWeatherButton;
            
            break;
            
        case 502:
            
            type = MyDiaryToolBarSaveButton;
            
            break;
            
        default:
            break;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickButtonOfType:button:)]) {
        
        [self.delegate didClickButtonOfType:type button:sender];
    }
}

#pragma mark -- 懒加载
- (UIButton *)emotionButton {
    
    if (!_emotionButton) {
        
        _emotionButton = [self configButtonWithImageName:@"happy_highlight"];
        
        _emotionButton.tag = 500;
    }
    return _emotionButton;
}

- (UIButton *)weatherButton {
    
    if (!_weatherButton) {
        _weatherButton = [self configButtonWithImageName:@"sunny_highlight"];
        
        _weatherButton.tag = 501;
    }
    return _weatherButton;
}

- (UIButton *)saveButton {
    
    if (!_saveButton) {
        _saveButton = [self configButtonWithImageName:@"save"];
        
        _saveButton.tag = 502;
    }
    return _saveButton;
}

- (void)setEmotionString:(NSString *)emotionString {
    
    _emotionString = emotionString;
    
    [_emotionButton setBackgroundImage:[UIImage imageNamed:emotionString] forState:UIControlStateNormal];
}

- (void)setWeatherString:(NSString *)weatherString {
    
    _weatherString = weatherString;
    
    [_weatherButton setBackgroundImage:[UIImage imageNamed:weatherString] forState:UIControlStateNormal];
}

@end
