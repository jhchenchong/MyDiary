//
//  XKMyDiaryDetailCell.h
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/4/6.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidClickQuitButtonBlock)(void);

@interface XKMyDiaryDetailCell : UICollectionViewCell

@property (nonatomic, strong) XKDiaryModel *model;

@property (nonatomic, copy) DidClickQuitButtonBlock block;

@end
