//
//  CLHTabBarController.m
//  AppClient
//
//  Created by APAPA on 2017/6/27.
//  Copyright © 2017年 Chenlonghai. All rights reserved.
//

#import "CLHTabBarController.h"

#import "CLHFirstViewController.h"
#import "CLHSecondViewController.h"
//#import "CLHThirdViewController.h"
#import "CLHFourthViewController.h"
#import "CLHNavigationController.h"
#import "LoginViewController.h"
#import "MiddleViewController.h"
#import "PlayVideoViewController.h"
#import "DownloadViewController.h"
#import "SLDownLoadModel.h"

@interface CLHTabBarController ()

@end

@implementation CLHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configViewControllers];
    
    self.bottomButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    self.bottomButton.frame = CGRectMake(kScreenWidth/5.0  *3, kScreenHeight-49,2* kScreenWidth/5.0, 49);
    
    self.bottomButton.backgroundColor = [UIColor clearColor];

    [self.bottomButton addTarget:self action:@selector(clickBottom:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bottomButton];
    
    
    

    
    // Do any additional setup after loading the view.
}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.middleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    self.middleBtn.frame = CGRectMake(kScreenWidth/5.0  *2, 0 ,kScreenWidth/5.0, 49);
    
    self.middleBtn.backgroundColor = [UIColor clearColor];
    [self.middleBtn setImage:[[UIImage imageNamed:@"播放"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [self.middleBtn addTarget:self action:@selector(clickMiddleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:_middleBtn];
}

- (void)clickMiddleBtn:(UIButton *)btn{
 NSLog(@"_______中间");
    if ([UserManager shareManager].isLogin == NO) {
        LoginViewController *loginController = [[LoginViewController alloc] init];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginController];
        [self presentViewController:nav animated:YES completion:nil];
    }else{
        [UserManager shareManager].playDict =    [[UserManager shareManager] getPlayVideo];
        
        NSLog(@"______%@", [UserManager shareManager].playDict);
        if ([UserManager shareManager].playDict  == nil) {
            [self showHint:@"暂无播放过视频"];
        }else{
         
            SLDownLoadModel *sd = [SLDownLoadModel new];
            [sd setValuesForKeysWithDictionary:[UserManager shareManager].playDict];
            
        
            
            
            id message = [NSString isExistVideoList:sd.resourceID];
            
            if ([message isKindOfClass:[NSString class]]) {
                if ([message isEqualToString:@"下载中"]) {
                    [self showHint:@"已经在下载中列表"];
                }else{
                [self showHint:@"暂无已下载可播放的"];
                }
                
            }else{
                SLDownLoadModel *model = ( SLDownLoadModel *)message;
                PlayVideoViewController *pvvc = [[PlayVideoViewController alloc] init];
                pvvc.model = model;
                 [UIViewController fbl_pushViewController:pvvc animated:YES];
//                [self.navigationController pushViewController:pvvc animated:YES];
            }
            
            
            
            
            
//
//            CLHNavigationController *pnav =[self.viewControllers objectAtIndex:2];
//            PlayVideoViewController *pvvc = [PlayVideoViewController new];
//            pvvc.videoID =[NSString stringWithFormat:@"%@",[[UserManager shareManager].playDict objectForKey:@"id"]];
//            MiddleViewController *rootVC = [pnav.viewControllers firstObject];
//               NSLog(@"%@",rootVC);
//            [UIViewController fbl_pushViewController:pvvc animated:YES];
        }
        
        
        
    }
    
    
}
- (void)clickBottom:(UIButton *)btn
{
    
    NSLog(@"_______haha");

    LoginViewController *loginController = [[LoginViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginController];
    [self presentViewController:nav animated:YES completion:nil];
    
}
- (void)configViewControllers {
    
    CLHFirstViewController *firstVC = [[CLHFirstViewController alloc] init];
    [self addChildVc:firstVC title:NSLocalizedString(@"首页", nil) image:@"3455" selectedImage:@"矢量智能对象2"];
    
    CLHSecondViewController *secondVC = [[CLHSecondViewController alloc] init];
    [self addChildVc:secondVC title:NSLocalizedString(@"发现", nil) image:@"发现-2" selectedImage:@"组18"];
    
    
    
    
    MiddleViewController *middleVC = [[MiddleViewController alloc] init];
    [self addChildVc:middleVC title:NSLocalizedString(@"", nil) image:@"" selectedImage:@""];
    
    
    
    
    DownloadViewController *thirdVC = [[DownloadViewController alloc] init];
    [self addChildVc:thirdVC title:NSLocalizedString(@"下载", nil) image:@"下载前" selectedImage:@"下载"];

    CLHFourthViewController *fourthVC = [[CLHFourthViewController alloc] init];
    [self addChildVc:fourthVC title:NSLocalizedString(@"我的", nil) image:@"矢量智能对象" selectedImage:@"矢量智能对象拷贝"];
    
}

- (void)addChildVc: (CLHBaseViewController *)childVc title: (NSString *)title image: (NSString *)image selectedImage: (NSString *)selectedImage {
    
    CLHNavigationController   *nav = [[CLHNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor color8a8a8a];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor colorddbb99];
    
    [nav.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    nav.tabBarItem.title = title;
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
