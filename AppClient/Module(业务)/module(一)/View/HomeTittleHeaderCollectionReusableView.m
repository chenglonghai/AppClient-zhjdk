//
//  HomeTittleHeaderCollectionReusableView.m
//  AppClient
//
//  Created by xinz on 2017/12/29.
//  Copyright © 2017年 Chenlonghai. All rights reserved.
//

#import "HomeTittleHeaderCollectionReusableView.h"

@implementation HomeTittleHeaderCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addViews];
        
    }
    return self;
}


- (void)addViews{
    
    [self layoutSubviews];
    
    
    self.tLabel = [[UILabel alloc] init];
    [self addSubview:self.tLabel];
    
    self.tLabel.backgroundColor = [UIColor colorddbb99];
    self.tLabel.font = [UIFont systemFontOfSize:18.0f];
    self.tLabel.text = @"猜你喜欢";
    self.tLabel.textAlignment = NSTextAlignmentCenter;
    self.tLabel.textColor = [UIColor color333333];
    [self.tLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(215, 30));
    }];
    
    self.tLabel.layer.cornerRadius =15;
    self.tLabel.clipsToBounds = YES;
    
    
    
    
}

@end
