//
//  ZoomInOutAttributesAnimator.m
//  AnimatedCollectionViewLayout
//
//  Created by 浪漫恋星空 on 2017/3/21.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "ZoomInOutAttributesAnimator.h"

@interface ZoomInOutAttributesAnimator ()

@property (nonatomic, assign) CGFloat scaleRate;

@end

@implementation ZoomInOutAttributesAnimator

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scaleRate = 0.2;
    }
    return self;
}

- (void)animate:(UICollectionView *)collectionView attributes:(AnimatedCollectionViewLayoutAttributes *)attributes {
    
    CGFloat position = attributes.middleOffset;
    
    if (position <= 0 && position >= -1) {
        
        CGFloat scaleFactor = self.scaleRate * position + 1.0;
        
        attributes.transform = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
        
    } else {
        
        attributes.transform = CGAffineTransformIdentity;
    }
}

@end
