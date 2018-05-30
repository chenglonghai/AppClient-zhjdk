//
//  BaseTableViewCell.h
//  AppClient
//
//  Created by xinz on 2017/10/20.
//  Copyright © 2017年 Chenlonghai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell
+ (instancetype)cellWithIndexPath:(NSIndexPath *)indexPath;
@property (strong, nonatomic)  UIImageView *arrowhead;
@property (strong, nonatomic)  UIImageView *bottomLineView;
@property (strong, nonatomic)  UILabel *tLabel;

//- (void)addSubViews:(UIView *)contentView;
@end
