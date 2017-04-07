//
//  XKMyDiaryToolBarView.h
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/3/29.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    MyDiaryToolBarEmotionButton,
    MyDiaryToolBarWeatherButton,
    MyDiaryToolBarSaveButton,
} MyDiaryToolBarButtonType;

@protocol XKMyDiaryToolBarViewDelegate <NSObject>

- (void)didClickButtonOfType:(MyDiaryToolBarButtonType)type button:(UIButton *)sender;

@end

@interface XKMyDiaryToolBarView : UIView

@property (nonatomic, weak) id<XKMyDiaryToolBarViewDelegate> delegate;

@property (nonatomic, copy) NSString *emotionString;

@property (nonatomic, copy) NSString *weatherString;

@end
