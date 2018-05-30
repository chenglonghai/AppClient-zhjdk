//
//  NSString+RegexString.h
//  AppClient
//
//  Created by xinz on 2017/10/27.
//  Copyright © 2017年 Chenlonghai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegexString)
+(BOOL)validateMobile:(NSString *)mobile;
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSString *)getSign:(NSString *)uuid;
+ (id)isExistVideoList:(NSString *)ID;
@end
