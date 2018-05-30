//
//  DownLoadModel.m
//  AppClient
//
//  Created by xinz on 2018/1/20.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "DownLoadModel.h"

@implementation DownLoadModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = [NSString stringWithFormat:@"%@",value];
    }

}
@end
