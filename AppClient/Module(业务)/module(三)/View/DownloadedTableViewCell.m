//
//  DownloadedTableViewCell.m
//  AppClient
//
//  Created by xinz on 2018/1/9.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "DownloadedTableViewCell.h"

@implementation DownloadedTableViewCell
+ (instancetype)cellWithIndexPath:(NSIndexPath *)indexPath
{
    DownloadedTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DownloadedTableViewCell class]) owner:self options:nil] lastObject];
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code self.bottomLineView = [[UIImageView alloc] init];
    
    self.contentView.backgroundColor = [UIColor coloreeeeee];
    self.bottomLineView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.bottomLineView];
    
    
    
    self.bottomLineView.backgroundColor = [UIColor colorcecece];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-0.5);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 30,0.5));
        
    }];
    
    
    
    
    self.icon = [[UIImageView alloc] init];
    [self.contentView addSubview:self.icon];
    self.tLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.tLabel];
    self.selectedBtn = [[UIButton alloc] init];
    [self.contentView addSubview: self.selectedBtn ];

    
    
    self.selectedBtn.backgroundColor = [UIColor clearColor];
    
    [self.selectedBtn setImage:[UIImage imageNamed:@"椭圆8"] forState:UIControlStateNormal];
    [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [self.selectedBtn addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.icon.backgroundColor = [UIColor colorcecece];
    self.icon.contentMode = UIViewContentModeScaleAspectFit;
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.selectedBtn.mas_right).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.width.equalTo(@(75));
    }];
    self.icon.layer.cornerRadius =5;
    self.icon.contentMode  = UIViewContentModeScaleAspectFill;
    self.icon.clipsToBounds = YES;
    [self.icon setContentScaleFactor:[[UIScreen mainScreen] scale]];
    
    //    UIImageView *lineView = [[UIImageView alloc] init];
    //    lineView.backgroundColor = [UIColor seperatorColor];
    //    [self.contentView addSubview:lineView];
    //    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.contentView).offset(15);
    //        make.right.equalTo(self.contentView).offset(-15);
    //        make.bottom.equalTo(self.contentView).offset(0);
    //        make.height.equalTo(@0.5);
    //
    //    }];
    self.tLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    self.tLabel.textColor = [UIColor colorc1c1c1];
    self.tLabel.text = @"易静怡金刚金";
    [self.tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(15);
        make.right.equalTo(self.contentView).offset(-52);
        make.top.equalTo(self.contentView).offset(10);
        make.height.equalTo(@25);
        
    }];
   

}
- (void)setIsEdit:(BOOL)isEdit
{
    if (_isEdit != isEdit) {
        _isEdit = isEdit;
    }
    if (_isEdit == YES) {
        self.selectedBtn.hidden = NO;
    }else{
      self.selectedBtn.hidden = YES;
    }
}

//- (void)setDict:(NSDictionary *)dict
//{
//    if (_dict != dict) {
//        _dict = dict;
//    }
//    
//    [self.icon sd_setImageWithURL:[NSURL URLWithString:[_dict objectForKey:@"picUrl"]]];
//    self.tLabel.text = [NSString stringWithFormat:@"%@",[_dict objectForKey:@"title"]];
//}
- (void)setDownloadModel:(DownLoadModel *)downloadModel
{
    if (_downloadModel != downloadModel) {
        _downloadModel  =  downloadModel;
    }
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_downloadModel.picUrl]];
    self.tLabel.text = [NSString stringWithFormat:@"%@",_downloadModel.title];
    
    if (_downloadModel.isSelected == YES) {
           [self.selectedBtn setImage:[UIImage imageNamed:@"组155"] forState:UIControlStateNormal];
    }else{
          [self.selectedBtn setImage:[UIImage imageNamed:@"椭圆8"] forState:UIControlStateNormal];
    }
    
}
- (void)selectedAction:(UIButton *)btn{
    if (self.didSelect) {
        self.didSelect(_downloadModel);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
