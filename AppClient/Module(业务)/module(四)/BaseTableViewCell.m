//
//  BaseTableViewCell.m
//  AppClient
//
//  Created by xinz on 2017/10/20.
//  Copyright © 2017年 Chenlonghai. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

+ (instancetype)cellWithIndexPath:(NSIndexPath *)indexPath
{
    BaseTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BaseTableViewCell class]) owner:self options:nil] lastObject];
    return cell;
}





- (void)awakeFromNib{
    
    self.bottomLineView = [[UIImageView alloc] init];
    self.tLabel = [[UILabel alloc] init];
    self.arrowhead = [[UIImageView alloc] init];
    [self.contentView addSubview:self.bottomLineView];
    [self.contentView addSubview:self.tLabel];
    [self.contentView addSubview:self.arrowhead];
    
    
    self.bottomLineView.backgroundColor = [UIColor seperatorColor];
    
    
    NSLog(@"-------------------------");
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-0.5);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 30,0.5));
        
    }];
    

    self.tLabel.font = [UIFont systemFontOfSize:16.0f];
    self.tLabel.text = @"标题";
    self.tLabel.textColor = [UIColor blackColor];
    [self.tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
         make.left.equalTo(self.contentView).offset(15);
//       make.bottom.equalTo(self.contentView).offset(-(self.contentView.height - 30)/2.0);
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
    self.arrowhead.image = [UIImage imageNamed:@"ic_arrow"];
    

    


    
    
    
    
    
    
    
    // Initialization code
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
