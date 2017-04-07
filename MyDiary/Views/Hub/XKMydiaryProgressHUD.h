//
//  XKMydiaryProgressHUD.h
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/29.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKMydiaryProgressHUD : NSObject

+ (void)show;

+ (void)dismiss;

+ (void)showWithMessage:(NSString *)message;

+ (void)showWithMessage:(NSString *)message style:(SVProgressHUDStyle)style maskType:(SVProgressHUDMaskType)type animationType:(SVProgressHUDAnimationType)animationType;

+ (void)showError:(NSString *)errorInfo;

+ (void)showSuccess:(NSString *)info;

+ (void)showImage:(NSString *)imageName message:(NSString *)message;

+ (void)showImage:(NSString *)imageName message:(NSString *)message style:(SVProgressHUDStyle)style maskType:(SVProgressHUDMaskType)type animationType:(SVProgressHUDAnimationType)animationType;

@end
