//
//  UIImage+XKImage.m
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/29.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "UIImage+XKImage.h"

@implementation UIImage (XKImage)

+ (NSString *)getLaunchImageName {
    
    NSString *viewOrientation = @"Portrait";
    
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        viewOrientation = @"Landscape";
    }
    
    NSString *launchImageName = nil;
    
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    
    CGSize viewSize = [UIApplication sharedApplication].windows.firstObject.bounds.size;
    
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    return launchImageName;
}

+ (UIImage *)getLaunchImage {
    
    return [UIImage imageNamed:[self getLaunchImageName]];
}

@end
