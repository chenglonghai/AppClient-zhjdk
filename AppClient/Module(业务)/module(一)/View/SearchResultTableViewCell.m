//
//  SearchResultTableViewCell.m
//  AppClient
//
//  Created by xinz on 2018/1/8.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "SearchResultTableViewCell.h"

@implementation SearchResultTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addvies];
    }
    return self;
}
- (void)addvies{
    self.icon = [[UIImageView alloc] init];
    [self.contentView addSubview:self.icon];
    self.tLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.tLabel];
    self.cLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.cLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.timeLabel];
    self.icon.backgroundColor = [UIColor seperatorColor];
    self.icon.contentMode = UIViewContentModeScaleAspectFit;
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.width.equalTo(@(kScreenWidth*0.4));
    }];
    self.icon.layer.cornerRadius =5;
    self.icon.clipsToBounds = YES;
    self.icon.userInteractionEnabled = YES;
    self.icon.contentMode  = UIViewContentModeScaleAspectFill;
    self.icon.clipsToBounds = YES;
    [self.icon setContentScaleFactor:[[UIScreen mainScreen] scale]];
  
    UIImageView *lineView = [[UIImageView alloc] init];
    lineView.backgroundColor = [UIColor seperatorColor];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.bottom.equalTo(self.contentView).offset(0);
        make.height.equalTo(@0.5);
        
    }];
    self.tLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    self.tLabel.textColor = [UIColor color333333];
    self.tLabel.text = @"易静怡金刚金";
    [self.tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.contentView).offset(10);
        make.height.equalTo(@20);
        
    }];
    
    self.cLabel.font = [UIFont systemFontOfSize:13.0f];
    self.cLabel.textColor = [UIColor colorc1c1c1];
    self.cLabel.text = @"说说你妈那妈妈妈妈那妈妈说妈妈什么dcscdsd测试测试的但是v说你妈那妈妈妈妈那妈妈说妈妈什说你妈那妈妈妈妈那妈妈说妈妈什";
    self.cLabel.numberOfLines = 3;
    self.cLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.cLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.tLabel.mas_bottom).offset(0);
        make.height.equalTo(@50);
        
    }];
    
    
    self.timeLabel.font = [UIFont systemFontOfSize:13.0f];
    self.timeLabel.textColor = [UIColor colorddbb99];
    self.timeLabel.text = @"2018-01-02";
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.icon.mas_right).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.cLabel.mas_bottom).offset(10);
        make.height.equalTo(@20);
         make.width.equalTo(@80);
    }];
    
    
    
    UIImageView *timeIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:timeIcon];
    timeIcon.image= [UIImage imageNamed:@"历史"];
    timeIcon.backgroundColor = [UIColor clearColor];
    timeIcon.contentMode = UIViewContentModeScaleAspectFit;
    [timeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_top).offset(0);
        make.right.equalTo(self.timeLabel.mas_left).offset(-2.5);
        make.bottom.equalTo(self.timeLabel).offset(0);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    
    
}
- (void)setSearchModel:(SearchModel *)searchModel
{
    if (_searchModel != searchModel) {
        _searchModel = searchModel;
    }
        self.tLabel.text = [NSString stringWithFormat:@"%@",   _searchModel.title];
        self.cLabel.text = [NSString stringWithFormat:@"%@",   _searchModel.descriptions];

        self.timeLabel.text =[NSString stringWithFormat:@"%@",    [NSString timeTranslaterTimestamp:_searchModel.gmtCreate]];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_searchModel.picUrl]];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
       // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
