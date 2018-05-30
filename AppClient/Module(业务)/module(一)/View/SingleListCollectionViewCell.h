//
//  SingleListCollectionViewCell.h
//  AppClient
//
//  Created by xinz on 2018/1/2.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"
@interface SingleListCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *tLabel;
@property (nonatomic, strong) UILabel *cLabel;
@property (nonatomic, strong) VideoModel *videoModel;



@end
