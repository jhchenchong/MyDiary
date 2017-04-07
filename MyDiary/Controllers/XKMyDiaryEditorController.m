//
//  XKMyDiaryEditorController.m
//  MyDiary
//
//  Created by 浪漫恋星空 on 2017/4/6.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "XKMyDiaryEditorController.h"

@interface XKMyDiaryEditorController ()

@end

@implementation XKMyDiaryEditorController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.enabledToolbarItems = @[ZSSRichTextEditorToolbarInsertImageFromDevice,
                                 ZSSRichTextEditorToolbarBold,
                                 ZSSRichTextEditorToolbarJustifyLeft,
                                 ZSSRichTextEditorToolbarJustifyCenter,
                                 ZSSRichTextEditorToolbarJustifyRight,
                                 ZSSRichTextEditorToolbarJustifyFull,
                                 ZSSRichTextEditorToolbarH3,
                                 ZSSRichTextEditorToolbarRemoveFormat];
    
    self.alwaysShowToolbar = NO;
    
    self.receiveEditorDidChangeEvents = NO;
    
    self.toolbarItemTintColor = MyDiaryThemeBlueColor;
    
    self.shouldShowKeyboard = NO;
    
    [self setPlaceholder:@"Please tap to Share your diary here..."];
}

@end
