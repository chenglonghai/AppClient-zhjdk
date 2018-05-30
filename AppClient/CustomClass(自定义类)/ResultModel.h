//
//  ResultModel.h
//  AppClient
//
//  Created by xinz on 2017/10/28.
//  Copyright © 2017年 Chenlonghai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultModel : NSObject

@property (nonatomic, strong) NSString *errCode;
@property (nonatomic, strong) id data;
@property (nonatomic, strong) NSString *errMessage;
@property (nonatomic, strong) NSString *success;


@end
