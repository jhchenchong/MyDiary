//
//  XKTableViewCell.m
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/25.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "XKTableViewCell.h"

@interface XKTableViewCell ()

@property (nonatomic, strong) UILabel *dayLabel;

@property (nonatomic, strong) UILabel *weekLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UIImageView *weatherImageView;

@property (nonatomic, strong) UIImageView *emotionImageView;

@property (nonatomic, strong) UIView *view;

@end

@implementation XKTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor clearColor];
        
        [self initUserInterface];
        
    }
    return self;
}

- (void)initUserInterface {
    
    [self.view addSubview:self.dayLabel];
    
    [self.view addSubview:self.weekLabel];
    
    [self.view addSubview:self.timeLabel];
    
    [self.view addSubview:self.titleLabel];
    
    [self.view addSubview:self.detailLabel];
    
    [self.view addSubview:self.weatherImageView];
    
    [self.view addSubview:self.emotionImageView];
    
    [self.contentView addSubview:self.view];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(8 * PROPORTION);
        
        make.right.equalTo(self.contentView).offset(-8 * PROPORTION);
        
        make.top.equalTo(self.contentView).offset(10 * PROPORTION);
        
        make.bottom.equalTo(self.contentView).offset(0);
        
    }];
    
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(10 * PROPORTION);
        
        make.top.equalTo(self.view).offset(15 * PROPORTION);
        
        make.width.offset(30 * PROPORTION);
        
        make.height.offset(30 * PROPORTION);
        
    }];
    
    [self.weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(10 * PROPORTION);
        
        make.top.equalTo(self.dayLabel.mas_bottom).offset(8 * PROPORTION);
        
        make.height.offset(10 * PROPORTION);
        
        make.width.offset(33 * PROPORTION);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.dayLabel.mas_right).offset(8 * PROPORTION);
        
        make.top.equalTo(self.view).offset(12 * PROPORTION);
        
        make.height.offset(10 * PROPORTION);
        
        make.width.offset(100 * PROPORTION);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.timeLabel);
        
        make.top.equalTo(self.timeLabel.mas_bottom).offset(10 * PROPORTION);
        
        make.height.offset(12 * PROPORTION);
        
        make.width.offset(100 * PROPORTION);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.timeLabel);
        
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10 * PROPORTION);
        
        make.height.offset(10 * PROPORTION);
        
        make.width.offset(150 * PROPORTION);
    }];
    
    [self.weatherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.timeLabel);
        
        make.right.equalTo(self.view).offset(- 40 * PROPORTION);
        
        make.height.offset(20 * PROPORTION);
        
        make.width.offset(20 * PROPORTION);
    }];
    
    [self.emotionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.timeLabel);
        
        make.right.equalTo(self.view).offset(- 10 * PROPORTION);
        
        make.height.offset(20 * PROPORTION);
        
        make.width.offset(20 * PROPORTION);
    }];
    
    [super updateConstraints];
}


- (void)setModel:(XKDiaryModel *)model {
    
    _model = model;
    
    self.dayLabel.text = model.day;
    
    self.weekLabel.text = model.week;
    
    self.titleLabel.text = model.title;
    
    self.detailLabel.text = [[self filterHTML:model.detail] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    self.emotionImageView.image = [UIImage imageNamed:model.emotion];
    
    self.weatherImageView.image = [UIImage imageNamed:model.weather];
    
    self.timeLabel.text = [NSDate getTimeFromDate:model.date];
}


- (NSString *)filterHTML:(NSString *)str {
    
    NSScanner * scanner = [NSScanner scannerWithString:str];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        str  =  [str  stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    
    return str;
}

#pragma mark -- getter
- (UILabel *)dayLabel {
    
    if (!_dayLabel) {
        _dayLabel = [UILabel configLabelWithFont:@"STHeitiSC-Medium" fontSize:23 * PROPORTION textAlignment:NSTextAlignmentCenter];
    }
    return _dayLabel;
}

- (UILabel *)weekLabel {
    
    if (!_weekLabel) {
        _weekLabel = [UILabel configLabelWithFont:@"CourierNewPSMT" fontSize:10 * PROPORTION textAlignment:NSTextAlignmentCenter];
        _weekLabel.text = @"星期六";
    }
    return _weekLabel;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        _timeLabel = [UILabel configLabelWithFont:@"STHeitiSC-Light" fontSize:10 * PROPORTION textAlignment:NSTextAlignmentLeft];
        _timeLabel.text = @"16:37";
    }
    return _timeLabel;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [UILabel configLabelWithFont:@"STHeitiSC-Medium" fontSize:14 * PROPORTION textAlignment:NSTextAlignmentLeft];
        _titleLabel.text = @"浪漫恋星空";
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    
    if (!_detailLabel) {
        _detailLabel = [UILabel configLabelWithFont:@"STHeitiSC-Light" fontSize:12 * PROPORTION textAlignment:NSTextAlignmentLeft];
        _detailLabel.text = @"测试数据哈哈哈哈哈哈哈哈哈哈哈哈";
    }
    return _detailLabel;
}

- (UIImageView *)weatherImageView {
    
    if (!_weatherImageView) {
        _weatherImageView = [[UIImageView alloc] init];
    }
    return _weatherImageView;
}

- (UIImageView *)emotionImageView {
    
    if (!_emotionImageView) {
        _emotionImageView = [[UIImageView alloc] init];
    }
    return _emotionImageView;
}

- (UIView *)view {
    
    if (!_view) {
        _view = [[UIView alloc] init];
        _view.backgroundColor = [UIColor whiteColor];
        _view.layer.cornerRadius = 5 * PROPORTION;
    }
    return _view;
}

@end
