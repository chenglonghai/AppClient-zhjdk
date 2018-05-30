//
//  SingleListCollectionViewCell.m
//  AppClient
//
//  Created by xinz on 2018/1/2.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "SingleListCollectionViewCell.h"

@implementation SingleListCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        [self addSubs];
    }
    return self;
}


- (void)addSubs{
    
    self.icon = [[UIImageView alloc] init];
    [self.contentView addSubview:self.icon];
    
    self.tLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.tLabel];
    
    self.cLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.cLabel];
    
    
    
    
    
    
    
    self.icon.backgroundColor = [UIColor whiteColor];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.height.equalTo(@90);
    }];
    
    
    self.icon.image = [UIImage imageNamed:@"Yosemite02"];
    self.icon.contentMode = UIViewContentModeScaleAspectFit;
    self.icon.userInteractionEnabled = YES;
    self.icon.contentMode  = UIViewContentModeScaleAspectFill;
    self.icon.clipsToBounds = YES;
    [self.icon setContentScaleFactor:[[UIScreen mainScreen] scale]];
    
    self.tLabel.backgroundColor = [UIColor whiteColor];
    self.tLabel.font = [UIFont systemFontOfSize:16.0f];
    self.tLabel.text = @"易经经";
    self.tLabel.textAlignment = NSTextAlignmentLeft;
    self.tLabel.textColor = [UIColor color7c4b00];
    [self.tLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(0);
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.height.equalTo(@20);
    }];
    
    
    self.cLabel.backgroundColor = [UIColor whiteColor];
    self.cLabel.font = [UIFont systemFontOfSize:16.0f];
    self.cLabel.text = @"易经经XXXX";
    self.cLabel.textAlignment = NSTextAlignmentLeft;
    self.cLabel.textColor = [UIColor color8a8a8a];
    [self.cLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tLabel.mas_bottom).offset(0);
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.height.equalTo(@20);
    }];
    

}
- (void)setVideoModel:(VideoModel *)videoModel{
 
    if (_videoModel != videoModel) {
        _videoModel = videoModel;
    }
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_videoModel.picUrl] placeholderImage: [UIImage imageNamed:@"Yosemite02"]];
     self.tLabel.text = [NSString stringWithFormat:@"%@",_videoModel.title];
  self.cLabel.text = [NSString stringWithFormat:@"%@",_videoModel.descriptions];
}
@end
