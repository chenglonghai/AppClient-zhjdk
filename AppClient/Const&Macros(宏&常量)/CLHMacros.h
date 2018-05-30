//
//  CLHMacros.h
//  AppClient
//
//  Created by APAPA on 2017/6/27.
//  Copyright © 2017年 Chenlonghai. All rights reserved.
//

#ifndef CLHMacros_h
#define CLHMacros_h

#ifdef DEBUG
#define NSLogDebug(s, ...) NSLog(@"%s [ line--%d ]: %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
#define NSLogDebug(s, ...)
#endif

//App版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//获取temp
#define kPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b)    RGBA(r,g,b,1.0f)
#define RandomColor   RGB(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))


#define WIDTH(w)  r

// MainScreen Height&Width
#define kKeyWindow [UIApplication sharedApplication].delegate.window
#define kAppDelegate (AppDelegate *)[UIApplication sharedApplication].delegate
#define kScreenHeight      [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth       [[UIScreen mainScreen] bounds].size.width

#define  CLscreenWidth   [UIScreen mainScreen].bounds.size.width
/**UIScreen height*/
#define  CLscreenHeight  [UIScreen mainScreen].bounds.size.height

#define kR      kScreenWidth/375.0
#define kShopImgHeight       75
// MainScreen bounds
#define kScreenBounds [[UIScreen mainScreen] bounds]
#define kNavigationBarHeight 64
#define kNavigationItemFontSize 16
// 当前系统版本
#define kSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])

// 是否大于等于IOS7
#define isIOS7                  ([[[UIDevice currentDevice]systemVersion]doubleValue] >= 7.0)
// 是否IOS6
#define isIOS6                  ([[[UIDevice currentDevice]systemVersion]doubleValue] < 7.0)
// 是否大于等于IOS8
#define isIOS8                  ([[[UIDevice currentDevice]systemVersion]doubleValue] >=8.0)
// 是否大于IOS9
#define isIOS9                  ([[[UIDevice currentDevice]systemVersion]doubleValue] >=9.0)
// 是否iPad
#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


#define kInputWidth 230

// 字体大小(常规/粗体)
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]

#define FBLShowHudMsg(msg)   [NSObject showHUDWithMsg:msg]
#define FBLShowProgress [NSObject showProgress]
#define FBLHideProgress [NSObject hideProgress]


#define ALERT_MSG(msg) static UIAlertView *alert; alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];\
[alert show];\

//不同屏幕尺寸字体适配（375，667是因为效果图为IPHONE6 如果不是则根据实际情况修改）
#define kScreenWidthRatio  (kScreenWidth / 375.0)
#define kScreenHeightRatio (kScreenHeight / 667.0)
#define AdaptedWidth(x)  ceilf((x) * kScreenWidthRatio)
#define AdaptedHeight(x) ceilf((x) * kScreenHeightRatio)
#define AdaptedFontSize(R)     CHINESE_SYSTEM(AdaptedWidth(R))

#endif /* CLHMacros_h */
