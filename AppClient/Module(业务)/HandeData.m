//
//  HandeData.m
//  YiJinYi
//
//  Created by 陈龙海 on 15/12/9.
//  Copyright © 2015年 陈龙海. All rights reserved.
//

#import "HandeData.h"
#import <AFNetworking.h>



@interface HandeData ()

@end


@implementation HandeData
+ (NSString *)timeTranslaterTimestamp:(NSString *)timestamp
{

    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timestamp longLongValue]];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    

    
    
    NSString *dateString = [formatter stringFromDate:confromTimesp];
    
    
    
    
    return dateString;
    
}


- (NSString *)filePath:(NSString *)fileName
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:fileName];
    return filePath;
    
    
}
//归档
- (void)archiverWithArray:(NSMutableArray *)aArray fileName:(NSString *)fileName
{
    NSMutableData * data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:aArray forKey:@"array"];
    [archiver finishEncoding];
    
    BOOL result = [data writeToFile:[self filePath:fileName] atomically:YES];
    if (result) {
        NSLog(@"写入成功");
    }
    
}

//解档
- (NSMutableArray *)unArchiverWithFileName:(NSString *)fileName
{
    
    NSData * data = [[NSData alloc] initWithContentsOfFile:[self filePath:fileName]];
    NSKeyedUnarchiver * unarchier = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSArray * array = [unarchier decodeObjectForKey:@"array"];
    
    [unarchier finishDecoding];
    return [NSMutableArray arrayWithArray:array];
    
    //
}





+ (void)pictureHttpPostRequest:(NSString *)url WithFormdata:(NSMutableDictionary *)formData WithSuccess:(void (^)(ResultModel *response))success failure:(void (^)(NSError *error))failure image:(UIImage *)image avatarPicture:(NSString *)avatarPicture
{
    
    [formData addEntriesFromDictionary:formData];

    
    NSData *imageData = [[NSData alloc] init];
 
    
    imageData = UIImageJPEGRepresentation(image, 0.5);
    
    
    
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *imgStr = [NSString stringWithFormat:@"/image.png"];
    
    NSString *file_Name = [NSString stringWithFormat:@"image.png"];
    
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:imgStr] contents:imageData attributes:nil];

    NSString * filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath, imgStr];
    
    imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:filePath]];
    
    
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:formData constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

        [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:avatarPicture fileName:file_Name mimeType:@"image/png" error:nil];
        
        
    } error:nil];
    
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
     NSProgress *progress = nil;
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {

        NSLog(@"++++%@====",responseObject);
        ResultModel *responseObj = [[ResultModel alloc] init];
        [responseObj setValuesForKeysWithDictionary:responseObject];
        success(responseObj);
      
        
    }];
    
    [uploadTask resume];


}



//- (void)shareWithUrl:(NSString *)url
// shareViewController:(UIViewController *)shareViewController
//           shareIcon:(UIImage *)shareIcon
//         shareTittle:(NSString *)shareTittle
//        shareContent:(NSString *)shareContent
//{
//    if ([QQApiInterface isQQInstalled] == NO  && [WXApi isWXAppInstalled] == NO) {
//        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您未安装QQ或微信客户端,无法进行直接分享" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        
//        [alertView show];
//        
//        
//        
//    }else
//    {
//        
//        
//        
//        //qq
//        [UMSocialData defaultData].extConfig.qqData.title =shareTittle;
//        //微信
//        [UMSocialData defaultData].extConfig.wechatSessionData.title = shareTittle;
//        //圈
//        [UMSocialData defaultData].extConfig.wechatTimelineData.title =  shareTittle;
//        //QQ空间
//        [UMSocialData defaultData].extConfig.qzoneData.title = shareTittle;
//  
//        
//        
//        [UMSocialQQHandler setQQWithAppId:@"1105091556" appKey:@"OjbHcMiZxpWjrUG2" url:url];
//        //
//        [UMSocialWechatHandler setWXAppId:@"wx82dd59474c922e85" appSecret:@"5eab5c88f1c05e987cf78ccc68ccd698" url:url];
//        
//        
//        
//        [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
//    
//        
//        [UMSocialSnsService presentSnsIconSheetView:shareViewController
//                                             appKey:@"56879a56e0f55a19cd001068"
//                                          shareText:shareContent
//                                         shareImage:shareIcon
//                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToQQ,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,nil]
//                                           delegate:nil];
//  
//    }
//
//
//
//
//}
//-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
//{
//
////    NSLog(@"%@", platformName);
//
//}
////实现回调方法（可选）：
//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    //根据`responseCode`得到发送结果,如果分享成功
//    if(response.responseCode == UMSResponseCodeSuccess)
//    {
//        //得到分享到的微博平台名
//        //        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
//    }
//}


@end
