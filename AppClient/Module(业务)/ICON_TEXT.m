//
//  ICON_TEXT.m
//  AppClient
//
//  Created by xinz on 2018/1/4.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "ICON_TEXT.h"

@implementation ICON_TEXT
- (instancetype)initWithFrame:(CGRect)frame
                         icon:(NSString *)icon
                       tittle:(NSString *)tittle
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    [self addViewWithIcon:icon tittle:tittle];
    return self;
}


- (void)addViewWithIcon:(NSString *)icon
                 tittle:(NSString *)tittle{
    self.icon = [[UIImageView alloc] init];
    self.icon.image = [UIImage imageNamed:icon];
    self.icon.frame = CGRectMake(0, 0, self.height, self.height);
    self.icon.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.icon];
    
    self.tLabel = [[UILabel alloc] init];
    
    self.tLabel.frame = CGRectMake(self.icon.right, 0, self.width-self.height, self.height);
    self.tLabel.textAlignment = NSTextAlignmentLeft;
    self.tLabel.text = tittle;
    self.tLabel.textColor = [UIColor color7c4b00];
    self.tLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [self addSubview:self.tLabel];
    
    
    

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
