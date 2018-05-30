//
//  DownloadedTableViewCell.h
//  AppClient
//
//  Created by xinz on 2018/1/9.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownLoadModel.h"

typedef void(^DidSelect)(DownLoadModel *dm);

@interface DownloadedTableViewCell : UITableViewCell
+ (instancetype)cellWithIndexPath:(NSIndexPath *)indexPath;
@property (strong, nonatomic)  UIImageView *bottomLineView;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *tLabel;
@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, copy) DidSelect didSelect;

@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, strong) DownLoadModel *downloadModel;

@end
