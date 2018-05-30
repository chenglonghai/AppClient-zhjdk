//
//  NSObject+Hub.m
//  LeftRight
//
//  Created by LIANG on 2017/2/5.
//  Copyright © 2017年 Emir. All rights reserved.
//

#import "NSObject+Hub.h"
#import <MBProgressHUD.h>

@implementation NSObject (Hub)

+ (void)showProgress {
    [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
}

+ (void)hideProgress {
    [MBProgressHUD hideHUDForView:kKeyWindow animated:YES];
}

+ (void)showHUDWithMsg:(NSString *)msg{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1];
}

@end
