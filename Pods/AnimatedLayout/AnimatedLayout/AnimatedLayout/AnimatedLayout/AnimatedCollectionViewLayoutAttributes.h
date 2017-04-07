//
//  AnimatedCollectionViewLayoutAttributes.h
//  AnimatedCollectionViewLayout
//
//  Created by 浪漫恋星空 on 2017/3/21.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimatedCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

@property (nonatomic, assign) CGFloat startOffset;

@property (nonatomic, assign) CGFloat middleOffset;

@property (nonatomic, assign) CGFloat endOffset;

@end
