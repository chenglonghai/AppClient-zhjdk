//
//  MeHeaderCollectionReusableView.h
//  AppClient
//
//  Created by xinz on 2018/1/9.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidGo)(id param);

@interface MeHeaderCollectionReusableView : UICollectionReusableView

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, copy)DidGo didGo;


@end
