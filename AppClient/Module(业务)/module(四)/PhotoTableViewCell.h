//
//  PhotoTableViewCell.h
//  AppClient
//
//  Created by xinz on 2018/1/10.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
@interface PhotoTableViewCell :BaseTableViewCell
+ (instancetype)cellWithIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) UIImageView *photo;


@end
