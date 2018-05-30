//
//  UIView+FBLExtension.h
//  FBLWoodmall
//
//  Created by 123 on 2017/2/21.
//  Copyright © 2017年 Emir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FBLExtension)

/** tap手势 */
- (void)setTapActionWithBlock:(void (^)(void))block;

@end
