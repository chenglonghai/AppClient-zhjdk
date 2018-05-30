//
//  MyCollectionTableViewCell.h
//  AppClient
//
//  Created by xinz on 2018/1/9.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"
@interface MyCollectionTableViewCell : UITableViewCell
+ (instancetype)cellWithIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *selectedIcon;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *tLabel;
@property (nonatomic, strong) UILabel *cLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) SearchModel *searchModel;

@property (nonatomic, assign) BOOL isEdit;
@end
