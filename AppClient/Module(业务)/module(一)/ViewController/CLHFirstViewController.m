//
//  CLHFirstViewController.m
//  AppClient
//
//  Created by APAPA on 2017/6/27.
//  Copyright © 2017年 Chenlonghai. All rights reserved.
//

#import "CLHFirstViewController.h"
#import "HomeBannerCollectionViewCell.h"
#import "HomeListCollectionViewCell.h"
#import "HomeTittleHeaderCollectionReusableView.h"
#define ITEM_WIDTH   kScreenWidth
#define ITEM_HEIGHT 170
#import "PYSearch.h"
#import "MLBasePageViewController.h"
#import "MoreSubViewController.h"
#import "PYTempViewController.h"
#import "SearchView.h"
#import "PYSearchSuggestionViewController.h"
#import "LunboModel.h"
#import "HomeVideoModel.h"
#import "VideoModel.h"
@interface CLHFirstViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, PYSearchViewControllerDelegate>
@property (nonatomic, strong) SearchView *searchView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *lunboArray;
@property (nonatomic, strong) NSMutableArray *allVideoArray;

@property (nonatomic, strong)  NSMutableArray *searchArray;
@end

     
static NSString *indentifierBannerCollectionViewCell = @"BannerCollectionViewCell";
static NSString *indentifierHomeListCollectionViewCell = @"HomeListCollectionViewCell";
@implementation CLHFirstViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.searchView.hidden = NO;
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
        self.searchView.hidden = YES;
    [super viewWillDisappear:animated];
}

- (void)requestData{

    NSDictionary *dict = @{};
    
    [[CLHSessionManager shareManager] requestDataWithPath:[kBaseUrl stringByAppendingString:@"video/getHomeSimpleVidoList"] paramsJson:[dict JSONString] method:FBLRequestMethodGet WithCompleteBlock:^(NSMutableDictionary *data, NSError *error, ResultModel *resultModel) {
        NSLog(@"%@___%@__%@__%@",data,resultModel.data,resultModel.success,resultModel.errMessage);
        if ([[NSString stringWithFormat:@"%@",resultModel.success] isEqualToString:@"1"]) {
         
            NSArray *rollPicList = [NSArray arrayWithArray:[resultModel.data objectForKey:@"rollPicList"]];
            
         
            for (int i = 0; i < rollPicList.count; i++) {
                NSDictionary *dt  =[rollPicList objectAtIndex:i];
                LunboModel *lbModel = [[LunboModel alloc] init];
                [lbModel setValuesForKeysWithDictionary:dt];
                [self.lunboArray addObject:lbModel];
                
            }
    
            
               NSArray *videoList =[NSArray arrayWithArray:[resultModel.data objectForKey:@"videoList"]];
            for (int i = 0; i < videoList.count; i++) {
                HomeVideoModel *homeVM = [[HomeVideoModel alloc] init];
                [homeVM setValuesForKeysWithDictionary:videoList[i]];
                
                NSMutableArray *explainListArr = [NSMutableArray arrayWithCapacity:1];
                for (int j = 0; j <  homeVM.explainList.count; j++) {
                    VideoModel *vm = [VideoModel new];
                    [vm setValuesForKeysWithDictionary:homeVM.explainList[j]];
                    [explainListArr addObject:vm];
                }
                homeVM.explainListArr = explainListArr;
                
                NSMutableArray *readListArr = [NSMutableArray arrayWithCapacity:1];
                for (int j = 0; j <  homeVM.readList.count; j++) {
                    VideoModel *vm = [VideoModel new];
                    [vm setValuesForKeysWithDictionary:homeVM.readList[j]];
                    [readListArr addObject:vm];
                }
                homeVM.readListArr = readListArr;
                NSMutableArray *writeListArr = [NSMutableArray arrayWithCapacity:1];
                for (int j = 0; j <  homeVM.writeList.count; j++) {
                    VideoModel *vm = [VideoModel new];
                    [vm setValuesForKeysWithDictionary:homeVM.writeList[j]];
                    [writeListArr addObject:vm];
                }
                homeVM.writeListArr = writeListArr;
                
                [self.allVideoArray addObject:homeVM];
                
                
            }
            
              [self.collectionView reloadData];
            
            
            
        }else{
            [self showHint:[NSString stringWithFormat:@"%@",resultModel.errMessage]];
        }
        
        
    }];
}
- (void)viewDidLoad{
    [super viewDidLoad];
  
    
    self.lunboArray = [NSMutableArray arrayWithCapacity:1];
    self.allVideoArray = [NSMutableArray arrayWithCapacity:1];
    self.searchArray = [NSMutableArray arrayWithCapacity:1];
    
    self.searchView = [[SearchView alloc] initWithFrame:CGRectMake(15, 7, kScreenWidth-30, 30)];
    self.searchView.backgroundColor =[UIColor whiteColor];
    __block typeof(self) sweakSelf = self;
    self.searchView.didSeach = ^(id param) {
//        [sweakSelf goToSeach];
        [sweakSelf requestSeachData];
        
    };
    [self.navigationController.navigationBar addSubview:self.searchView];
    
    [self createCollectionViews];
    
    [self requestData];
    
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

#pragma mark -- UICollectionView
- (void)createCollectionViews
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64 ) collectionViewLayout:layout];
    
    
    self.collectionView.backgroundColor = [UIColor coloreeeeee];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
    self.collectionView.backgroundColor = [UIColor coloreeeeee];
    
    [self.collectionView registerClass:[HomeBannerCollectionViewCell class] forCellWithReuseIdentifier:indentifierBannerCollectionViewCell];
    [self.collectionView registerClass:[HomeListCollectionViewCell class] forCellWithReuseIdentifier:indentifierHomeListCollectionViewCell];
         [self.collectionView registerClass:[HomeTittleHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeTittleHeaderCollectionReusableView"];
    
    
    [self.view addSubview:_collectionView];

}





- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if (indexPath.section  == 0) {
        return CGSizeMake(kScreenWidth,   kScreenWidth * 9 / 16 + 10);
    }else{
     
        return CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
    }
    
}

//通过区的位置来确定区高度
- (CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    if (section== 0) {
             return CGSizeMake([UIScreen mainScreen].bounds.size.width,0);
    }

        
        return CGSizeMake([UIScreen mainScreen].bounds.size.width,60);

}
//页眉的设置
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //设置页眉
    HomeTittleHeaderCollectionReusableView *  goodsListHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeTittleHeaderCollectionReusableView" forIndexPath:indexPath];
    HomeVideoModel *homeVM = [self.allVideoArray objectAtIndex:indexPath.section-1];
    goodsListHeaderView.tLabel.text = homeVM.sumNumName;
    


    return goodsListHeaderView;

}

#pragma mark -- UICollectionViewDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
   
    return 1+ self.allVideoArray.count;
    
}
//定义每个Section的四边间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 15, 0, 15);//分别为上、左、下、右
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if (indexPath.section == 0) {
        
        HomeBannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentifierBannerCollectionViewCell forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.lunboArray = self.lunboArray;
        
        return cell;
        
    }
    
    HomeListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentifierHomeListCollectionViewCell forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor clearColor];
    
    HomeVideoModel *homePageModel = [self.allVideoArray objectAtIndex:indexPath.section - 1];
    if (indexPath.row == 0) {
        cell.tLabel.text = @"诵读";
        cell.icon.image=[UIImage imageNamed:@"诵读"];
        cell.dataArray = homePageModel.readListArr;
    }
    if (indexPath.row == 1) {
        cell.tLabel.text = @"讲解";
           cell.icon.image=[UIImage imageNamed:@"讲解"];
        cell.dataArray = homePageModel.explainListArr;
    }
    if (indexPath.row == 2) {
        cell.tLabel.text = @"书写";
           cell.icon.image=[UIImage imageNamed:@"书写"];
        cell.dataArray = homePageModel.writeListArr;
    }
    cell.lookMore = ^(NSInteger index) {
        
//        NSLog(@"_____________________更多");
        MLBasePageViewController *mvc = [MLBasePageViewController new];
        mvc.navigationItem.title = [NSString stringWithFormat:@"%@",homePageModel.sumNumName];
        MoreSubViewController *oneVC =[MoreSubViewController new];
              oneVC.sumNum = homePageModel.sumNum;
              oneVC.stage = @"1";
        MoreSubViewController *twoVC =[MoreSubViewController new];
                twoVC.sumNum = homePageModel.sumNum;
               twoVC.stage = @"2";
        MoreSubViewController *threeVC =[MoreSubViewController new];
           threeVC.sumNum = homePageModel.sumNum;
        threeVC.stage = @"3";
        MoreSubViewController *fourVC =[MoreSubViewController new];
            fourVC.sumNum = homePageModel.sumNum;
          fourVC.stage = @"4";
        mvc.VCArray = @[oneVC, twoVC, threeVC, fourVC];
        mvc.sectionTitles = @[@"1-25期", @"26-50期", @"51-75期", @"76-100期"];
//        mvc.navigationItem.title = @"中华经典资源库第一期";
        [self.navigationController pushViewController:mvc animated:YES];
    };
    
    return cell;
    
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
