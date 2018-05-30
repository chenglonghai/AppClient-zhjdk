//
//  CLHSecondViewController.m
//  AppClient
//
//  Created by APAPA on 2017/6/27.
//  Copyright © 2017年 Chenlonghai. All rights reserved.
//

#import "CLHSecondViewController.h"
#import "ZFJSegmentedControl.h"
#import "ZJScrollPageView.h"
#import "CLHDisoverViewController.h"
#import "SearchView.h"
#import "PYSearchSuggestionViewController.h"
#import "PYSearchViewController.h"
#import <EncryptedAVPlayerView/EncryptedAVPlayerView.h>
#import "UpImageDownTextView.h"
#define ScreenHeight   [UIScreen mainScreen].bounds.size.height
#define ScreenWidth    [UIScreen mainScreen].bounds.size.width

@interface CLHSecondViewController ()<ZJScrollPageViewDelegate,PYSearchViewControllerDelegate>
@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;
@property (nonatomic, strong) ZJScrollPageView *scrollPageView;

@property (nonatomic, strong) UIView *titleView;




@property (nonatomic, strong) SearchView *searchView;
@property (nonatomic, strong)  NSMutableArray *searchArray;
@property (nonatomic, strong) UIView *selectedView;

@end

@implementation CLHSecondViewController




- (void)viewWillAppear:(BOOL)animated
{
    self.searchView.hidden = NO;
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    self.searchView.hidden = YES;
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.title = @"发现";
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    
    style.segmentHeight = 60;
    style.autoAdjustTitlesWidth = YES;
    style.scrollLineColor = [UIColor color7c4b00];
    style.selectedTitleColor = [UIColor color7c4b00];
    //显示滚动条
    style.showLine = YES;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    self.titles = @[@"诵读",@"讲解",@"书写"];
    // 初始化
    

    _scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    // 额外的按钮响应的block
    __weak typeof(self) weakSelf = self;
    self.scrollPageView.extraBtnOnClick = ^(UIButton *extraBtn){
        weakSelf.title = @"点击了extraBtn";
        NSLog(@"点击了extraBtn");
        
    };
    [self.view addSubview:_scrollPageView];
    
    _scrollPageView.segmentView.backgroundColor = [UIColor coloreeeeee];
    _scrollPageView.backgroundColor =[UIColor coloreeeeee];
    self.searchArray = [NSMutableArray arrayWithCapacity:1];
    
    self.searchView = [[SearchView alloc] initWithFrame:CGRectMake(15, 7, kScreenWidth-30, 30)];
    self.searchView.backgroundColor =[UIColor whiteColor];
    __block typeof(self) sweakSelf = self;
    self.searchView.didSeach = ^(id param) {
        //        [sweakSelf goToSeach];
        [sweakSelf requestSeachData];
        
    };
    [self.navigationController.navigationBar addSubview:self.searchView];

    
    [self addTittleView];
    
    
    
    // Do any additional setup after loading the view.
}
- (void)addTittleView
{
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 58)];
    self.titleView.layer.cornerRadius = 0;
    self.titleView.clipsToBounds = YES;
    
    
    
    UIImageView *cView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, kScreenWidth, 58+64)];
    cView.image = [UIImage imageNamed:@"椭圆D"];
    cView.userInteractionEnabled = YES;
    
    [self.titleView addSubview:cView];
    cView.backgroundColor = [UIColor clearColor];
    cView.layer.cornerRadius = 16;
    cView.clipsToBounds = YES;
    
    
    
    UIView *bView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth-30, 58)];
    [self.titleView addSubview:bView];
    bView.backgroundColor = [UIColor whiteColor];
    bView.layer.cornerRadius = 5;
    bView.clipsToBounds = YES;
    
    NSArray *tittles = @[@"诵读",@"讲解",@"书写"];
    NSArray *icons = @[@"诵读s",@"讲解u",@"书写u"];
    double J_J = (self.titleView.width - 58*3)/4.0;
    for (int i = 0; i < 3; i++) {
        UpImageDownTextView *udView = [[UpImageDownTextView alloc] initWithFrame:CGRectMake(J_J *(i+1) + 58*i, 0,58, 58)];
        udView.tLabel.text = tittles[i];
        udView.img.image = [UIImage imageNamed:icons[i]];
        [self.titleView addSubview:udView];
        udView.tag = 2000 +i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInAction:)];
        [udView addGestureRecognizer:tap];
        
    }
    
    [self.view addSubview:_titleView];
    self.titleView.backgroundColor = [UIColor coloreeeeee];
    
}
- (void)tapInAction:(UITapGestureRecognizer *)tap{
    UpImageDownTextView *udView  = tap.view;
    NSInteger tagValue = udView.tag -2000;

    [self selectedWithIndex:tagValue];
    
}

- (void)selectedWithIndex:(NSInteger)tagValue
{
    
    UpImageDownTextView *udView  = [self.titleView viewWithTag:2000+tagValue];
    NSArray *icons = @[@"诵读u",@"讲解u",@"书写u"];
    for (int i = 0; i < 3; i++) {
        UpImageDownTextView *u  = [self.titleView viewWithTag:2000+i];
        u.img.image = [UIImage imageNamed:icons[i]];
        u.tLabel.textColor = [UIColor color8a8a8a];
    }
    
    NSArray *iconselecteds = @[@"诵读s",@"讲解s",@"书写s"];
    udView.img.image = [UIImage imageNamed:iconselecteds[tagValue]];
    udView.tLabel.textColor = [UIColor colorddbb99];
    [_scrollPageView setSelectedIndex:tagValue animated:YES];
    
    
}
- (void)requestSeachData{
    
    NSDictionary *dict = @{};
    
    [[CLHSessionManager shareManager] requestDataWithPath:[kBaseUrl stringByAppendingString:@"video/getHotSearchWords"] paramsJson:[dict JSONString] method:FBLRequestMethodGet WithCompleteBlock:^(NSMutableDictionary *data, NSError *error, ResultModel *resultModel) {
        NSLog(@"%@___%@__%@__%@",data,resultModel.data,resultModel.success,resultModel.errMessage);
        if ([[NSString stringWithFormat:@"%@",resultModel.success] isEqualToString:@"1"]) {
            self.searchArray = [NSMutableArray arrayWithArray:resultModel.data];
            
            [self goToSeachWithArray: self.searchArray];
            
        }else{
            [self showHint:[NSString stringWithFormat:@"%@",resultModel.errMessage]];
        }
        
        
    }];
    
}


- (void)goToSeachWithArray:(NSArray *)array{
    // 1.创建热门搜索
    NSArray *hotSeaches = array;
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索您喜欢视频" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        
        
        NSLog(@"%@",searchText);
        
        // 如果有搜索文本且显示搜索建议，则隐藏
        //             searchViewController.baseSearchTableView.hidden = searchText.length && !self.searchSuggestionHidden;
        //        // 根据输入文本显示建议搜索条件
        //          searchViewController.searchSuggestionVC.view.hidden = self.searchSuggestionHidden || !searchText.length;
        //        //    // 放在最上层
        //           [searchViewController.view bringSubviewToFront:self.searchSuggestionVC.view];
        
        searchViewController.baseSearchTableView.hidden =YES;
        searchViewController.searchSuggestionVC.view.hidden =NO;
        searchViewController.searchSuggestionVC.searchKeyWord = searchText;
        [searchViewController.view bringSubviewToFront:searchViewController.searchSuggestionVC.view];
        
        
        
        //        [searchViewController.navigationController pushViewController:[[PYTempViewController alloc] init] animated:YES];
    }];
    // 3. 设置风格
    // 选择搜索历史
    searchViewController.hotSearchStyle = PYHotSearchStyleDefault; // 热门搜索风格为默认
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleBorderTag; // 搜索历史风格根据选择
    
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:NO completion:nil];
    
}
#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    
    searchViewController.baseSearchTableView.hidden =NO;
    searchViewController.searchSuggestionVC.view.hidden =YES;
    if (searchText.length) { // 与搜索条件再搜索
        
        
        
        //        NSLog(@"搜索==%@",searchText);
        
        
        // 根据条件发送查询（这里模拟搜索）
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜素完毕
        //            // 显示建议搜索结果
        //            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
        //            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
        //                NSString *searchSuggestion = [NSString stringWithFormat:@"搜索建议 %d", i];
        //                [searchSuggestionsM addObject:searchSuggestion];
        //            }
        //            // 返回
        //          searchViewController.searchSuggestions = searchSuggestionsM;
        //        });
    }
}

- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
    
    
    return NO;
}
- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    

        [self selectedWithIndex:index];
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    if (!childVc) {
        childVc = [[CLHDisoverViewController alloc] initWithOrderType:index];
        
    }

    
    return childVc;
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
