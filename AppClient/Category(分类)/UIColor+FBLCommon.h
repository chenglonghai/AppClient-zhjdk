//
//  UIColor+FBLCommon.h
//  FBLWoodmall
//
//  Created by 123 on 2017/2/20.
//  Copyright © 2017年 Emir. All rights reserved.
//  APP色值

#import <UIKit/UIKit.h>

@interface UIColor (FBLCommon)

+ (UIColor *)colorWithHex:(NSString *)string;

+(UIImage*)imageWithColor:(UIColor*)color;
/** 主色调 深绿色*/
+ (UIColor *)deepMainColor;
/** 主色调 */
+ (UIColor *)mainColor;
/** 合同字体红*/
+ (UIColor *)redAgreementColor;

/** 第二主色调 */
+ (UIColor *)secondColor;

/** 主背景色 */
+ (UIColor *)mainBackgroundColor;

/** 第二背景色 */
+ (UIColor *)secondBackgroundColor;

/** 分割线颜色 */
+ (UIColor *)seperatorColor;

/** 字体主色 */
+ (UIColor *)mainFontColor;

/** 段落字体色 */
+ (UIColor *)paragraghFontColor;

/** 引导字体颜色 */
+ (UIColor *)guideFontColor;

/** 价格文字 */
+ (UIColor *)priceFontColor;
/** 价格红色 */
+ (UIColor *)priceRedFontColor;
+ (UIColor *)graySearchColor;
//主题视觉色值 导航栏/icon颜色
+(UIColor *)colorddbb99;
//主要文字大标题显示
+(UIColor *)color7c4b00;
+(UIColor *)coloreeeeee;
+(UIColor *)color8a8a8a;
+(UIColor *)color333333;
+(UIColor *)colorcecece;
+(UIColor *)colorc1c1c1;
+(UIColor *)colorff0000;

@end
