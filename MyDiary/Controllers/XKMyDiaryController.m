//
//  ViewController.m
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/25.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "XKMyDiaryController.h"
#import "XKMyDiaryHelper.h"
#import "XKNavigationBar.h"
#import "XKAnimatedImagesView.h"
#import "XKTableViewCell.h"
#import "XKMyDiaryCalendarView.h"
#import "XKUINavigationController.h"
#import "XKMyDiaryEditorController.h"
#import "XKMyDiaryTypingCalendarView.h"
#import "XKMyDiaryToolBarView.h"
#import "FTPopOverMenu.h"
#import "XKMyDiaryDetailController.h"
#import "XKMyDiaryTransition.h"
#import "XKMyDiaryHelper.h"

static NSString *identifier = @"cellID";

@interface XKMyDiaryController ()<XKAnimatedImagesViewDelegate, UITableViewDelegate, UITableViewDataSource, XKNavigationBarDelegate, XKMyDiaryTypingCalendarViewDelegate, XKMyDiaryToolBarViewDelegate, XKCalendarViewDelegate>

@property (nonatomic, strong) XKNavigationBar *navigationBar;

@property (nonatomic, strong) XKAnimatedImagesView *animatedImageView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) XKMyDiaryCalendarView *calendarView;

@property (nonatomic, strong) NSArray *bgImages;

@property (nonatomic, strong) XKMyDiaryEditorController *editorController;

@property (nonatomic, strong) XKMyDiaryTypingCalendarView *typingView;

@property (nonatomic, strong) NSDictionary *dataDict;

@property (nonatomic, strong) XKMyDiaryToolBarView *toolBarView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *dayDiary;

@property (nonatomic, strong) XKMyDiaryTransition *transition;

@property (nonatomic, strong) XKMyDiaryHelper *helper;

@end

@implementation XKMyDiaryController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self playBGM];
    
    [self initDataSource];
    
    [self initUserInterface];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)initUserInterface {
    
    [self.view addSubview:self.navigationBar];
    
    [self.view insertSubview:self.animatedImageView belowSubview:self.navigationBar];
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.typingView];
    
    [self.view addSubview:self.toolBarView];
    
    [self setupPopOverMenu];
}

- (void)setupPopOverMenu {
    
    FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
    configuration.textColor = [UIColor whiteColor];
    configuration.tintColor = MyDiaryThemeBlueColor;
    configuration.borderColor = [UIColor whiteColor];
    configuration.borderWidth = 0.1;
}

- (void)playBGM {
    
    self.helper = [[XKMyDiaryHelper alloc] init];
    
    [self.helper playBGMIfFirstOpen];
}


#pragma mark -- 获取缓存数据

- (void)initDataSource {
    
    self.dataSource = @[].mutableCopy;
    
    NSArray *cacheData = [XKMyDiaryCache getDataWithDateString:MYDIARYCACHEKEY];
    
    if (!cacheData) {
        
        [XKMydiaryProgressHUD showImage:@"" message:@"你还没有日记,快去写一篇吧"];
        
        [_tableView.mj_header endRefreshing];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
        });
        
        return;
    }
    
    [cacheData sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        NSDate *date1 = (NSDate *)obj1;
        
        NSDate *date2 = (NSDate *)obj2;
        
        if ([[date1 valueForKey:MYDIARYDATE] compare:[date2 valueForKey:MYDIARYDATE]] == NSOrderedDescending) {
            
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        if ([[date1 valueForKey:MYDIARYDATE] compare:[date2 valueForKey:MYDIARYDATE]] == NSOrderedAscending) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        return (NSComparisonResult)NSOrderedSame;
        
    }];
    
    __block XKDiaryModel *model;
    
    [cacheData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        model = [XKDiaryModel yy_modelWithDictionary:obj];
        
        [self.dataSource addObject:model];
    }];
    
    [self.tableView reloadData];
    
    [_tableView.mj_header endRefreshing];
}


#pragma mark -- delegate

- (NSUInteger)animatedImagesNumberOfImages:(XKAnimatedImagesView *)animatedImagesView {
    
    return self.bgImages.count;
}

- (UIImage *)animatedImagesView:(XKAnimatedImagesView *)animatedImagesView
                   imageAtIndex:(NSUInteger)index {
    
    return self.bgImages[index];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.model = self.dataSource[indexPath.row];
    
    cell.tag = indexPath.row;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XKMyDiaryDetailController *detailVC = [[XKMyDiaryDetailController alloc] init];
    
    self.transition = [[XKMyDiaryTransition alloc] init];
    
    [self.transition transitioonWithSelectCell:[tableView cellForRowAtIndexPath:indexPath] visibleCells:[tableView visibleCells] originFrame:[tableView cellForRowAtIndexPath:indexPath].frame finalFrame:CGRectMake(0, tableView.contentOffset.y, SCREEN_WIDTH, SCREEN_HEIGHT - MyDiaryNavigationBarHeight - 10 * PROPORTION )];
    
    detailVC.transitioningDelegate = self.transition;
    
    detailVC.dataSource = self.dataSource;
    
    detailVC.block = ^{
        
        [self.animatedImageView startAnimating];
    };
    
    [self presentViewController:detailVC animated:YES completion:^{
        
        [self.animatedImageView stopAnimating];
    }];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    
    [UIView animateWithDuration:1 animations:^{
        
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}

- (void)didChangeValueOfSegmentControl:(UISegmentedControl *)segment {
    
    switch (segment.selectedSegmentIndex) {
            
        case 0:
        {
            [self.calendarView removeFromSuperview];
            
            [self removeEditorController];
            
            self.navigationBar.isHiddenLabel = NO;
            
            self.typingView.hidden = YES;
            
            self.toolBarView.hidden = YES;
            
            [self.view addSubview:self.tableView];
            
            [self.tableView.mj_header beginRefreshing];
        }
            
            break;
            
        case 1:
        {
            [self.tableView removeFromSuperview];
            
            [self removeEditorController];
            
            self.navigationBar.isHiddenLabel = YES;
            
            self.typingView.hidden = YES;
            
            self.toolBarView.hidden = YES;
            
            [self.view addSubview:self.calendarView];
            
            [self.calendarView.calendarView calenderOfToday];
            
        }
            
            break;
            
        case 2:
        {
            [self.tableView removeFromSuperview];
            
            [self.calendarView removeFromSuperview];
            
            self.navigationBar.isHiddenLabel = YES;
            
            [self addEditorController];
            
            self.typingView.hidden = NO;
            
            self.toolBarView.hidden = NO;
            
        }
            
            break;
            
        default:
            break;
    }
    
}

#pragma mark -- XKMyDiaryTypingCalendarViewDelegate 

- (void)leftButtonPressed {
    
    !self.typingView.dicDate ? (self.typingView.dicDate = [NSDate getDayDicAfterDays:-1 fromDate:[NSDate getTodayDate]]) : (self.typingView.dicDate = [NSDate getDayDicAfterDays:-1 fromDate:self.typingView.dicDate[MYDIARYDATE]]);
}

- (void)rightButtonPressed {
    
    !self.typingView.dicDate ? (self.typingView.dicDate = [NSDate getDayDicAfterDays:1 fromDate:[NSDate getTodayDate]]) : (self.typingView.dicDate = [NSDate getDayDicAfterDays:1 fromDate:self.typingView.dicDate[MYDIARYDATE]]);
}

#pragma mark -- XKMyDiaryToolBarViewDelegate

- (void)didClickButtonOfType:(MyDiaryToolBarButtonType)type button:(UIButton *)sender {
    
    switch (type) {
            
        case MyDiaryToolBarEmotionButton:
            
            [self showEmotionChooseView:sender];
            
            break;
            
        case MyDiaryToolBarWeatherButton:
            
            [self showWeatherChooseView:sender];
            
            break;
            
        case MyDiaryToolBarSaveButton:
            
            [self saveMyDiary];
            
            break;
            
        default:
            break;
    }
}

#pragma mark -- XKCalendarViewDelegate

- (void)calendarViewscrollToFrontOrLater:(NSDictionary *)dayDict {
    
    NSString *year = dayDict[MYDIARYYEAR];
    NSString *month = dayDict[MYDIARYMONTH];
    NSString *day = dayDict[MYDIARYDAY];
    
    self.dayDiary = @[].mutableCopy;
    
    NSMutableArray *cacheDataArray = [XKMyDiaryCache getDataWithDateString:MYDIARYCACHEKEY];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@ && %K = %@ && %K = %@", @"year", year, @"month", month, @"day", day];
    
    NSArray *array = [cacheDataArray filteredArrayUsingPredicate:predicate];
    
    __block XKDiaryModel *model;
    
    if (array.count != 0) {
        
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            model = [XKDiaryModel yy_modelWithDictionary:obj];
            
            [self.dayDiary addObject:model];
        }];
        
        self.calendarView.model = self.dayDiary[0];
        
        return;
    }
    
    self.calendarView.model = nil;
}

#pragma mark -- 处理键盘

- (void)keyboardDidShow:(NSNotification *)notification {
    
    NSValue *keyboardObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect;
    
    [keyboardObject getValue:&keyboardRect];
    
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.editorController.view.frame = CGRectMake(0, 58, SCREEN_WIDTH, SCREEN_HEIGHT - 58 - keyboardRect.size.height);
        
        self.typingView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 58);
        
        [self.typingView transformToSmallMood];
        
        self.navigationBar.frame = CGRectMake(0, - MyDiaryTypingCalendarViewHeight, SCREEN_WIDTH, MyDiaryTypingCalendarViewHeight);
        
    }];
}

- (void)keyboardDidHidden:(NSNotification *)notification {
    
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.navigationBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, MyDiaryNavigationBarHeight);
        
        self.editorController.view.frame = CGRectMake(0, MyDiaryNavigationBarHeight + MyDiaryTypingCalendarViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - MyDiaryNavigationBarHeight - MyDiaryTypingCalendarViewHeight - 49);
        
        self.typingView.frame = CGRectMake(0, MyDiaryNavigationBarHeight, SCREEN_WIDTH, MyDiaryTypingCalendarViewHeight);
        
        [self.typingView transformToNormalMood];
    }];
}

- (void)handleDisKeyBoardButtonClick {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

#pragma mark -- 私有方法
- (void)addEditorController {
    
    [self addChildViewController:self.editorController];
    
    [self.view addSubview:self.editorController.view];
}

- (void)removeEditorController {
    
    [self.editorController willMoveToParentViewController:self];
    
    [self.editorController.view removeFromSuperview];
    
    [self.editorController removeFromParentViewController];
}

- (void)showEmotionChooseView:(UIButton *)sender {
    
    NSArray *array = @[@"happy_highlight", @"normal_highlight", @"sad_highlight"];
    
    [FTPopOverMenu showForSender:sender withMenuArray:@[@"开心", @"一般", @"伤心"] imageArray:array doneBlock:^(NSInteger selectedIndex) {
        
        self.toolBarView.emotionString = array[selectedIndex];
        
    } dismissBlock:^{
        
        
    }];
}

- (void)showWeatherChooseView:(UIButton *)sender {
    
    NSArray *array = @[@"sunny_highlight", @"cloudy_highlight", @"rain_highlight", @"snow_highlight"];
    
    [FTPopOverMenu showForSender:sender withMenuArray:@[@"天晴", @"多云", @"下雨", @"雪"] imageArray:array doneBlock:^(NSInteger selectedIndex) {
        
        self.toolBarView.weatherString = array[selectedIndex];
        
    } dismissBlock:^{
        
    }];
}

- (void)saveMyDiary {
    
    NSString *year = self.typingView.dicDate[MYDIARYYEAR];
    NSString *month = self.typingView.dicDate[MYDIARYMONTH];
    NSString *day = self.typingView.dicDate[MYDIARYDAY];
    
    NSString *detail = [self.editorController getHTML];
    
    if (detail.length > 0) {
        
        if ([NSDate compareOneDay:self.typingView.dicDate[MYDIARYDATE] withAnotherDay:[NSDate getTodayDate]] == 1) {
            
            [XKMydiaryProgressHUD showImage:@"happy_highlight" message:@"平行时空，但你依然无法提前书写未来的日记"];
            
            return;
        }
        
        NSMutableArray *cacheDataArray = [XKMyDiaryCache getDataWithDateString:MYDIARYCACHEKEY];
        
        NSDictionary *dict = @{MYDIARYTITLE:self.typingView.dicDate[MYDIARYYEAR],
                               MYDIARYDETAIL:detail,
                               MYDIARYDATE:self.typingView.dicDate[MYDIARYDATE],
                               MYDIARYYEAR:self.typingView.dicDate[MYDIARYYEAR],
                               MYDIARYMONTH:self.typingView.dicDate[MYDIARYMONTH],
                               MYDIARYDAY:self.typingView.dicDate[MYDIARYDAY],
                               MYDIARYWEEK:self.typingView.dicDate[MYDIARYWEEK],
                               MYDIARYEMOTION:[self.toolBarView.emotionString stringByReplacingOccurrencesOfString:@"highlight" withString:@"blue"],
                               MYDIARYWEATHER:[self.toolBarView.weatherString stringByReplacingOccurrencesOfString:@"highlight" withString:@"blue"]};
        
        if (!cacheDataArray) {
            
            cacheDataArray = @[].mutableCopy;
        }
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@ && %K = %@ && %K = %@", @"year", year, @"month", month, @"day", day];
        
        NSArray *array = [cacheDataArray filteredArrayUsingPredicate:predicate];
        
        if (array.count != 0) {
            
            [cacheDataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([(NSDictionary *)obj isEqualToDictionary:(NSDictionary *)array[0]]) {
                    
                    [cacheDataArray removeObject:obj];
                }
            }];
        }
        
        [cacheDataArray addObject:dict];
        
        [XKMyDiaryCache setDiaryCacheWithdate:MYDIARYCACHEKEY diaryData:cacheDataArray];
        
        [XKMydiaryProgressHUD showSuccess:@"保存成功"];
        
    } else {
        
        [XKMydiaryProgressHUD showImage:@"happy_highlight" message:@"写点什么再保存吧"];
    }
}

#pragma mark -- 懒加载
- (XKNavigationBar *)navigationBar {
    
    if (!_navigationBar) {
        _navigationBar = [[XKNavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, MyDiaryNavigationBarHeight)];
        _navigationBar.xkDelegate = self;
        _navigationBar.isHiddenLabel = YES;
    }
    return _navigationBar;
}

- (XKAnimatedImagesView *)animatedImageView {
    
    if (!_animatedImageView) {
        _animatedImageView = [[XKAnimatedImagesView alloc] initWithFrame:self.view.bounds];
        _animatedImageView.delegate = self;
        [self.animatedImageView startAnimating];
    }
    return _animatedImageView;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, MyDiaryNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tag = 1000;
        _tableView.rowHeight = MyDiaryCellHeight;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, MyDiaryNavigationBarHeight + 8, 0);
        _tableView.scrollIndicatorInsets = _tableView.contentInset;
        [_tableView registerClass:[XKTableViewCell class] forCellReuseIdentifier:identifier];
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [self initDataSource];
            
        }];

    }
    return _tableView;
}

- (XKMyDiaryCalendarView *)calendarView {
    
    if (!_calendarView) {
        
        _calendarView = [[XKMyDiaryCalendarView alloc] initWithFrame:CGRectMake(0, MyDiaryNavigationBarHeight, SCREEN_WIDTH, MyDiaryCalendarViewHeight)];
        _calendarView.calendarView.delegate = self;
        
        
        __weak typeof(self) weakSelf = self;
        _calendarView.block = ^(UITableView *tableView, NSIndexPath *indexPath) {
            
            XKMyDiaryDetailController *detailVC = [[XKMyDiaryDetailController alloc] init];
            
            detailVC.dataSource = weakSelf.dayDiary.copy;
            
            detailVC.block = ^{
                
                [weakSelf.animatedImageView startAnimating];
            };
            
            [weakSelf presentViewController:detailVC animated:YES completion:^{
                
                
            }];
        };
    }
    return _calendarView;
}

- (NSArray *)bgImages {
    
    if (!_bgImages) {
        
        NSMutableArray *mutableArray = @[].mutableCopy;
        
        for (int i = 1; i < 5; i ++) {
            
            NSString *imageName = [NSString stringWithFormat:@"bg%d",i];
            
            UIImage *image = [UIImage imageNamed:imageName];
            
            [mutableArray addObject:image];
        }
        
        _bgImages = mutableArray.copy;
    }
    return _bgImages;
}

- (XKMyDiaryEditorController *)editorController {
    
    if (!_editorController) {
        _editorController = [[XKMyDiaryEditorController alloc] init];
        _editorController.view.frame = CGRectMake(0, MyDiaryNavigationBarHeight + MyDiaryTypingCalendarViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - MyDiaryNavigationBarHeight - MyDiaryTypingCalendarViewHeight - 49);
    }
    return _editorController;
}

- (XKMyDiaryTypingCalendarView *)typingView {
    
    if (!_typingView) {
        
        _typingView = [[XKMyDiaryTypingCalendarView alloc] initWithFrame:CGRectMake(0, MyDiaryNavigationBarHeight, SCREEN_WIDTH, MyDiaryTypingCalendarViewHeight)];
        
        _typingView.dicDate = [NSDate getDayDicAfterDays:0 fromDate:[NSDate getTodayDate]];
        
        _typingView.delegate = self;
        
        _typingView.hidden = YES;
        
    }
    return _typingView;
}

- (XKMyDiaryToolBarView *)toolBarView {
    
    if (!_toolBarView) {
        _toolBarView = [[XKMyDiaryToolBarView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49)];
        
        _toolBarView.delegate = self;
        
        _toolBarView.hidden = YES;
    }
    return _toolBarView;
}

@end
