//
//  UIColor+FBLCommon.m
//  FBLWoodmall
//
//  Created by 123 on 2017/2/20.
//  Copyright © 2017年 Emir. All rights reserved.
//

#import "UIColor+FBLCommon.h"

@implementation UIColor (FBLCommon)

+ (UIColor *)colorWithHex:(NSString *)string {
    NSString *cleanString = [string stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}


+(UIImage*)imageWithColor:(UIColor*)color

{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    return image;
    
}
/** 主色调 深绿色*/
+ (UIColor *)deepMainColor {
    return [UIColor colorWithHex:@"#8CC63F"];
}
//主题色
/** 主色调 绿色*/
+ (UIColor *)mainColor {
    return [UIColor colorWithHex:@"#439FF9"];
}
/** 合同字体红*/
+ (UIColor *)redAgreementColor {
    return [UIColor colorWithHex:@"#D65F38"];
}
/** 第二主色调 浅绿*/
+ (UIColor *)secondColor {
    return [UIColor colorWithHex:@"#EFFFDB"];
}

/** 主背景色 浅灰*/
+ (UIColor *)mainBackgroundColor {
    return [UIColor colorWithHex:@"#F5F5F5"];
}
/** 第二背景色 白色*/
+ (UIColor *)secondBackgroundColor {
    return [UIColor colorWithHex:@"#FFFFFF"];
}
/** 分割线颜色 >浅灰*/
+ (UIColor *)seperatorColor {
    return [UIColor colorWithHex:@"#EEEEEE"];
}
/** 字体主色 黑色*/
+ (UIColor *)mainFontColor {
    return [UIColor colorWithHex:@"#333333"];
}
/** 段落字体色 深灰*/
+ (UIColor *)paragraghFontColor {
    return [UIColor colorWithHex:@"#9B9B9B"];
}
/** 引导字体颜色 <深灰*/
+ (UIColor *)guideFontColor {
    return [UIColor colorWithHex:@"#CCCCCC"];
}
/** 价格文字 红色*/
+ (UIColor *)priceFontColor {
    return [UIColor colorWithHex:@"#8CC63F"];
}
/** 价格红色 */
+ (UIColor *)priceRedFontColor
{
    return [UIColor colorWithHex:@"#D0021B"];
}
//主题视觉色值 导航栏/icon颜色
+(UIColor *)colorddbb99
{
 return [UIColor colorWithHex:@"#ddbb99"];
}
//主要文字大标题显示
+(UIColor *)color7c4b00{
 return [UIColor colorWithHex:@"#7c4b00"];
}
+(UIColor *)coloreeeeee{
    return [UIColor colorWithHex:@"#eeeeee"];
}
+(UIColor *)color8a8a8a{
    return [UIColor colorWithHex:@"#8a8a8a"];
}
+(UIColor *)color333333{
    return [UIColor colorWithHex:@"#333333"];
}
+(UIColor *)colorcecece{
    return [UIColor colorWithHex:@"#cecece"];
}
+(UIColor *)colorc1c1c1{
    return [UIColor colorWithHex:@"#c1c1c1"];
}
+(UIColor *)colorff0000{
    return [UIColor colorWithHex:@"#ff0000"];
}
+ (UIColor *)graySearchColor
{
    return [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
}
@end
