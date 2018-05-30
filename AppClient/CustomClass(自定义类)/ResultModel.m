//
//  ResultModel.m
//  AppClient
//
//  Created by xinz on 2017/10/28.
//  Copyright © 2017年 Chenlonghai. All rights reserved.
//

#import "ResultModel.h"

@implementation ResultModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"success"]) {
        self.success = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"errMessage"]) {
        self.errMessage = [NSString stringWithFormat:@"%@",value];
    }
}
@end
