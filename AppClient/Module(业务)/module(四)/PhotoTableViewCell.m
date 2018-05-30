//
//  PhotoTableViewCell.m
//  AppClient
//
//  Created by xinz on 2018/1/10.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "PhotoTableViewCell.h"

@implementation PhotoTableViewCell
+ (instancetype)cellWithIndexPath:(NSIndexPath *)indexPath
{
    PhotoTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PhotoTableViewCell class]) owner:self options:nil] lastObject];
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.photo = [[UIImageView alloc] init];
    self.photo.backgroundColor = [UIColor coloreeeeee];
    [self.contentView addSubview:self.photo];
    
    [self.photo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-30);
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.centerY.equalTo(self.contentView);
    }];
    self.photo.layer.cornerRadius = 35.0;
    self.photo.clipsToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
