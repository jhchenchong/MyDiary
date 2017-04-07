//
//  XKMyDiaryDetailController.h
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/4/5.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidDismissedCallBackBlock)();

@interface XKMyDiaryDetailController : UIViewController

@property (nonatomic, copy) DidDismissedCallBackBlock block;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, assign) NSInteger index;

@end
