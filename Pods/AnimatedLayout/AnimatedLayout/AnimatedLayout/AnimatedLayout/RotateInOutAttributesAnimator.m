//
//  RotateInOutAttributesAnimator.m
//  AnimatedCollectionViewLayout
//
//  Created by 浪漫恋星空 on 2017/3/22.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "RotateInOutAttributesAnimator.h"

@interface RotateInOutAttributesAnimator ()

@property (nonatomic, assign) CGFloat minAlpha;

@property (nonatomic, assign) CGFloat maxRotate;

@end

@implementation RotateInOutAttributesAnimator

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.minAlpha = 0;
        
        self.maxRotate = 1;
    }
    return self;
}

- (void)animate:(UICollectionView *)collectionView attributes:(AnimatedCollectionViewLayoutAttributes *)attributes {
    
    CGFloat position = attributes.middleOffset;
    
    if (fabs(position) >= 1) {
        
        attributes.transform = CGAffineTransformIdentity;
        
        attributes.alpha = 1;
        
    } else {
        
        CGFloat rotateFactor = self.maxRotate * position;
        
        attributes.zIndex = attributes.indexPath.row;
        
        attributes.alpha = 1.0 - fabs(position) + self.minAlpha;
        
        attributes.transform = CGAffineTransformMakeRotation(rotateFactor);
    }
    
}

@end
