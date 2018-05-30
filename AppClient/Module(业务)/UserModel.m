//
//  UserModel.m
//  AppClient
//
//  Created by xinz on 2018/1/12.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = [NSString stringWithFormat:@"%@",value];
    }
 
}
@end
