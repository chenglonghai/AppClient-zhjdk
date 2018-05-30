//
//  InfoListTableViewCell.h
//  AppClient
//
//  Created by xinz on 2018/1/10.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
@interface InfoListTableViewCell : BaseTableViewCell
@property (nonatomic, strong) UILabel *cLabel;
+ (instancetype)cellWithIndexPath:(NSIndexPath *)indexPath;
@end
