//
//  AppDelegate.h
//  AppClient
//
//  Created by APAPA on 2017/6/27.
//  Copyright © 2017年 Chenlonghai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLHTabBarController.h"
typedef void (^completionHandle)();
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) CLHTabBarController *rootVC;
- (UINavigationController *)rootNavigationController;
- (void)configTabBarVC;
@property (nonatomic,copy)  completionHandle backgroundSessionCompletionHandler;

@end

