//
//  XKMyDiaryTransition.m
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/4/5.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "XKMyDiaryTransition.h"

@interface XKMyDiaryTransition () 

@property (nonatomic, assign) BOOL isPresent;

@property (nonatomic, strong) UITableViewCell *selectCell;

@property (nonatomic, strong) NSArray *visibleCells;

@property (nonatomic, assign) CGRect originFrame;

@property (nonatomic, assign) CGRect finalFrame;

@end

@implementation XKMyDiaryTransition

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.isPresent = YES;
    }
    return self;
}

- (void)transitioonWithSelectCell:(UITableViewCell *)selectCell visibleCells:(NSArray *)visibleCells originFrame:(CGRect)originFrame finalFrame:(CGRect)finalFrame {
    
    self.selectCell = selectCell;
    
    self.visibleCells = visibleCells;
    
    self.originFrame = originFrame;
    
    self.finalFrame = finalFrame;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.45;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    self.selectCell.frame = self.isPresent ? self.originFrame : self.finalFrame;
    
    UIView *addView = toVC.view;
    
    addView.hidden = self.isPresent ? YES : NO;
    
    [transitionContext.containerView addSubview:addView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:1 animations:^{
        
        for (UITableViewCell *cell in self.visibleCells) {
            
            if (cell != self.selectCell) {
                
                CGRect frame = cell.frame;
                
                if (cell.tag < self.selectCell.tag) {
                    
                    CGFloat y = self.originFrame.origin.y - self.finalFrame.origin.y + 30;
                    
                    self.isPresent ? (y = y) : (y = -y);
                    
                    frame.origin.y -= y;
                }
                
                if (cell.tag > self.selectCell.tag) {
                    
                    CGFloat y = CGRectGetMaxY(self.finalFrame) - CGRectGetMaxY(self.originFrame) + 30;
                    
                    self.isPresent ? (y = y) : (y = -y);
                    
                    frame.origin.y += y;
                }
                
                cell.frame = frame;
                
                cell.transform = self.isPresent ? (CGAffineTransformMakeScale(0.8, 1)) : CGAffineTransformIdentity;
            }
        }
        
        self.selectCell.frame = self.isPresent ? self.finalFrame : self.originFrame;
        
        [self.selectCell layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        addView.hidden = NO;
        
        [transitionContext completeTransition:YES];
        
    }];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    self.isPresent = YES;
    
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    self.isPresent = NO;
    
    return self;
}

@end
