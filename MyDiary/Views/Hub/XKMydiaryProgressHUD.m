//
//  XKMydiaryProgressHUD.m
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/29.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "XKMydiaryProgressHUD.h"

@implementation XKMydiaryProgressHUD

+ (void)show {
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD show];
}

+ (void)showWithMessage:(NSString *)message style:(SVProgressHUDStyle)style maskType:(SVProgressHUDMaskType)type animationType:(SVProgressHUDAnimationType)animationType {
    
    [SVProgressHUD setDefaultStyle:style];
    [SVProgressHUD setDefaultMaskType:type];
    [SVProgressHUD setDefaultAnimationType:animationType];
    [SVProgressHUD showWithStatus:message];
}

+ (void)showWithMessage:(NSString *)message {
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD showWithStatus:message];
}

+ (void)dismiss {
    
    [SVProgressHUD dismiss];
}

+ (void)showError:(NSString *)errorInfo {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    
    [SVProgressHUD setMinimumDismissTimeInterval:0.5f];
    [SVProgressHUD showErrorWithStatus:errorInfo];
}

+ (void)showSuccess:(NSString *)info {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    
    [SVProgressHUD setMinimumDismissTimeInterval:0.5f];
    [SVProgressHUD showSuccessWithStatus:info];
}

+ (void)showImage:(NSString *)imageName message:(NSString *)message style:(SVProgressHUDStyle)style maskType:(SVProgressHUDMaskType)type animationType:(SVProgressHUDAnimationType)animationType {
    [SVProgressHUD setDefaultStyle:style];
    [SVProgressHUD setDefaultMaskType:type];
    [SVProgressHUD setDefaultAnimationType:animationType];
    
    [SVProgressHUD setMinimumDismissTimeInterval:0.5f];
    [SVProgressHUD showImage:IMAGENAMED(imageName) status:message];
}

+ (void)showImage:(NSString *)imageName message:(NSString *)message {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    
    [SVProgressHUD setMinimumDismissTimeInterval:0.5f];
    [SVProgressHUD showImage:IMAGENAMED(imageName) status:message];
}

@end
