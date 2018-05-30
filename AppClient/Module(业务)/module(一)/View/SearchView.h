//
//  SearchView.h
//  AppClient
//
//  Created by xinz on 2018/1/8.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidSeach)(id param);
@interface SearchView : UIView

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *tittleLabel;
@property (nonatomic, copy)DidSeach didSeach;
@end
