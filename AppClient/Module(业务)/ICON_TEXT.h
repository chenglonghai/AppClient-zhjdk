//
//  ICON_TEXT.h
//  AppClient
//
//  Created by xinz on 2018/1/4.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICON_TEXT : UIView

- (instancetype)initWithFrame:(CGRect)frame
                         icon:(NSString *)icon
                       tittle:(NSString *)tittle;

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *tLabel;

@end
