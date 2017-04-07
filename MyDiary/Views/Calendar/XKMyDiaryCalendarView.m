//
//  XKMyDiaryCalendarView.m
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/25.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "XKMyDiaryCalendarView.h"
#import "XKTableViewCell.h"


static NSString *identifier = @"cellID";

@interface XKMyDiaryCalendarView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation XKMyDiaryCalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self initUserInterface];
    }
    return self;
}

- (void)initUserInterface {
    
    [self addSubview:self.calendarView];
    
    [self addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(0);
        
        make.right.equalTo(self).offset(0);
        
        make.top.equalTo(self.calendarView.mas_bottom).offset(10);
        
        make.height.offset(MyDiaryCellHeight);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.model) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.model = self.model;
    
    cell.tag = indexPath.row;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.block) {
        
        self.block(tableView, indexPath);
    }
}

- (XKCalendarView *)calendarView {
    
    if (!_calendarView) {
        
        _calendarView = [[XKCalendarView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - MyDiaryCellHeight)];
        
    }
    return _calendarView;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, MyDiaryCellHeight) style:UITableViewStylePlain];
        
        _tableView.dataSource = self;
        
        _tableView.delegate = self;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.rowHeight = MyDiaryCellHeight;
        
        _tableView.backgroundColor = [UIColor clearColor];
        
        [_tableView registerClass:[XKTableViewCell class] forCellReuseIdentifier:identifier];
    }
    return _tableView;
}

- (void)setModel:(XKDiaryModel *)model {
    
    _model = model;
    
    [self.tableView reloadData];
}

@end
