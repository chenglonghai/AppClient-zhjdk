//
//  UIViewController+FBLRouter.h
//  FBLWoodmall
//
//  Created by 123 on 2017/2/20.
//  Copyright © 2017年 Emir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (FBLRouter)

+ (void)fbl_pushViewController:(nullable UIViewController *)viewController
                     animated:(BOOL)animated;

+ (void)fbl_presentViewController:(nullable UIViewController *)viewControllerToPresent
                        animated:(BOOL)flag
                      completion:(void (^ __nullable)(void))completion;
@end
