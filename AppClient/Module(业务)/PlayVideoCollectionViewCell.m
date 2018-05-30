//
//  PlayVideoCollectionViewCell.m
//  AppClient
//
//  Created by xinz on 2018/1/10.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "PlayVideoCollectionViewCell.h"

@implementation PlayVideoCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addview];
    }
    return self;
}
- (void)addview{
    
    self.icon.backgroundColor = [UIColor coloreeeeee];
    self.icon.contentMode = UIViewContentModeScaleAspectFit;
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
    }];
    self.icon.layer.cornerRadius = 5;
    self.icon.clipsToBounds = YES;
    self.icon.userInteractionEnabled = YES;
    self.icon.contentMode  = UIViewContentModeScaleAspectFill;
    self.icon.clipsToBounds = YES;
    [self.icon setContentScaleFactor:[[UIScreen mainScreen] scale]];

    
}

@end
