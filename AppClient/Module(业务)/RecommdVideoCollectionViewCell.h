//
//  RecommdVideoCollectionViewCell.h
//  AppClient
//
//  Created by xinz on 2018/1/10.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"

@interface RecommdVideoCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIImageView *ic;
@property (nonatomic, strong) UILabel *tLabel;
@property (nonatomic, strong) UILabel *cLabel;
@property (nonatomic, strong) UIImageView *bottomLineView;
@property (nonatomic, strong) SearchModel *searchModel;
@end
