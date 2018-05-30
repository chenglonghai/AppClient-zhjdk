//
//  CLHDisoverViewController.h
//  AppClient
//
//  Created by xinz on 2018/1/7.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "CLHBaseViewController.h"
#import "ZJScrollPageViewDelegate.h"
@interface CLHDisoverViewController : CLHBaseViewController<ZJScrollPageViewChildVcDelegate>
-(instancetype)initWithOrderType:(NSInteger )type;
@end
