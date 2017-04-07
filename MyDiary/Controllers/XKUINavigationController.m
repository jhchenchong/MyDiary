//
//  XKUINavigationController.m
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/25.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "XKUINavigationController.h"

@interface XKUINavigationController ()

@end

@implementation XKUINavigationController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationBar.hidden = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    
    return UIStatusBarAnimationFade;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count >= 1) {
        
        self.navigationBar.hidden = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    
    self.navigationBar.hidden = YES;
    
    return [super popViewControllerAnimated:animated];
}

@end
