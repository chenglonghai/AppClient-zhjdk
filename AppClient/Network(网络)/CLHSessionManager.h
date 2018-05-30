//
//  CLHSessionManager.h
//  AppClient
//
//  Created by APAPA on 2017/6/27.
//  Copyright © 2017年 Chenlonghai. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "ResultModel.h"
typedef NS_ENUM(NSInteger, FBLRequestMethod) {
    FBLRequestMethodGet,
    FBLRequestMethodPost,
    FBLRequestMethodDelete
};
typedef void(^ResultBlock)(id rawdata, NSError *error);
typedef void(^ResultCompleteBlock)(NSMutableDictionary *data, NSError *error,ResultModel *resultModel);
@interface CLHSessionManager : AFHTTPSessionManager

+ (instancetype)shareManager;

- (NSURLSessionDataTask *)requestDataWithPath:(NSString *)path paramsJson:(NSString *)paramsJson method:(FBLRequestMethod)method WithCompleteBlock:(ResultCompleteBlock)block;

@end
