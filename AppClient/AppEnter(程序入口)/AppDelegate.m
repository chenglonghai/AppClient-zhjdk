//
//  AppDelegate.m
//  AppClient
//
//  Created by APAPA on 2017/6/27.
//  Copyright © 2017年 Chenlonghai. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "SLFileManager.h"
#import "SLDownLoadQueue.h"
#import "DownLoadTools.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

      [[UINavigationBar appearance] setBackgroundImage:[UIColor imageWithColor:[UIColor colorddbb99]]
                                       forBarMetrics:UIBarMetricsDefault];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
      [self configTabBarVC];
      [self.window makeKeyAndVisible];
    
    long long freeDiskSize = [DownLoadTools getDiskFreeSpaceEx];
    long long totalDiskSize = [DownLoadTools getDiskTotalSpaceEx];
    
    NSLog(@"剩余：：：%7.2lf G --- 总计：：%7.2lf G",freeDiskSize/(1024*1024*1024.0),totalDiskSize/(1024*1024*1024.0));
    
    //获取缓存
    [SLDownLoadQueue getDownLoadCache];
    return YES;
}

- (void)configTabBarVC {

    self.rootVC = [[CLHTabBarController alloc] init];
    self.window.rootViewController = self.rootVC;
}
- (UINavigationController *)rootNavigationController {
    UIViewController *viewController = nil;
    if (self.window.rootViewController == self.rootVC) {
        viewController = self.rootVC.selectedViewController;
    } else {
        viewController = self.window.rootViewController;
    }
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)viewController;
    }
    return viewController.navigationController;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    //将要进入前台的时候刷新一下，防止下载停止，虽然他们的状态是正在下载或待下载状态
    [SLDownLoadQueue updateDownLoad];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    NSLog(@"%@===%d", [[UserManager shareManager] getLocalUserInfo],[UserManager shareManager].isLogin);
    
    NSDictionary *userDic = [[UserManager shareManager] getLocalUserInfo];
    if (userDic != nil) {
        [[UserManager shareManager] saveUserInfo:userDic];
        
        NSLog(@"--%d==%@", [UserManager shareManager].isLogin,[UserManager shareManager].userModel.ID);
    }else{
        [UserManager shareManager].isLogin = NO;
    }
    
//     [UserManager shareManager].downloadingArray =  [[UserManager shareManager] getVieoListArray];
//    [UserManager shareManager].downloadedArray =  [[UserManager shareManager] getCompleteVideoVieoListArray];
//    [UserManager shareManager].playDict =[[UserManager shareManager] getPlayVideo];
//    NSLog(@"正在下载:%@", [UserManager shareManager].downloadingArray);
//    NSLog(@"已经下载:%@", [UserManager shareManager].downloadedArray );
//        NSLog(@"播放:%@", [UserManager shareManager].playDict);
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    //app被杀死的时候做一些本地处理
    [SLDownLoadQueue appWillTerminate];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler
{
    if ([identifier isEqualToString:@"com.sunlei"]) {
        
        [SLDownLoadQueue appWillTerminate];
        //        self.backgroundSessionCompletionHandler = completionHandler;
        completionHandler();
    }
    
}
@end
