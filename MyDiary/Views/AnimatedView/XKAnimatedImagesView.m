//
//  XKAnimatedImagesView.m
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/25.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "XKAnimatedImagesView.h"

#define noImageDisplayingIndex -1

#define imageSwappingAnimationDuration 2.0f

#define imageViewsBorderOffset 150

#define kJSAnimatedImagesViewDefaultTimePerImage 20.0f

static const CGFloat kMovementAndTransitionTimeOffset = 0.1;

@interface XKAnimatedImagesView () {
    
    BOOL animating;
    
    NSUInteger totalImages;
    
    NSUInteger currentlyDisplayingImageViewIndex;
    
    NSInteger currentlyDisplayingImageIndex;
    
}

@property(nonatomic, retain) NSArray *imageViews;

@property(nonatomic, retain) NSTimer *imageSwappingTimer;

- (void)initUserInterface;

+ (NSUInteger)randomIntBetweenNumber:(NSUInteger)minNumber
                           andNumber:(NSUInteger)maxNumber;

@end

@implementation XKAnimatedImagesView

- (void)dealloc {
    
    [_imageSwappingTimer invalidate];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if ((self = [super initWithCoder:aDecoder])) {
        
        [self initUserInterface];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame])) {
        
        [self initUserInterface];
    }
    
    return self;
}


+ (NSUInteger)randomIntBetweenNumber:(NSUInteger)minNumber
                           andNumber:(NSUInteger)maxNumber {
    if (minNumber > maxNumber) {
        
        return [self randomIntBetweenNumber:maxNumber andNumber:minNumber];
    }
    
    NSUInteger i = (arc4random() % (maxNumber - minNumber + 1)) + minNumber;
    
    return i;
}

- (void)initUserInterface {
    
    NSMutableArray *imageViews = [NSMutableArray array];
    
    for (int i = 0; i < 2; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-imageViewsBorderOffset * 3, -imageViewsBorderOffset, self.bounds.size.width +(imageViewsBorderOffset * 2), self.bounds.size.height + (imageViewsBorderOffset * 2))];
        
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        imageView.clipsToBounds = NO;
        
        [self addSubview:imageView];
        
        [imageViews addObject:imageView];
    }
    
    self.imageViews = [imageViews copy];
    
    currentlyDisplayingImageIndex = noImageDisplayingIndex;
}

- (void)startAnimating {
    
    if (!animating) {
        
        animating = YES;
        
        [self.imageSwappingTimer fire];
    }
}

- (void)stopAnimating {
    
    if (animating) {
        
        [_imageSwappingTimer invalidate];
        
        _imageSwappingTimer = nil;
        
        [UIView animateWithDuration:imageSwappingAnimationDuration
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             for (UIImageView *imageView in self.imageViews) {
                                 
                                 imageView.alpha = 1.0;
                             }
                         } completion:^(BOOL finished) {
                             
                             currentlyDisplayingImageIndex = noImageDisplayingIndex;
                             
                             animating = NO;
                         }];
    }
}

- (void)reloadData {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(animatedImagesNumberOfImages:)]) {
        
        totalImages = [self.delegate animatedImagesNumberOfImages:self];
        
        [self.imageSwappingTimer fire];
        
    }
}

- (void)bringNextImage {
    
    UIImageView *imageViewToHide = [self.imageViews objectAtIndex:currentlyDisplayingImageViewIndex];
    
    currentlyDisplayingImageViewIndex = currentlyDisplayingImageViewIndex == 0 ? 1 : 0;
    
    UIImageView *imageViewToShow = [self.imageViews objectAtIndex:currentlyDisplayingImageViewIndex];
    
    NSUInteger nextImageToShowIndex = 0;
    
    do {
        nextImageToShowIndex = [[self class] randomIntBetweenNumber:0 andNumber:totalImages - 1];
    } while (nextImageToShowIndex == currentlyDisplayingImageIndex);
    
    currentlyDisplayingImageIndex = nextImageToShowIndex;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(animatedImagesNumberOfImages:)]) {
        
        imageViewToShow.image = [self.delegate animatedImagesView:self imageAtIndex:nextImageToShowIndex];
    }
    
    [UIView animateWithDuration:self.timePerImage + imageSwappingAnimationDuration +kMovementAndTransitionTimeOffset
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState |UIViewAnimationCurveLinear
                     animations:^{
         
         NSInteger randomTranslationValueX = imageViewsBorderOffset * 3.5 -
         [[self class] randomIntBetweenNumber:0
                                    andNumber:imageViewsBorderOffset];
         
         NSInteger randomTranslationValueY = 0;
         
         CGAffineTransform translationTransform = CGAffineTransformMakeTranslation(randomTranslationValueX,randomTranslationValueY);
         
         CGFloat randomScaleTransformValue = 1.0;
         
         CGAffineTransform scaleTransform = CGAffineTransformMakeScale(randomScaleTransformValue, randomScaleTransformValue);
         
         imageViewToShow.transform = CGAffineTransformConcat(scaleTransform, translationTransform);
     } completion:NULL];
    
    [UIView animateWithDuration:imageSwappingAnimationDuration
                          delay:kMovementAndTransitionTimeOffset
                        options:UIViewAnimationOptionBeginFromCurrentState |
     UIViewAnimationCurveLinear
                     animations:^{
                         imageViewToShow.alpha = 1.0;
                         
                         imageViewToHide.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             
                             imageViewToHide.transform = CGAffineTransformIdentity;
                         }
                     }];
}

- (NSTimeInterval)timePerImage {
    
    if (_timePerImage == 0) {
        
        return kJSAnimatedImagesViewDefaultTimePerImage;
    }
    
    return _timePerImage;
}

- (void)setDelegate:(id<XKAnimatedImagesViewDelegate>)delegate {
    
    if (delegate != _delegate) {
        
        _delegate = delegate;
        
        totalImages = [_delegate animatedImagesNumberOfImages:self];
    }
}

- (NSTimer *)imageSwappingTimer {
    
    if (!_imageSwappingTimer) {
        
        _imageSwappingTimer = [NSTimer timerWithTimeInterval:self.timePerImage target:self selector:@selector(bringNextImage) userInfo:nil repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:_imageSwappingTimer forMode:NSRunLoopCommonModes];
    }
    
    return _imageSwappingTimer;
}

@end
