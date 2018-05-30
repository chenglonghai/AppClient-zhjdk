//
//  UIViewController+FBLNavigationItem.h
//  FBLWoodmall
//
//  Created by 123 on 2017/2/20.
//  Copyright © 2017年 Emir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (FBLNavigationItem)

// 添加左侧返回按钮
- (UIButton *)fbl_setupLeftBackBarButtonItem;
// 返回按钮点击事件处理
- (void)fbl_leftBackButtonPressed:(id)sender;

// 添加左侧按钮
- (UIButton *)fbl_setupLeftBarButtonItemWithTitle:(NSString *)title
                                           image:(UIImage *)image
                                highLightedImage:(UIImage *)highLightedImage;
- (UIButton *)buttonWithTitle:(NSString *)title
                        image:(UIImage *)image
             highLightedImage:(UIImage *)highLightedImage;
// 左侧按钮事件处理，子类实现
- (void)fbl_leftButtonPressed:(id)sender;

// 添加右侧按钮
- (UIButton *)fbl_setupRightButtonItemWithTitle:(NSString *)title
                                         image:(UIImage *)image
                              highLightedImage:(UIImage *)highLightedImage;
// 右侧按钮事件处理，子类实现
- (void)fbl_rightButtonPressed:(id)sender;

@end
