//
//  UILabel+XKLabel.m
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/26.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "UILabel+XKLabel.h"

@implementation UILabel (XKLabel)

+ (UILabel *)configLabelWithFont:(NSString *)fontName fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment {
    
    UILabel *label = [[UILabel alloc] init];
    
    label.font = [UIFont fontWithName:fontName size:fontSize];
    
    label.textColor = MyDiaryThemeBlueColor;
    
    label.text = @"25";
    
    label.textAlignment = textAlignment;
    
    return label;
}

@end
