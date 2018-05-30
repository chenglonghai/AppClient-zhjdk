//
//  UpImageDownTextView.m
//  AppClient
//
//  Created by longhai on 2018/4/23.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "UpImageDownTextView.h"

@implementation UpImageDownTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, self.width, self.width-25)];
        self.img.backgroundColor = [UIColor clearColor];
        self.img.contentMode = UIViewContentModeScaleAspectFit;
        self.img.userInteractionEnabled =  YES;
        [self addSubview:self.img];
        
        self.tLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.img.bottom, self.width, self.height-self.img.bottom)];
        self.tLabel.textColor = [UIColor colorddbb99];
        self.tLabel.textAlignment = NSTextAlignmentCenter;
        self.tLabel.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:self.tLabel];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
