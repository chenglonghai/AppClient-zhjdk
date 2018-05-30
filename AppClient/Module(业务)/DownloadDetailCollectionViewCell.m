//
//  DownloadDetailCollectionViewCell.m
//  AppClient
//
//  Created by xinz on 2018/1/10.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "DownloadDetailCollectionViewCell.h"

@implementation DownloadDetailCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addview];
    }
    return self;
}
- (void)addview{
    

    self.tLabel = [[UILabel alloc] init];
    self.timeLabel = [[UILabel alloc] init];
    self.cLabel = [[UILabel alloc] init];


    [self.contentView addSubview:self.tLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.cLabel];
    
    

    
    
    self.tLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    self.tLabel.text = @"论语《诵读》";
    self.tLabel.textColor = [UIColor blackColor];
    self.tLabel.textAlignment =NSTextAlignmentCenter;
    [self.tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.right.equalTo(self.contentView).offset(0);
        make.height.equalTo(@40);
    }];
    
    self.timeLabel.font = [UIFont systemFontOfSize:13.0f];
    self.timeLabel.text = @"发布:2017-11-11";
    self.timeLabel.textColor = [UIColor color8a8a8a];
    self.timeLabel.textAlignment =NSTextAlignmentCenter;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
          make.top.equalTo(self.tLabel.mas_bottom);
        make.left.right.equalTo(self.contentView).offset(0);
     
        make.height.equalTo(@20);
    }];
    
    
    self.cLabel.font = [UIFont systemFontOfSize:15.0f];
    self.cLabel.text = @"书法自己计算机阿设计及书法自己计算机阿设计及书法自己计算机阿设计及书法自己计算机阿设计及书法自己计算机阿设计及书法自己计算机阿设计及书法自己计算机阿设计及书法自己计算机阿设计及书法自己计算机阿设计及书法自己计算机阿设计及书法自己计算机阿设计及书法自己计算机阿设计及书法自己计算机阿设计及书法自己计算机阿设计及书法自己计算机阿设计及书法自己计算机阿设计及书法自己计算机阿设计及书法自己计算机阿设计及书法自己计算机阿设计及书法自己计算机阿设计及书法自己计算机阿设计及";
    self.cLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.cLabel.numberOfLines = 0;
    self.cLabel.backgroundColor = [UIColor clearColor];
    self.cLabel.textColor = [UIColor color8a8a8a];
    [self.cLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.timeLabel.mas_bottom);
        make.height.equalTo(@20);
    }];
    
    self.downView = [[UIView alloc] init];
    self.downView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.downView];
    [self.downView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.cLabel.mas_bottom);
        make.height.equalTo(@50);
    }];
//
    
    
    
    [self layoutIfNeeded];
    
//    self.leftBtn = [[SQCustomButton alloc]initWithFrame:CGRectMake(kScreenWidth - 115,5,30,30)
//                                                   type:SQCustomButtonTopImageType
//                                              imageSize:CGSizeMake(20, 20) midmargin:10];
//    self.leftBtn.isShowSelectBackgroudColor = YES;
//    self.leftBtn.imageView.image = [UIImage imageNamed:@"视频下载"];
//    self.leftBtn.backgroundColor = [UIColor clearColor];
//    self.leftBtn.titleLabel.textColor = [UIColor color8a8a8a];
//    self.leftBtn.titleLabel.text = @"下载";
    

    self.rightBtn = [[SQCustomButton alloc]initWithFrame:CGRectMake(kScreenWidth - 45,5,30,30)
                                                    type:SQCustomButtonTopImageType
                                               imageSize:CGSizeMake(20, 20) midmargin:10];
    self.rightBtn.isShowSelectBackgroudColor = YES;
    self.rightBtn.imageView.image = [UIImage imageNamed:@"收藏"];
    self.rightBtn.backgroundColor = [UIColor clearColor];
    self.rightBtn.titleLabel.text = @"收藏";
    self.rightBtn.titleLabel.textColor = [UIColor color8a8a8a];
    [self.rightBtn touchAction:^(SQCustomButton * _Nonnull button) {
        NSLog(@"右图标，左文字");
    }];
    [self.downView  addSubview:self.leftBtn];
    [self.downView  addSubview:self.rightBtn];
    
    
}


- (void)setDetailVideo:(DetailVideo *)detailVideo
{
    if (_detailVideo != detailVideo) {
        _detailVideo = detailVideo;
    }
          self.tLabel.text = [NSString stringWithFormat:@"%@",_detailVideo.title];
    self.timeLabel.text =[NSString stringWithFormat:@"发布:%@",[NSString timeTranslaterTimestamp:_detailVideo.gmtCreate]];
      self.cLabel.text = [NSString stringWithFormat:@"%@",_detailVideo.descriptions];;
    double cLabelH = _detailVideo.cellHeight;
    [self.cLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.timeLabel.mas_bottom);
        make.height.equalTo(@(cLabelH));
    }];
    
    [self.downView  mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.cLabel.mas_bottom);
        make.height.equalTo(@50);
    }];
    
    NSString *collectStatus = [NSString stringWithFormat:@"%@",_detailVideo.collectStatus];
    if ([collectStatus isEqualToString:@"1"]) {
        self.rightBtn.imageView.image = [UIImage imageNamed:@"已收藏"];
    }else{
       self.rightBtn.imageView.image = [UIImage imageNamed:@"收藏"];
    }
    
}

@end
