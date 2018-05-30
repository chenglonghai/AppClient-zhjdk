//
//  CLHDisoverViewController.m
//  AppClient
//
//  Created by xinz on 2018/1/7.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "CLHDisoverViewController.h"
#import "SingleListCollectionViewCell.h"
#import "DetailHomeCollectionReusableView.h"
#import "PlayVideoViewController.h"
#import "VideoModel.h"
@interface CLHDisoverViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger _contentType;
    
}

@property (nonatomic, strong) UICollectionView *listColectionView;
@property (nonatomic, strong) NSString *sumNum;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end
static NSString *indentifierSingleListCollectionViewCell = @"SecSingleListCollectionViewCell";

static NSInteger page = 1;
static NSInteger totalCount = 0;
@implementation CLHDisoverViewController



//下拉刷新
- (void)pulldownRefresh
{
    
    // 下拉刷新
    self.listColectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        [self requestData];
        
    }];
    
    
    [self.listColectionView.mj_header beginRefreshing];
    
    
}
//刷新数据
- (void)requestData{
    
    page = 1;
    
    [self requestDataWithSumNum:self.sumNum pageNum:[NSString stringWithFormat:@"%ld",page]];
    
    
    
    
}


//下载更多
- (void)loadMoreData
{
    page = page + 1;
    
    [self requestLoadMoreDataWithSumNum:self.sumNum pageNum:[NSString stringWithFormat:@"%ld",page]];
}

// 上拉刷新
- (void)pullUpRefresh
{
    self.listColectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        
        [self loadMoreData];
    }];
    
    
}

- (void)requestDataWithSumNum:(NSString *)sumNum pageNum:(NSString *)pageNum{
    
    [self.dataArray removeAllObjects];
    NSDictionary *dict = @{@"pageNum":pageNum,@"pageSize":@"10",@"contentType":[NSString stringWithFormat:@"%ld",_contentType]};
    NSLog(@"___%@",dict);
    
    [[CLHSessionManager shareManager] requestDataWithPath:[kBaseUrl stringByAppendingString:@"video/getDiscoverVideos"] paramsJson:[dict JSONString] method:FBLRequestMethodGet WithCompleteBlock:^(NSMutableDictionary *data, NSError *error, ResultModel *resultModel) {
        NSLog(@"%@___%@__%@__%@",data,resultModel.data,resultModel.success,resultModel.errMessage);
        if ([[NSString stringWithFormat:@"%@",resultModel.success] isEqualToString:@"1"]) {
            
            totalCount = [[resultModel.data objectForKey:@"totalCount"] integerValue];
            NSArray *videoInfoVOList = [NSArray arrayWithArray:[resultModel.data objectForKey:@"videoInfoVOList"]];
            for (int i = 0; i <videoInfoVOList.count ; i++) {
                NSDictionary *dict = videoInfoVOList[i];
                VideoModel *videoModel = [VideoModel new];
                [videoModel setValuesForKeysWithDictionary:dict];
                [self.dataArray addObject:videoModel];
            }
            
            [self.listColectionView reloadData];
            
            if (totalCount <= self.dataArray.count) {
                [self.listColectionView.mj_header endRefreshing];
               [self.listColectionView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.listColectionView.mj_header endRefreshing];
                [self.listColectionView.mj_footer endRefreshing];
            }
            
        }else{
            [self showHint:[NSString stringWithFormat:@"%@",resultModel.errMessage]];
            [self.listColectionView.mj_header endRefreshing];
            [self.listColectionView.mj_footer endRefreshing];
        }
        
        
    }];

}


- (void)requestLoadMoreDataWithSumNum:(NSString *)sumNum pageNum:(NSString *)pageNum{
    NSDictionary *dict = @{@"pageNum":pageNum,@"pageSize":@"10",@"contentType":[NSString stringWithFormat:@"%ld",_contentType]};
    
    [[CLHSessionManager shareManager] requestDataWithPath:[kBaseUrl stringByAppendingString:@"video/getDiscoverVideos"] paramsJson:[dict JSONString] method:FBLRequestMethodGet WithCompleteBlock:^(NSMutableDictionary *data, NSError *error, ResultModel *resultModel) {
        NSLog(@"%@___%@__%@__%@",data,resultModel.data,resultModel.success,resultModel.errMessage);
        if ([[NSString stringWithFormat:@"%@",resultModel.success] isEqualToString:@"1"]) {
            
            totalCount = [[resultModel.data objectForKey:@"totalCount"] integerValue];
            NSArray *videoInfoVOList = [NSArray arrayWithArray:[resultModel.data objectForKey:@"videoInfoVOList"]];
            for (int i = 0; i <videoInfoVOList.count ; i++) {
                NSDictionary *dict = videoInfoVOList[i];
                VideoModel *videoModel = [VideoModel new];
                [videoModel setValuesForKeysWithDictionary:dict];
                [self.dataArray addObject:videoModel];
            }
            
            [self.listColectionView reloadData];
            
            if (totalCount <= self.dataArray.count) {
                [self.listColectionView.mj_header endRefreshing];
                [self.listColectionView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.listColectionView.mj_header endRefreshing];
                [self.listColectionView.mj_footer endRefreshing];
            }
            
        }else{
            [self showHint:[NSString stringWithFormat:@"%@",resultModel.errMessage]];
            [self.listColectionView.mj_header endRefreshing];
            [self.listColectionView.mj_footer endRefreshing];
        }
        
        
    }];
    
}
- (instancetype)initWithOrderType:(NSInteger )type{
    
    self = [super init];
    if (self) {
        if (type == 0) {
            _contentType = 1;
            self.sumNum = @"106";
        }
        if (type == 1) {
            _contentType = 2;
            self.sumNum = @"107";
        }
        if (type == 2) {
            _contentType = 3;
            self.sumNum = @"108";
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor coloreeeeee];
    self.dataArray = [NSMutableArray arrayWithCapacity:1];
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake((kScreenWidth-45)/2.0,130);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 15;
    
    self.listColectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-44) collectionViewLayout:layout];
    self.listColectionView.backgroundColor = [UIColor clearColor];
    self.listColectionView.delegate = self;
    self.listColectionView.dataSource = self;
    //    self.listColectionView.scrollsToTop = NO;
    //    self.listColectionView.showsVerticalScrollIndicator = NO;
    //    self.listColectionView.showsHorizontalScrollIndicator = NO;
    [self.listColectionView registerClass:[SingleListCollectionViewCell class] forCellWithReuseIdentifier:indentifierSingleListCollectionViewCell];
    [self.listColectionView registerClass:[DetailHomeCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DetailHomeCollectionReusableView"];
    [self.view addSubview:self.listColectionView];
    
    [self pullUpRefresh];
    [self pulldownRefresh];
    // Do any additional setup after loading the view.
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((kScreenWidth-45)/2.0, 130);
    
}

//通过区的位置来确定区高度
- (CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width,15);
    
}
//页眉的设置
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //设置页眉
    DetailHomeCollectionReusableView *  detailHomeCollectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DetailHomeCollectionReusableView" forIndexPath:indexPath];
    
    
    return detailHomeCollectionReusableView;
    
}

#pragma mark -- UICollectionViewDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
    
}
//定义每个Section的四边间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //    if (section == 0) {
    //        return UIEdgeInsetsMake(0, 0, 0, 0);
    //    }
    return UIEdgeInsetsMake(0, 15, 0, 15);//分别为上、左、下、右
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    SingleListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentifierSingleListCollectionViewCell forIndexPath:indexPath];
    //    cell.contentView.backgroundColor = [UIColor yellowColor];
    cell.videoModel = [self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([UserManager shareManager].isLogin == YES) {
        
//        PlayVideoViewController *pvvc = [PlayVideoViewController new];
       VideoModel *vm = [self.dataArray objectAtIndex:indexPath.row];
//        pvvc.videoID = vm.ID;
//        [self.navigationController pushViewController:pvvc animated:YES];
        
        
        
        
        
        
        NSDictionary *downloadDic = [NSString dictionaryWithJsonString:vm.attribute];
        NSString *sku = [NSString stringWithFormat:@"%@",  [downloadDic objectForKey:@"downloadUrl"]];
        NSString *memId = [NSString stringWithFormat:@"%@", [[UserManager shareManager].userModel.utoken objectForKey:@"primary"] ];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[FRObjectToDictionary getObjectData:vm]];
        NSLog(@"%@", dict);
        id message = [NSString isExistVideoList:vm.ID];
        
        if ([message isKindOfClass:[NSString class]]) {
            if ([message isEqualToString:@"下载中"]) {
                [self showHint:@"已经在下载中列表"];
            }else{
                [self showVideoDownloadChoiceWithSku:sku sign:[NSString getSign:[[UIDevice currentDevice].identifierForVendor UUIDString] ]  memId:memId blockProperty:^(NSString * url) {
                    SLDownLoadModel *model1 = [[SLDownLoadModel alloc]init];
                    model1.resourceID = [NSString stringWithFormat:@"%@",vm.ID];
                    model1.downLoadUrlStr = url;
                    model1.thumbnailUrlStr = vm.picUrl;
                    model1.title = vm.title;
                    model1.sku = sku;
                    NSString *cachePath = [ [SLFileManager getDownloadRootDir] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",model1.resourceID] ];
                    model1.resumeDataPath = cachePath;
                    [SLDownLoadQueue addDownLoadTaskWithModel:model1];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self showHint:@"已添加下载列表"];
                    });
                }];
            }
            
        }else{
            SLDownLoadModel *model = ( SLDownLoadModel *)message;
            PlayVideoViewController *pvvc = [[PlayVideoViewController alloc] init];
            pvvc.model = model;
            
            [self.navigationController pushViewController:pvvc animated:YES];
        }

        
        
        
        
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    }else{
    
    LoginViewController *loginController = [[LoginViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginController];
    [self presentViewController:nav animated:YES completion:nil];
    }
    
 
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
