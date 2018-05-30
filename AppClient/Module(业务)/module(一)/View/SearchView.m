//
//  SearchView.m
//  AppClient
//
//  Created by xinz on 2018/1/8.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.layer.cornerRadius = 3;
        self.clipsToBounds = YES;
        
        [self addviews];
    }
    return self;
}
- (void)addviews{
    self.icon = [[UIImageView alloc] init];
    [self addSubview:self.icon];
    self.icon.userInteractionEnabled = YES;
    self.icon.image = [UIImage imageNamed:@"search"];
    self.icon.contentMode = UIViewContentModeScaleAspectFit;
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-5);
        make.width.equalTo(self.icon).offset(0);
    }];
    
    self.tittleLabel = [[UILabel alloc] init];
    [self addSubview:self.tittleLabel];
    self.tittleLabel.textColor = [UIColor colorc1c1c1];
    self.tittleLabel.font = [UIFont systemFontOfSize:15.0f];
    self.tittleLabel.text = @"搜索您喜欢的视频";
    self.tittleLabel.textAlignment = NSTextAlignmentLeft;
    [self.tittleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(self.height );
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-5);
        make.right.equalTo(self).offset(0);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchAction:)];
    
    [self addGestureRecognizer:tap];
}

- (void)searchAction:(UITapGestureRecognizer *)tap{
    if (self.didSeach) {
        self.didSeach(nil);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
