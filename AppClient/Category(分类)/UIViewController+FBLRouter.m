//
//  UIViewController+FBLRouter.m
//  FBLWoodmall
//
//  Created by 123 on 2017/2/20.
//  Copyright © 2017年 Emir. All rights reserved.
//

#import "UIViewController+FBLRouter.h"
#import "AppDelegate.h"

@implementation UIViewController (FBLRouter)

+ (void)fbl_pushViewController:(UIViewController *)viewController
                     animated:(BOOL)animated {
    [[kAppDelegate rootNavigationController] pushViewController:viewController
                                                  animated:animated];
}

+ (void)fbl_presentViewController:(UIViewController *)viewController
                        animated:(BOOL)flag
                      completion:(void (^)(void))completion {
    [[kAppDelegate rootNavigationController] presentViewController:viewController
                                                     animated:flag
                                                   completion:completion];
}

@end
