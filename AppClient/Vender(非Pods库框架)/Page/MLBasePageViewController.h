//
//  MLBasePageViewController.h
//  MLPageVC
//
//  Created by 玛丽 on 2017/12/11.
//  Copyright © 2017年 玛丽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLHSecondViewController.h"
#import "SecondViewController.h"
@interface MLBasePageViewController : SecondViewController


@property (nonatomic, strong) NSArray *sectionTitles;
@property (nonatomic, strong) NSArray<UIViewController *>  *VCArray;

@end
