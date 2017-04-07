//
//  AnimatedCollectionViewLayoutAttributes.m
//  AnimatedCollectionViewLayout
//
//  Created by 浪漫恋星空 on 2017/3/21.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "AnimatedCollectionViewLayoutAttributes.h"

@implementation AnimatedCollectionViewLayoutAttributes

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.contentView = [[UIView alloc] init];
        
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        self.startOffset = 0;
        
        self.middleOffset = 0;
        
        self.endOffset = 0;
    }
    return self;
}

@end
