//
//  InfoListTableViewCell.m
//  AppClient
//
//  Created by xinz on 2018/1/10.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "InfoListTableViewCell.h"

@implementation InfoListTableViewCell
+ (instancetype)cellWithIndexPath:(NSIndexPath *)indexPath
{
    InfoListTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([InfoListTableViewCell class]) owner:self options:nil] lastObject];
    if (indexPath.row == 1) {
      cell.cLabel.text = [UserManager shareManager].userModel.nickname;
    }
    if (indexPath.row == 2) {
        NSString *gender = [NSString stringWithFormat:@"%@",[UserManager shareManager].userModel.gender];
        if ([gender isEqualToString:@"1"]) {
                   cell.cLabel.text = @"男";
        }else{
          cell.cLabel.text = @"女";
        }
        

    }
    if (indexPath.row == 3) {
      cell.cLabel.text = @"";
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    

    self.cLabel = [[UILabel alloc] init];
    
    self.cLabel.textColor = [UIColor color8a8a8a];
    self.cLabel.textAlignment = NSTextAlignmentRight;
    self.cLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:self.cLabel];
    [self.cLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-30);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
