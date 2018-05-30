//
//  MeItemCollectionViewCell.m
//  AppClient
//
//  Created by xinz on 2018/1/9.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "MeItemCollectionViewCell.h"

@implementation MeItemCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addViews];
    }
    return self;

}


-(void)addViews{

    self.bottomLineView = [[UIImageView alloc] init];
    self.tLabel = [[UILabel alloc] init];
    self.arrowhead = [[UIImageView alloc] init];
    self.icon = [[UIImageView alloc] init];
    self.bg = [UIView new];
    self.bg.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bg];
    [self.contentView addSubview:self.bottomLineView];
    [self.contentView addSubview:self.tLabel];
    [self.contentView addSubview:self.arrowhead];
    [self.contentView addSubview:self.icon];
   
    
    [self.bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView).offset(0);
    }];
    
    self.icon.backgroundColor = [UIColor clearColor];
    self.icon.contentMode = UIViewContentModeScaleAspectFit;
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(20,20));
        
    }];
    
    
    
    self.bottomLineView.backgroundColor = [UIColor seperatorColor];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-0.5);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 60,0.5));
        
    }];
    
    
    self.tLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    self.tLabel.text = @"";
    self.tLabel.textColor = [UIColor blackColor];
    [self.tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.icon.mas_right).offset(20);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(90,30))
        ;
    }];
    
    
    self.arrowhead.backgroundColor = [UIColor clearColor];
    self.arrowhead.contentMode = UIViewContentModeScaleAspectFit;
    [self.arrowhead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-15);
        make.size.mas_equalTo(CGSizeMake(15,15));
    }];
    self.arrowhead.image = [UIImage imageNamed:@"8"];
    
    
    self.phoneLabel = [UILabel new];
    [self.contentView addSubview:self.phoneLabel];
    
    self.phoneLabel.font = [UIFont systemFontOfSize:14.0f];
    self.phoneLabel.text = @"010-52368952";
    self.phoneLabel.textAlignment = NSTextAlignmentRight;
    self.phoneLabel.textColor = [UIColor blackColor];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(100,30))
        ;
    }];

}
@end
