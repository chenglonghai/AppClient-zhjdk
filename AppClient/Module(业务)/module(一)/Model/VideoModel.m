//
//  VideoModel.m
//  AppClient
//
//  Created by xinz on 2018/1/12.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"description"]) {
        self.descriptions = [NSString stringWithFormat:@"%@",value];
    }
}
@end
