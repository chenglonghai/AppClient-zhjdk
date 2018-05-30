//
//  UIViewController+DownloadVideoURL.m
//  AppClient
//
//  Created by longhai on 2018/4/17.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "UIViewController+DownloadVideoURL.h"

@implementation UIViewController (DownloadVideoURL)


- (void)downloadVideoWithDic:(NSDictionary *)downloadDic
{
     NSLog(@"___%@", downloadDic);
    BOOL isSave =  [[UserManager shareManager] saveVieoList:downloadDic];
    if (isSave == YES) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showHint:@"加入下载列表成功"];
        });
   
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self showHint:@"已加入下载过了"];
        });
    }
}
@end
