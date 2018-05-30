//
//  DownloadDetailCollectionViewCell.h
//  AppClient
//
//  Created by xinz on 2018/1/10.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailVideo.h"
#import "SQCustomButton.h"
@interface DownloadDetailCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *tLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *cLabel;
@property (nonatomic, strong) UIView *downView;
@property (nonatomic, strong) SQCustomButton *leftBtn;
@property (nonatomic, strong) SQCustomButton *rightBtn;
@property (nonatomic, strong) DetailVideo *detailVideo;

@end
