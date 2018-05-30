//
//  RecommdVideoCollectionViewCell.m
//  AppClient
//
//  Created by xinz on 2018/1/10.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "RecommdVideoCollectionViewCell.h"

@implementation RecommdVideoCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addview];
    }
    return self;
}
- (void)addview{

    self.bottomLineView = [[UIImageView alloc] init];
    self.tLabel = [[UILabel alloc] init];
    self.cLabel = [[UILabel alloc] init];
    self.icon = [[UIImageView alloc] init];
     self.ic = [[UIImageView alloc] init];
    [self.contentView addSubview:self.bottomLineView];
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.ic];
    [self.contentView addSubview:self.tLabel];
    [self.contentView addSubview:self.cLabel];
    
    
    self.icon.backgroundColor = [UIColor coloreeeeee];
    self.icon.contentMode = UIViewContentModeScaleAspectFit;
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.width.equalTo(@130);
    }];
    self.icon.layer.cornerRadius = 5;
    self.icon.clipsToBounds = YES;
    self.icon.userInteractionEnabled = YES;
    self.icon.contentMode  = UIViewContentModeScaleAspectFill;
    self.icon.clipsToBounds = YES;
    [self.icon setContentScaleFactor:[[UIScreen mainScreen] scale]];

    
    self.ic.backgroundColor = [UIColor clearColor];
    self.ic.contentMode = UIViewContentModeScaleAspectFit;
    self.ic.image = [UIImage imageNamed:@"诵读"];
    [self.ic mas_makeConstraints:^(MASConstraintMaker *make) {
 
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    
    
    self.tLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    self.tLabel.text = @"论语《诵读》七章";
    self.tLabel.textColor = [UIColor color7c4b00];
    [self.tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(@20);
    }];
    
    self.cLabel.font = [UIFont systemFontOfSize:16.0f];
    self.cLabel.text = @"书法自己计算机阿设计及";
    self.cLabel.textColor = [UIColor color8a8a8a];
    [self.cLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.tLabel.mas_bottom);
        make.height.equalTo(@18);
    }];
    
    self.bottomLineView.backgroundColor = [UIColor seperatorColor];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-0.5);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 30,0.5));
        
    }];
    

    
}
- (void)setSearchModel:(SearchModel *)searchModel
{
    if (_searchModel != searchModel) {
        _searchModel = searchModel;
    }
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_searchModel.picUrl]];
    self.tLabel.text = [NSString stringWithFormat:@"%@",_searchModel.title];
    self.cLabel.text =[NSString stringWithFormat:@"%@",_searchModel.descriptions];
    
    NSString *contentType = [NSString stringWithFormat:@"%@",_searchModel.contentType];
    
    if ([contentType isEqualToString:@"1"]) {
        self.ic.image = [UIImage imageNamed:@"诵读"];
    }
    if ([contentType isEqualToString:@"2"]) {
         self.ic.image = [UIImage imageNamed:@"讲解"];
    }
    if ([contentType isEqualToString:@"3"]) {
           self.ic.image = [UIImage imageNamed:@"书写"];
        
    }
    
    
    
}

@end
