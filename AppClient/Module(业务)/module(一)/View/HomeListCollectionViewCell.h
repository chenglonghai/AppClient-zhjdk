//
//  HomeListCollectionViewCell.h
//  AppClient
//
//  Created by xinz on 2017/12/28.
//  Copyright © 2017年 Chenlonghai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LookMore)(NSInteger index);

@interface HomeListCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *tLabel;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, copy) LookMore lookMore;
@end
