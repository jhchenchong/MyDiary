//
//  AnimatedCollectionViewLayout.m
//  AnimatedCollectionViewLayout
//
//  Created by 浪漫恋星空 on 2017/3/21.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "AnimatedCollectionViewLayout.h"
#import "ZoomInOutAttributesAnimator.h"

@interface AnimatedCollectionViewLayout ()

@property (nonatomic, strong) id animator;

@end

@implementation AnimatedCollectionViewLayout

- (instancetype)initWithAnimationType:(Class)animationType {
    
    if (self = [super init]) {
        
        self.animator = [[animationType alloc] init];
        
        self.delegate = self.animator;
    }
    return self;
}

+ (Class)layoutAttributesClass {
    
    return NSClassFromString(@"AnimatedCollectionViewLayoutAttributes");
}

//- (void)prepareLayout {
//    
//    [super prepareLayout];
//}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *array = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    
    for (AnimatedCollectionViewLayoutAttributes *attributes in array) {
        
        [self transformLayoutAttributes:attributes];
    }
    
    return array;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return true;
}

- (UICollectionViewLayoutAttributes *)transformLayoutAttributes:(AnimatedCollectionViewLayoutAttributes *)attributes {
    
    CGFloat distance = 0, itemOffset = 0;
    
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        
        distance = self.collectionView.frame.size.width;
        
        itemOffset = attributes.center.x - self.collectionView.contentOffset.x;
        
        attributes.startOffset = (attributes.frame.origin.x - self.collectionView.contentOffset.x) / attributes.frame.size.width;
        
        attributes.endOffset = (attributes.frame.origin.x - self.collectionView.contentOffset.x - self.collectionView.frame.size.width) / attributes.frame.size.width;
        
    } else {
        
        distance = self.collectionView.frame.size.height;
        
        itemOffset = attributes.center.y - self.collectionView.contentOffset.y;
        
        attributes.startOffset = (attributes.frame.origin.y - self.collectionView.contentOffset.y) / attributes.frame.size.height;
        
        attributes.endOffset = (attributes.frame.origin.y - self.collectionView.contentOffset.y - self.collectionView.frame.size.height) / attributes.frame.size.height;
    }
    
    attributes.scrollDirection = self.scrollDirection;
    
    attributes.middleOffset = itemOffset / distance - 0.5;
    
    if (attributes.contentView == nil) {
        
        attributes.contentView = [self.collectionView cellForItemAtIndexPath:attributes.indexPath].contentView;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(animate:attributes:)]) {
        
        [self.delegate animate:self.collectionView attributes:attributes];
    }
    
    return attributes;
}

@end
