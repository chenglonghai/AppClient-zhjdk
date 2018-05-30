//
//  SearchResultTableViewCell.h
//  AppClient
//
//  Created by xinz on 2018/1/8.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"

@interface SearchResultTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *tLabel;
@property (nonatomic, strong) UILabel *cLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) SearchModel *searchModel;

@end
