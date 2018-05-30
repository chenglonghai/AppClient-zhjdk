//
//  MeHeaderCollectionReusableView.m
//  AppClient
//
//  Created by xinz on 2018/1/9.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "MeHeaderCollectionReusableView.h"

@implementation MeHeaderCollectionReusableView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
    }
    return self;

}
- (void)addViews{
   
    UIImageView *bg = [UIImageView new];
    [self addSubview:bg];
    
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self).offset(-20);
        make.right.equalTo(self).offset(0);
        make.height.equalTo(@(120));
    }];
    bg.backgroundColor = [UIColor clearColor];
    
    bg.userInteractionEnabled = YES;
    bg.contentMode = UIViewContentModeScaleToFill;
    bg.image = [UIImage imageNamed:@"头部图片"];
    
    
    
    self.icon = [UIImageView new];
    [self addSubview:self.icon];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(50);
   
        make.size.mas_equalTo(CGSizeMake(100, 100));;
    }];
    
    
    self.icon.backgroundColor = [UIColor colorcecece];
    self.icon.layer.cornerRadius = 50;
    self.icon.clipsToBounds = YES;
    self.icon.contentMode  = UIViewContentModeScaleAspectFill;
    self.icon.userInteractionEnabled = YES;
    [self.icon setContentScaleFactor:[[UIScreen mainScreen] scale]];
    
    UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIcon:)];
    [self.icon addGestureRecognizer:tap];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    self.nameLabel.text = @"";
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textColor = [UIColor blackColor];
    [self addSubview: self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.icon.mas_bottom).offset(15);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(200,20))
        ;
    }];
   
    


}

- (void)tapIcon:(UITapGestureRecognizer *)tap{

    if (self.didGo) {
        self.didGo(nil);
    }

}
@end
