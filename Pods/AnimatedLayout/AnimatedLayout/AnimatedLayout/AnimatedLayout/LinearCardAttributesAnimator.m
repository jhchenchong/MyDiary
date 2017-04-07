//
//  LinearCardAttributesAnimator.m
//  AnimatedCollectionViewLayout
//
//  Created by 浪漫恋星空 on 2017/3/22.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "LinearCardAttributesAnimator.h"


@interface LinearCardAttributesAnimator ()

@property (nonatomic, assign) CGFloat minAlpha;

@property (nonatomic, assign) CGFloat itemSpacing;

@property (nonatomic, assign) CGFloat scaleRate;

@end

@implementation LinearCardAttributesAnimator

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.minAlpha = 0.5;
        
        self.itemSpacing = 0.4;
        
        self.scaleRate = 0.7;
    }
    return self;
}

- (void)animate:(UICollectionView *)collectionView attributes:(AnimatedCollectionViewLayoutAttributes *)attributes {
    
    CGFloat position = attributes.middleOffset;
    
    
    CGFloat scaleFactor = self.scaleRate - 0.1 * fabs(position);
    
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
    
    CGAffineTransform translationTransform;
    
    if (attributes.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        
        CGFloat width = collectionView.frame.size.width;
        
        CGFloat translationX = -(width * self.itemSpacing * position);
        
        translationTransform = CGAffineTransformMakeTranslation(translationX, 0);
        
    } else {
        
        CGFloat height = collectionView.frame.size.height;
        
        CGFloat translationY = -(height * self.itemSpacing * position);
        
        translationTransform = CGAffineTransformMakeTranslation(0, translationY);
    }
    
    attributes.alpha = 1.0 - fabs(position) + self.minAlpha;
    
    attributes.transform = CGAffineTransformConcat(translationTransform, scaleTransform);
}

@end
