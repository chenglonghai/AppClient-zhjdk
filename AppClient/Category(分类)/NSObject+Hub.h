//
//  NSObject+Hub.h
//  LeftRight
//
//  Created by LIANG on 2017/2/5.
//  Copyright © 2017年 Emir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Hub)

+ (void)showProgress;

+ (void)hideProgress;

+ (void)showHUDWithMsg:(NSString *)msg;

@end
