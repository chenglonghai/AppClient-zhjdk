//
//  RecommdCollectionReusableView.m
//  AppClient
//
//  Created by xinz on 2018/1/10.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "RecommdCollectionReusableView.h"

@implementation RecommdCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}
- (void)addView{
   
    self.tLabel = [[UILabel alloc] init];
    self.tLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    self.tLabel.text= @"相关推荐";
    [self addSubview:self.tLabel];
    [self.tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.bottom.right.equalTo(self).offset(0);
    }];
    
}

@end
