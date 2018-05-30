//
//  ChangeNicknameViewController.h
//  AppClient
//
//  Created by xinz on 2018/1/13.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "SecondViewController.h"

typedef void(^DidComplete)(id param);

@interface ChangeNicknameViewController : SecondViewController
@property (nonatomic, copy) DidComplete didComplete;
@end
