
#ifndef _______zhDefine_h
#define _______zhDefine_h

#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String])
#else
#define NSLog(FORMAT, ...) nil
#endif

// 182.140.233.8
#define BASE_URL(suffFix) [NSString stringWithFormat:@"http://182.140.233.8:8080/app/ios/%@", suffFix]

// 获取屏幕大小
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// 系统控件的默认高度
#define kZHStatusBarHeight   (20.f)
#define kZHTopBarHeight      (44.f)
#define kZHBottomBarHeight   (49.f)

#define kZHCellDefaultHeight (44.f)

#define kZHNavigationHeight (64.0)
#define kZHTabbarHeight 49
#define kZHNavigationAndTabbarHeight (kZHNavigationHeight + kZHTabbarHeight)

// 缩放比例
#define PROPORTION SCREEN_WIDTH / 375

// 判断运行设备
#define IPHONE4 (SCREEN_HEIGHT == 480)
#define IPHONE4S IPHONE4
#define IPHONE5 (SCREEN_HEIGHT == 568)
#define IPHONE5S IPHONE5
#define IPHONE6 (SCREEN_HEIGHT == 1134)
#define IPHONE6S IPHONE6
#define IPHONE6_PLUS (SCREEN_HEIGHT == 2208)
#define IPHONE6S_PLUS IPHONE6_PLUS


// 系统版本
#define IOS7_OR_ABOVE (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0)
#define IOS8_OR_ABOVE (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0)
#define IOS9_OR_ABOVE (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0)


// 按比例设置屏幕frame
#define FRAME(x, y, width, height) CGRectMake(x * SCREEN_WIDTH / 375, y * SCREEN_WIDTH / 375, width * SCREEN_WIDTH / 375, height * SCREEN_WIDTH / 375)

#pragma mark - Funtion Method (宏方法)

#define IMAGENAMED(NAME)       [UIImage imageNamed:NAME]

// 应用程序的名字
#define AppDisplayName              [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]

// 颜色
#define COLOR(redColor,greenColor,blueColor,alphaColor) [UIColor colorWithRed:redColor/255.0 green:greenColor/255.0 blue:blueColor/255.0 alpha:alphaColor]
// RGB颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 字号
#define FONT(size) [UIFont systemFontOfSize:size]
#define FONT_PROPORTION(size) [UIFont systemFontOfSize:(size * PROPORTION)]
#define BOLD_FONT(size) [UIFont boldSystemFontOfSize:size]
#define BOLD_FONT_PROPORTION(size) [UIFont boldSystemFontOfSize:(size * PROPORTION)]
// 根控制器
#define ROOT_VC (UINavigationController *)[[[[UIApplication sharedApplication] delegate] window] rootViewController]
#define WINDOW [[[UIApplication sharedApplication] delegate] window]


#define MyDiaryThemeBlueColor COLOR(70, 130, 180, 1)

#define MyDiaryNavigationBarHeight 109 * PROPORTION

#define MyDiaryCellHeight 90 * PROPORTION

#define MyDiaryCalendarViewHeight 440 * PROPORTION

#define MyDiaryTypingCalendarViewHeight 145 * PROPORTION

#define MYDIARYYEAR @"year"

#define MYDIARYMONTH @"month"

#define MYDIARYDAY @"day"

#define MYDIARYWEEK @"week"

#define MYDIARYDATE @"date"

#define MYDIARYTITLE @"title"

#define MYDIARYDETAIL @"detail"

#define MYDIARYEMOTION @"emotion"

#define MYDIARYWEATHER @"weather"

#define MYDIARYCACHEKEY @"cacheKey"

#endif
