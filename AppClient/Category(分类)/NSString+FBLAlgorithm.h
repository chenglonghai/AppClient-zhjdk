//
//  NSString+FBLAlgorithm.h
//  FBLWoodmall
//
//  Created by emir on 2017/3/17.
//  Copyright © 2017年 Emir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FBLAlgorithm)

//+ (NSString *)encryptUseDES:(NSString *)plainText;
//+ (NSString *)decryptUseDES:(NSString *)cipherText;
//
//+ (NSString *)encryptUseHmacSha1:(NSString *)data;
+ (NSString*)DataToJsonString:(id)object;
+ (NSString *)removeSpaceAndNewline:(NSString *)str;
+(NSString *)timeTranslaterTimestamp:(NSString *)timestamp;
+(NSString *)time__TranslaterTimestamp:(NSString *)timestamp;
+ (BOOL)isBiggerAfterTwoDayWithSelectTime:(NSString *)selectDay;
+(NSString *)timeTranslaterTimestampHours:(NSString *)timestamp;
+(NSString *)timeTranslaterTimestampDay:(NSString *)timestamp;
+(int)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay;
+ (CGSize)sizeForLabelWithString:(NSString *)str
                           width:(float)width;
+ (CGSize)sizeForLabelWithString:(NSString *)str
                           width:(float)width fontSize:(float)fontSize;
+(BOOL)checkBankCardNumber:(NSString *)cardNumber;
+ (BOOL)CheckIsIdentityCard: (NSString *)identityCard;


+ (BOOL)isContainerLiterAndNumber:(NSString *)passWord;
+(NSString *)getNowTimeTimestamp;
@end
