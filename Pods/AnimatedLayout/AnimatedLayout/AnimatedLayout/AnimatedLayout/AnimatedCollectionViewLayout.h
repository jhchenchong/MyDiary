//
//  AnimatedCollectionViewLayout.h
//  AnimatedCollectionViewLayout
//
//  Created by 浪漫恋星空 on 2017/3/21.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimatedCollectionViewLayoutAttributes.h"


typedef enum : NSUInteger {
    
    ZoomAnimationType,
    
} AnimationType;

@protocol AnimatedCollectionViewLayoutDelegate <NSObject>

- (void)animate:(UICollectionView *)collectionView attributes:(AnimatedCollectionViewLayoutAttributes *)attributes;

@end


@interface AnimatedCollectionViewLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<AnimatedCollectionViewLayoutDelegate> delegate;

- (instancetype)initWithAnimationType:(Class)animationType;

@end
