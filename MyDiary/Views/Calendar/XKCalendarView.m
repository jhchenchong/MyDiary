//
//  XKCalendarView.m
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/26.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "XKCalendarView.h"
#import "XKCalendarViewCell.h"

static NSString *identifier = @"cellID";

@interface XKCalendarView ()<UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *monthArray;

@property (nonatomic, strong) NSArray *weekdayArray;

@property (nonatomic, strong) NSDictionary *dayDict;

@end

@implementation XKCalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUserInterface];
    }
    return self;
}

- (void)initUserInterface {
    
    [self addSubview:self.collectionView];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(0);
        
        make.right.equalTo(self).offset(0);
        
        make.top.equalTo(self).offset(0);
        
        make.bottom.equalTo(self).offset(0);
        
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        
    });
    
    [super updateConstraints];
}

#pragma mark -- delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 3;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XKCalendarViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.dateDict = self.dayDict;
    
    return cell;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    CGPoint translation = [self.collectionView.panGestureRecognizer translationInView:self.collectionView];
    
    if (translation.x > self.collectionView.bounds.size.width / 2 || translation.x < - self.collectionView.bounds.size.width / 2) {
        
        if (translation.x > self.collectionView.bounds.size.width / 2) {
            
            self.dayDict = [NSDate getDayDicAfterDays:-1 fromDate:self.dayDict[MYDIARYDATE]];
            
        } else {
            
            self.dayDict = [NSDate getDayDicAfterDays:1 fromDate:self.dayDict[MYDIARYDATE]];
        }
        
        [self.collectionView reloadData];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarViewscrollToFrontOrLater:)]) {
        
        [self.delegate calendarViewscrollToFrontOrLater:self.dayDict];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger offset = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    if (offset == 0 || offset == 2) {
        
        if (offset == 0) {
            
            offset = 2;
            
        } else {
            
            offset = 1;
        }
        scrollView.contentOffset = CGPointMake(offset * scrollView.bounds.size.width, 0);
    }
}

- (void)calenderOfToday {
    
    self.dayDict = nil;
    
    [self.collectionView reloadData];
}


- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        AnimatedCollectionViewLayout *layout = [[AnimatedCollectionViewLayout alloc] initWithAnimationType:NSClassFromString(@"RotateInOutAttributesAnimator")];
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        layout.minimumLineSpacing = 0;
        
        layout.minimumInteritemSpacing = 0;
        
        layout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        _collectionView.dataSource = self;
        
        _collectionView.delegate = self;
        
        _collectionView.pagingEnabled = YES;
        
        _collectionView.showsVerticalScrollIndicator = NO;
        
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:[XKCalendarViewCell class] forCellWithReuseIdentifier:identifier];
        
    }
    return _collectionView;
}

- (NSArray *)monthArray {
    
    if (!_monthArray) {
        _monthArray = @[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"];
    }
    return _monthArray;
}

- (NSArray *)weekdayArray {
    
    if (!_weekdayArray) {
        _weekdayArray = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    }
    return _weekdayArray;
}

- (NSDictionary *)dayDict {
    
    if (!_dayDict) {
        
        _dayDict = @{}.mutableCopy;
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSArray *monthArray = self.monthArray;
        
        NSArray *weekdayArray = self.weekdayArray;
        
        NSDateComponents *addingDateComponents = [[NSDateComponents alloc] init];
        
        [addingDateComponents setDay:0];
        
        NSDate *date = [calendar dateByAddingComponents:addingDateComponents toDate:[NSDate date] options:0];
        
        NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:date];
        
        _dayDict = @{MYDIARYYEAR:[NSString stringWithFormat:@"%ld年", (long)components.year],
                     MYDIARYMONTH:monthArray[components.month - 1],
                     MYDIARYDAY:[NSString stringWithFormat:@"%ld", (long)components.day],
                     MYDIARYWEEK:weekdayArray[components.weekday - 1],
                     MYDIARYDATE:date};
    }
    return _dayDict;
}

@end
