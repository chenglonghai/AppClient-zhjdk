//
//  UIViewController+FBLNavigationItem.m
//  FBLWoodmall
//
//  Created by 123 on 2017/2/20.
//  Copyright © 2017年 Emir. All rights reserved.
//

#import "UIViewController+FBLNavigationItem.h"

@implementation UIViewController (FBLNavigationItem)

- (UIButton *)fbl_setupLeftBackBarButtonItem {
    UIButton *button = [self buttonWithTitle:nil
                                       image:[UIImage imageNamed:@"back-top"]
                            highLightedImage:nil];
    [button addTarget:self
               action:@selector(fbl_leftBackButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return button;
}

- (void)fbl_leftBackButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIButton *)fbl_setupLeftBarButtonItemWithTitle:(NSString *)title
                                           image:(UIImage *)image
                                highLightedImage:(UIImage *)highLightedImage {
    UIButton *button = [self buttonWithTitle:title
                                       image:image
                            highLightedImage:highLightedImage];
    [button addTarget:self
               action:@selector(fbl_leftButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return button;
}

- (void)fbl_leftButtonPressed:(id)sender {
    
}

- (UIButton *)fbl_setupRightButtonItemWithTitle:(NSString *)title
                                         image:(UIImage *)image
                              highLightedImage:(UIImage *)highLightedImage {
    UIButton *button = [self buttonWithTitle:title
                                       image:image
                            highLightedImage:highLightedImage];
    [button addTarget:self
               action:@selector(fbl_rightButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return button;
}

- (void)fbl_rightButtonPressed:(id)sender {
    
}

#pragma mark -

- (UIButton *)buttonWithTitle:(NSString *)title
                        image:(UIImage *)image
             highLightedImage:(UIImage *)highLightedImage {
    UIButton *button = [[UIButton alloc] init];
    title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (title.length > 0) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16.f];
    }
    if (image) {
        if (!highLightedImage) {
            highLightedImage = image;
        }
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:highLightedImage forState:UIControlStateHighlighted];
    }
    [button sizeToFit];
    return button;
}

@end
