//
//  MoreTimesViewController.m
//  AppClient
//
//  Created by xinz on 2018/1/7.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "MoreTimesViewController.h"
#import "HMSegmentedControl.h"
#import "MLBasePageViewController.h"
@interface MoreTimesViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic, strong) HMSegmentedControl *segmented;
@property (nonatomic, strong) UIPageViewController *pageVC;
@property (nonatomic, assign) NSInteger currentSelectIndex;

@end

@implementation MoreTimesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
