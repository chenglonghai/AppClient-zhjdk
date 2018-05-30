//
//  StringSize.m
//  haha9
//
//  Created by 何达达mac on 17/3/21.
//  Copyright © 2017年 hedada. All rights reserved.
//

#import "StringSize.h"

@implementation StringSize
+(CGSize)hehestringSizeWithSize:(NSString *)text font:(int )font textSizeMax:(CGSize)stringSize
{
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:font]};
    CGSize textSize = [text boundingRectWithSize:stringSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return  textSize;
}
@end
