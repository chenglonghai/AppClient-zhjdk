//
//  NSString+FBLAlgorithm.m
//  FBLWoodmall
//
//  Created by emir on 2017/3/17.
//  Copyright © 2017年 Emir. All rights reserved.
//

#import "NSString+FBLAlgorithm.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (FBLAlgorithm)

/**
 Des加密
 */
//#pragma mark- DES加密算法
//+ (NSString *)encryptUseDES:(NSString *)plainText {
//    
//    NSString *ciphertext = nil;
//    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
//    NSUInteger dataLength = [textData length];
//    
//    size_t bufferSize = dataLength + kCCBlockSizeDES;
//    void * buffer = malloc(bufferSize);
//    size_t numBytesEncrypted = 0;
//    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
//                                          kCCOptionPKCS7Padding,
//                                          [kDesKey UTF8String], kCCKeySizeDES,
//                                          [kDesAndHmacSha1Iv UTF8String],
//                                          [textData bytes], dataLength,
//                                          buffer, bufferSize,
//                                          &numBytesEncrypted);
//    if (cryptStatus == kCCSuccess) {
//        NSData *data = [NSData dataWithBytes:buffer length:numBytesEncrypted];
//        
//        ciphertext = [data base64EncodedStringWithOptions:0];
//    }
//    return ciphertext;
//}
//
//
//
///**
// Des解密
// */
//+ (NSString *)decryptUseDES:(NSString *)cipherText {
//
//    NSData* ivData = [kDesAndHmacSha1Iv dataUsingEncoding: NSUTF8StringEncoding];
//    Byte *ivBytes = (Byte *)[ivData bytes];
//    
//    NSString *plaintext = nil;
//    NSData *cipherdata = [[NSData alloc] initWithBase64EncodedString:cipherText options:0];
//    
//    unsigned char buffer[[cipherdata length]];
//    memset(buffer, 0, sizeof(char));
//    size_t numBytesDecrypted = 0;
//    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
//                                          kCCOptionPKCS7Padding,
//                                          [kDesKey UTF8String], kCCKeySizeDES,
//                                          ivBytes,
//                                          [cipherdata bytes], [cipherdata length],
//                                          buffer, [cipherdata length],
//                                          &numBytesDecrypted);
//    if(cryptStatus == kCCSuccess) {
//        NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
//        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
//        
//    }
//    return plaintext;
//}
//
//
///**
// HmacSha1加密
// */
//+ (NSString *)encryptUseHmacSha1:(NSString *)data {
//    
//    const char *cKey  = [kHmacSha1Key cStringUsingEncoding:NSASCIIStringEncoding];
//    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
//    
//    //sha1
//    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
//    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
//    
//    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC
//                                          length:sizeof(cHMAC)];
//    
//    NSString *hash = [HMAC base64EncodedStringWithOptions:0];//将加密结果进行一次BASE64编码。
//    hash = [hash stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
//    hash = [hash stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
//    
//    return hash;
//}

/**
 转json
 */
+ (NSString*)DataToJsonString:(id)object {
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}


/**
 移除NSString空格和换行
 */
+ (NSString *)removeSpaceAndNewline:(NSString *)str
{
    NSString *temp = [str stringByReplacingOccurrencesOfString:@"" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
       temp = [temp stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
//    temp = [temp stringByReplacingOccurrencesOfString:@"\\" withString:@""];
//    temp = [temp stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSLogDebug(@"%@",[NSString stringWithFormat:@"\\"]);
    NSLogDebug(@"%@",temp);
//    temp = [temp stringByReplacingOccurrencesOfString:@"[" withString:@""];
//    temp = [temp stringByReplacingOccurrencesOfString:@"]" withString:@""];
    return temp;
}
+(NSString *)timeTranslaterTimestamp:(NSString *)timestamp
{
    
    NSString *timeStr = [NSString stringWithFormat:@"%@",timestamp];
    if ([timeStr isEqualToString:@"(null)"]) {
        
        return @"";
    }
    else{
    NSTimeInterval interval=[timestamp doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
  [objDateformat setDateFormat:@"yyyy-MM-dd"];
//     [objDateformat setDateFormat:@"yyyy-MM-dd"];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return timeStr;
    }
    
}

+(NSString *)time__TranslaterTimestamp:(NSString *)timestamp
{
    
    NSString *timeStr = [NSString stringWithFormat:@"%@",timestamp];
    if ([timeStr isEqualToString:@"(null)"]) {
        
        return @"";
    }
    else{
        NSTimeInterval interval=[timestamp doubleValue] / 1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
        NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
        [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        //     [objDateformat setDateFormat:@"yyyy-MM-dd"];
        NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
        return timeStr;
    }
    
}
+(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
    
}
+(NSString *)timeTranslaterTimestampHours:(NSString *)timestamp
{
    

    //    return dateString;
    //实例化一个NSDateFormatter对象
    
    NSTimeInterval interval=[timestamp doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy/MM/dd HH:mm"];
    //     [objDateformat setDateFormat:@"yyyy-MM-dd"];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return timeStr;
    
}
+(NSString *)timeTranslaterTimestampDay:(NSString *)timestamp
{
    
    
    //    return dateString;
    //实例化一个NSDateFormatter对象
    
    NSTimeInterval interval=[timestamp doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy/MM/dd"];
    //     [objDateformat setDateFormat:@"yyyy-MM-dd"];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return timeStr;
    
}
+(BOOL)isBiggerAfterTwoDayWithSelectTime:(NSString *)selectDay
{
    NSDate * date = [NSDate date];//当前时间
    NSDate *nextDay = [NSDate dateWithTimeInterval:48*60*60 sinceDate:date];//后两天
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //     [objDateformat setDateFormat:@"yyyy-MM-dd"];
    NSString * twoDayStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: nextDay]];
//    NSLog(@"==%@ ==%@ --%d",twoDayStr, selectDay,[NSString compareOneDay:selectDay withAnotherDay:twoDayStr]);
    if ([NSString compareOneDay:selectDay withAnotherDay:twoDayStr] == 1) {
       
        return YES;
    }
    return NO;
}




+(int)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay
{
    
    
    
    
    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
//    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
//    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
//    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
//    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [oneDay compare:anotherDay];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}



+ (CGSize)sizeForLabelWithString:(NSString *)str
                           width:(float)width{

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    //设置自动行数与字符换行
    [label setNumberOfLines:0];
    label.lineBreakMode = UILineBreakModeWordWrap;
    // 测试字串
    NSString *s = str;
    UIFont *font = [UIFont fontWithName:@"Arial" size:13.0f];
    //设置一个行高上限
    CGSize size = CGSizeMake(width,2000);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
  
    
    return labelsize;

}

+ (CGSize)sizeForLabelWithString:(NSString *)str
                           width:(float)width fontSize:(float)fontSize{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    //设置自动行数与字符换行
    [label setNumberOfLines:0];
    label.lineBreakMode = UILineBreakModeWordWrap;
    // 测试字串
    NSString *s = str;
    UIFont *font = [UIFont fontWithName:@"Arial" size:fontSize];
    //设置一个行高上限
    CGSize size = CGSizeMake(width,8000);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    
    
    return labelsize;
    
}
+(BOOL)checkBankCardNumber:(NSString *)cardNumber
{
    int oddSum = 0;     // 奇数和
    int evenSum = 0;    // 偶数和
    int allSum = 0;     // 总和
    
    // 循环加和
    for (NSInteger i = 1; i <= cardNumber.length; i++)
    {
        NSString *theNumber = [cardNumber substringWithRange:NSMakeRange(cardNumber.length-i, 1)];
        int lastNumber = [theNumber intValue];
        if (i%2 == 0)
        {
            // 偶数位
            lastNumber *= 2;
            if (lastNumber > 9)
            {
                lastNumber -=9;
            }
            evenSum += lastNumber;
        }
        else
        {
            // 奇数位
            oddSum += lastNumber;
        }
    }
    allSum = oddSum + evenSum;
    // 是否合法
    if (allSum%10 == 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
+ (BOOL)CheckIsIdentityCard: (NSString *)identityCard
{

    //判断是否为空
    if (identityCard==nil||identityCard.length <= 0) {
        return NO;
    }
    //判断是否是18位，末尾是否是x
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    if(![identityCardPredicate evaluateWithObject:identityCard]){
        return NO;
    }
    //判断生日是否合法
    NSRange range = NSMakeRange(6,8);
    NSString *datestr = [identityCard substringWithRange:range];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyyMMdd"];
    if([formatter dateFromString:datestr]==nil){
        return NO;
    }
    
    //判断校验位
    if(identityCard.length==18)
    {
        NSArray *idCardWi= @[ @"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2" ]; //将前17位加权因子保存在数组里
        NSArray * idCardY=@[ @"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2" ]; //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        int idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
        for(int i=0;i<17;i++){
            idCardWiSum+=[[identityCard substringWithRange:NSMakeRange(i,1)] intValue]*[idCardWi[i] intValue];
        }
        
        int idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置
        NSString *idCardLast=[identityCard substringWithRange:NSMakeRange(17,1)];//得到最后一位身份证号码
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2){
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
                return YES;
            }else{
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast intValue]==[idCardY[idCardMod] intValue]){
                return YES;
            }else{
                return NO;
            }
        }
    }
    return NO;
}
+ (BOOL)isContainerLiterAndNumber:(NSString *)passWord
{
    
    BOOL isDigit = NO;//定义一个boolean值，用来表示是否包含数字
    BOOL isLetter = NO;//定义一个boolean值，用来表示是否包含字母
    BOOL isLength = NO;
    BOOL isContainsChina = NO;
    //长度判断
    if(passWord.length <= 5 || passWord.length >=  17){
        isLength = NO;
    }else {
         isLength = YES;
    }
    
    //是否包含字母
    NSRegularExpression *LRegular = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger count1 = [LRegular numberOfMatchesInString:passWord options:NSMatchingReportProgress range:NSMakeRange(0, passWord.length)];
    //count是str中包含[A-Za-z]数字的个数，只要count>0，说明str中包含数字
    if (count1 > 0) {
        isLetter = YES;
    }
 
  //是否包含数字
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger count2 = [numberRegular numberOfMatchesInString:passWord options:NSMatchingReportProgress range:NSMakeRange(0, passWord.length)];
    //count是str中包含[0-9]数字的个数，只要count>0，说明str中包含数字
    if (count2 > 0) {
        isDigit = YES;
    }
;
    
   //是否含有中文
    
    
    for(int i=0; i< passWord.length;i++){
        int a = [passWord characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            isContainsChina = YES;
        }
        
    }
    
    
    NSLog(@"==--%d-==%d==-%d",isDigit, isLetter, isLength);
    if(isDigit == YES && isLetter == YES && isLength == YES ){
    
        return YES;
    }

    return NO;
}
@end
