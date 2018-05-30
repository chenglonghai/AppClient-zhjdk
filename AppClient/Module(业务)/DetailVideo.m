//
//  DetailVideo.m
//  AppClient
//
//  Created by xinz on 2018/1/13.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "DetailVideo.h"
#import "StringSize.h"
@implementation DetailVideo
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"description"]) {
        self.descriptions = [NSString stringWithFormat:@"%@",value];
    }
}

-(CGFloat)cellHeight{
    
    _cellHeight = 16;
    CGSize maxSize = CGSizeMake(kScreenWidth - 30, MAXFLOAT);
    //16.7
    CGSize titleSize =  [StringSize hehestringSizeWithSize:self.descriptions font:15.0f textSizeMax:maxSize];
    NSLog(@"%@",NSStringFromCGSize(titleSize));
    _cellHeight  += titleSize.height ;
    
    return titleSize.height+1;
    
}
@end
