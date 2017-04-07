//
//  XKMyDiaryTransition.h
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/4/5.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKMyDiaryTransition : NSObject<UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

- (void)transitioonWithSelectCell:(UITableViewCell *)selectCell visibleCells:(NSArray *)visibleCells originFrame:(CGRect)originFrame finalFrame:(CGRect)finalFrame;

@end
