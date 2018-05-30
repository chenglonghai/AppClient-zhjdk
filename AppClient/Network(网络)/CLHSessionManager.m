//
//  CLHSessionManager.m
//  AppClient
//
//  Created by APAPA on 2017/6/27.
//  Copyright © 2017年 Chenlonghai. All rights reserved.
//

#import "CLHSessionManager.h"

@implementation CLHSessionManager
+ (instancetype)shareManager {
    static CLHSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CLHSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl]];

    });
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain" ,@"text/html",nil];
//    [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain" ,nil];
    return manager;
}

- (NSURLSessionDataTask *)requestDataWithPath:(NSString *)path paramsJson:(NSString *)paramsJson method:(FBLRequestMethod)method withBlock:(ResultBlock)block {
    
//    if (!path || path.length <= 0 ) {
//        return nil;
//    }
//    NSLogDebug(@"%@",path);
//    path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    NSLogDebug(@"%@",path);
    //1. 参数DES处理 最后格式：@{@"param":"xdfa11sa"}
    NSDictionary *params = [self dictionaryWithJsonString:paramsJson];;
//    if (paramsJson != nil) {
//        params = @{@"param" : [NSString encryptUseDES:paramsJson]};
//    }
    
    //2. 获取完整url
    //如果是get请求，后面需要把参数拼接全
//    NSString *access_url = [[self.baseURL absoluteString] stringByAppendingString:path];
//    if (method == FBLRequestMethodGet) {
//        NSLogDebug(@"%@",params);
//        NSLogDebug(@"%@",params[@"param"]);
//        NSString *paramValue = [params[@"param"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//        NSLogDebug(@"%@",paramValue);
//        if (paramValue != nil){
//            //[jsonStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//            //access_url = [access_url stringByAppendingString:[NSString stringWithFormat:@"?param=%@", paramValue]];
//            
//            //urlEncode
////            access_url = [access_url stringByAppendingString:[self encodeString:[NSString stringWithFormat:@"?param=%@", paramValue]]];
//            NSLogDebug(@"%@",access_url);
//        }
//    }
    
//    [self.requestSerializer setValue:access_url forHTTPHeaderField:@"access_url"];
    
    //3. 处理header，生成sign，设置header
//    [self generateSignWithParams:params];
    
    NSLogDebug(@"URL----%@",path);
    NSLogDebug(@"请求头部信息---------%@",self.requestSerializer.HTTPRequestHeaders);
    NSLogDebug(@"网络请求参数----%@",params);
    
    //    if (![FBLNetworkReachability isReachable]) {
    //        FBLShowHudMsg(@"网络不给力，请稍后重试");
    //        return nil;
    //    }
    
    NSURLSessionDataTask *task = nil;
    if([path hasSuffix:@"video/downloadVideo"]){
        
    }else
    FBLShowProgress;
    
    switch (method) {
        case FBLRequestMethodGet:
        {
            task = [self GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self successBlock:block WithData:responseObject];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self failureBlock:block WithError:error];
            }];
        }
            break;
        case FBLRequestMethodPost:
        {
            task = [self POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self successBlock:block WithData:responseObject];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self failureBlock:block WithError:error];
            }];
        }
            break;
        case FBLRequestMethodDelete:
        {
            task = [self DELETE:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self successBlock:block WithData:responseObject];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self failureBlock:block WithError:error];
            }];
        }
            break;
        default:
            break;
    }
    return task;
}
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}


- (void)successBlock:(ResultBlock)block WithData:(id)responseObject {
    FBLHideProgress;

        //解密result
    
        //回调
        block(responseObject,nil);


}

- (void)failureBlock:(ResultBlock)block WithError:(NSError *)error{
    FBLHideProgress;
    NSLogDebug(@"error: %@", error.localizedDescription);
    block(nil,error);
}

- (NSURLSessionDataTask *)requestDataWithPath:(NSString *)path paramsJson:(NSString *)paramsJson method:(FBLRequestMethod)method WithCompleteBlock:(ResultCompleteBlock)block {
    
    return [self requestDataWithPath:path paramsJson:(NSString *)paramsJson method:method withBlock:^(id rawdata, NSError *error) {
        if (!error) {
            
            
            NSMutableDictionary *data = [(NSDictionary *)rawdata mutableCopy];
            
            ResultModel *resultModel = [[ResultModel alloc] init];
            
            [resultModel setValuesForKeysWithDictionary:data];
            block(data, error,resultModel);
        }else{
            
            
            block(nil, error,nil);
        }
    }];
}



@end
