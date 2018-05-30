//
//  NSString+RegexString.m
//  AppClient
//
//  Created by xinz on 2017/10/27.
//  Copyright © 2017年 Chenlonghai. All rights reserved.
//

#import "NSString+RegexString.h"
#import "CommonCrypto/CommonDigest.h"
@implementation NSString (RegexString)

+(BOOL)validateMobile:(NSString *)mobile
{
    // 130-139  150-153,155-159  180-189  145,147  170,171,173,176,177,178
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0-9])|(14[57])|(17[013678]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
+ (NSString *)getSign:(NSString *)uuid{
    
    NSString *firstM5 =  [NSString md5:[NSString stringWithFormat:@"ZHJDZYK%@", uuid]];
      return [NSString md5:firstM5];
    
}

//MD5加密
+(NSString *) md5: (NSString *) inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
}

+ (id)isExistVideoList:(NSString *)ID{
    NSString *meg = @"";
    NSArray *downloadingArr = [[SLDownLoadQueue downLoadQueue] downLoadQueueArr];
    NSArray *downloadedArr = [[SLDownLoadQueue downLoadQueue] completedDownLoadQueueArr];
    
    for (int i = 0; i < downloadingArr.count; i++) {
        SLDownLoadModel *model  = [downloadingArr objectAtIndex:i];
        NSString *I_D = [NSString stringWithFormat:@"%@", model.resourceID];
        if ([I_D isEqualToString:ID]) {
            return @"下载中";
        }
        
    }
    for (int i = 0; i < downloadedArr.count; i++) {
         SLDownLoadModel *model  = [downloadedArr objectAtIndex:i];
        NSString *I_D = [NSString stringWithFormat:@"%@", model.resourceID];
        if ([I_D isEqualToString:ID]) {
            return model;
        }
    }
    return meg;
}


@end
