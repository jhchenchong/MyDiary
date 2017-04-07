//
//  XKMyDiaryDetailCell.m
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/4/6.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "XKMyDiaryDetailCell.h"

@interface XKMyDiaryDetailCell ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UILabel *monthLabel;

@property (nonatomic, strong) UILabel *dayLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIButton *quitButton;

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, copy) NSString *htmlstring;

@end

@implementation XKMyDiaryDetailCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self initUserInterface];
    }
    return self;
}

- (void)initUserInterface {
    
    [self.contentView addSubview:self.monthLabel];
    
    [self.contentView addSubview:self.dayLabel];
    
    [self.contentView addSubview:self.timeLabel];
    
    [self.contentView addSubview:self.quitButton];
    
    [self.contentView addSubview:self.webView];
    
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints {
    
    [self.quitButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(- 25 * PROPORTION);
        
        make.top.equalTo(self.contentView).offset(35 * PROPORTION);
        
        make.width.offset(24 * PROPORTION);
        
        make.height.offset(24 * PROPORTION);
    }];
    
    [self.monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.contentView).offset(0);
        
        make.top.equalTo(self.contentView).offset(35 * PROPORTION);
    }];
    
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.contentView).offset(0);
        
        make.top.equalTo(self.monthLabel.mas_bottom).offset(0 * PROPORTION);
        
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.contentView).offset(0);
        
        make.top.equalTo(self.dayLabel.mas_bottom).offset(0 * PROPORTION);
        
    }];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        
        make.right.equalTo(self.contentView).offset(-10);
        
        make.top.equalTo(self.timeLabel.mas_bottom).offset(25 * PROPORTION);
        
        make.bottom.equalTo(self.contentView).offset(0);
        
    }];
    
    [super updateConstraints];
}

- (void)handleQuitButtonEvent {
    
    if (self.block) {
        
        self.block();
    }
}




#pragma mark -- 私有方法

- (void)loadWebHtml {
    
    NSURL *cssURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"News" ofType:@"css"]];
    
    [_webView loadHTMLString:[self handleWithHtmlBody:self.htmlstring] baseURL:cssURL];
}

- (NSString *)handleWithHtmlBody:(NSString *)htmlBody {
    
    NSString *html = [htmlBody stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    NSString *cssName = @"News.css";
    NSMutableString *htmlString =[[NSMutableString alloc]initWithString:@"<html>"];
    [htmlString appendString:@"<head><meta charset=\"UTF-8\">"];
    [htmlString appendString:@"<link rel =\"stylesheet\" href = \""];
    [htmlString appendString:cssName];
    [htmlString appendString:@"\" type=\"text/css\" />"];
    [htmlString appendString:@"</head>"];
    [htmlString appendString:@"<body>"];
    [htmlString appendString:html];
    [htmlString appendString:@"</body>"];
    [htmlString appendString:@"</html>"];
    
    return htmlString;
}


#pragma mark -- setter 

- (void)setModel:(XKDiaryModel *)model {
    
    _model = model;
    
    self.monthLabel.text = [NSString stringWithFormat:@"%@, %@", model.year, model.month];
    
    self.dayLabel.text = model.day;
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@ %@",model.week, [NSDate getTimeFromDate:model.date]];
    
    [self.monthLabel sizeToFit];
    
    [self.dayLabel sizeToFit];
    
    [self.timeLabel sizeToFit];
    
    self.htmlstring = model.detail;
}

- (void)setHtmlstring:(NSString *)htmlstring {
    
    if (htmlstring == nil) {
        
        return;
    }
    
    _htmlstring = htmlstring;
    
    [self loadWebHtml];
}
#pragma mark -- 懒加载

- (UILabel *)monthLabel {
    
    if (!_monthLabel) {
        
        _monthLabel = [UILabel configLabelWithFont:@"STHeitiSC-Medium" fontSize:20 textAlignment:NSTextAlignmentCenter];
        
        _monthLabel.textColor = MyDiaryThemeBlueColor;
        
        _monthLabel.text = @"2017年，4月";
        
        [_monthLabel sizeToFit];
    }
    return _monthLabel;
}

- (UILabel *)dayLabel {
    
    if (!_dayLabel) {
        
        _dayLabel = [UILabel configLabelWithFont:@"STHeitiTC-Light" fontSize:40 textAlignment:NSTextAlignmentCenter];
        
        _dayLabel.textColor = MyDiaryThemeBlueColor;
        
        _dayLabel.text = @"6";
        
        [_dayLabel sizeToFit];
    
    }
    return _dayLabel;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = [UILabel configLabelWithFont:@"STHeitiTC-Light" fontSize:20 textAlignment:NSTextAlignmentCenter];
        
        _timeLabel.textColor = MyDiaryThemeBlueColor;
        
        _timeLabel.text = @"星期四 17:39";
        
        [_timeLabel sizeToFit];
    }
    return _timeLabel;
}

- (UIButton *)quitButton {
    
    if (!_quitButton) {
        
        _quitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_quitButton setImage:[UIImage imageNamed:@"quit"] forState:UIControlStateNormal];
        
        [_quitButton addTarget:self action:@selector(handleQuitButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _quitButton;
}

- (UIWebView *)webView {
    
    if (!_webView) {
        
        _webView = [[UIWebView alloc] init];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _webView.dataDetectorTypes = UIDataDetectorTypeNone;
        _webView.backgroundColor = [UIColor clearColor];
        _webView.opaque = NO;
        _webView.keyboardDisplayRequiresUserAction = NO;
        _webView.scrollView.bounces = YES;
        _webView.allowsInlineMediaPlayback = YES;
    }
    return _webView;
}

@end
