//
//  XKAnimatedImagesView.h
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/25.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XKAnimatedImagesViewDelegate;

@interface XKAnimatedImagesView : UIView

@property(nonatomic, weak) id<XKAnimatedImagesViewDelegate> delegate;

@property(nonatomic, assign) NSTimeInterval timePerImage;

- (void)startAnimating;

- (void)stopAnimating;

- (void)reloadData;

@end

@protocol XKAnimatedImagesViewDelegate <NSObject>

- (NSUInteger)animatedImagesNumberOfImages:(XKAnimatedImagesView *)animatedImagesView;

- (UIImage *)animatedImagesView:(XKAnimatedImagesView *)animatedImagesView
                   imageAtIndex:(NSUInteger)index;

@end
