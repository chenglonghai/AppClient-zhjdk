//
//  PlayVideoViewController.m
//  AppClient
//
//  Created by xinz on 2018/1/10.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "PlayVideoViewController.h"
#import "RecommdCollectionReusableView.h"
#import "PlayVideoCollectionViewCell.h"
#import "DownloadDetailCollectionViewCell.h"
#import "RecommdVideoCollectionViewCell.h"

#import "EmptyCollectionReusableView.h"
#import "CLPlayerView.h"
#import "DetailVideo.h"
#import "SearchModel.h"

@interface PlayVideoViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    PlayVideoCollectionViewCell * _cell;
    DetailVideo *_detailVideo;
    NSDictionary *_currentViewDict;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) PlayVideoView *playerView;
@property (nonatomic, strong) NSMutableArray *recommendListArray;

@end

static NSString *indentierPlayVideoCollectionViewCell = @"PlayVideoCollectionViewCell";
static NSString *indentierDownloadDetailCollectionViewCell = @"DownloadDetailCollectionViewCell";
static NSString *indentierRecommdVideoCollectionViewCell = @"RecommdVideoCollectionViewCell";



@implementation PlayVideoViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
       self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"视频详情";
    _detailVideo= nil;
    _currentViewDict = nil;
    self.recommendListArray= [NSMutableArray arrayWithCapacity:1];
    
    [self createCollectionViews];
//
//    UIButton *button = [self buttonWithTitle:nil
//                                       image:[UIImage imageNamed:@"top-back"]
//                            highLightedImage:nil];
//    [button addTarget:self
//               action:@selector(back)
//     forControlEvents:UIControlEventTouchUpInside];
//    button.frame = CGRectMake(10, 20, 44, 44);
//    [self.view addSubview:button];
//    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[FRObjectToDictionary getObjectData:self.model]];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[FRObjectToDictionary getObjectData:self.model]];
    NSArray *keysArray = [dict allKeys];
    for (NSString *key  in keysArray) {
        id obj = dict[key];
        if ([obj isKindOfClass:[NSNull class]] || obj == nil ) {
            obj = @"";
        }
        [dict setObject:obj forKey:key];
    }
    [[UserManager shareManager] savePlayVideo:dict];
    [self requestVideoDataWithID:self.model.resourceID];
    
}


//下载
- (void)downloadVideoDataWithID:(NSString *)ID downCell:(DownloadDetailCollectionViewCell *)downCel{
    

    
    NSDictionary *dict = @{@"id":ID,@"userId":[UserManager shareManager].userModel.ID};
    
    [[CLHSessionManager shareManager] requestDataWithPath:[kBaseUrl stringByAppendingString:@"video/downloadVideo"] paramsJson:[dict JSONString] method:FBLRequestMethodGet WithCompleteBlock:^(NSMutableDictionary *data, NSError *error, ResultModel *resultModel) {
        NSLog(@"%@___%@__%@__%@",data,resultModel.data,resultModel.success,resultModel.errMessage);
        if ([[NSString stringWithFormat:@"%@",resultModel.success] isEqualToString:@"1"]) {
            if(_currentViewDict != nil){
                
               BOOL isSave =  [[UserManager shareManager] saveVieoList:_currentViewDict];
                downCel.leftBtn.imageView.image = [UIImage imageNamed:@"已视频下载"];
                if (isSave == YES) {
              
                    [self showHint:@"加入下载列表成功"];
                }else{
                    [self showHint:@"已加入下载过了"];
                }
                
            }
        }else{
//            [self showHint:[NSString stringWithFormat:@"%@",resultModel.errMessage]];
        }
        
        
    }];
    
}




//收藏
- (void)collectionVideoDataWithID:(NSString *)ID{
    
    NSString *collectStatus = [NSString stringWithFormat:@"%@",_detailVideo.collectStatus];
    bool isCollect = false;
    if ([collectStatus isEqualToString:@"1"]) {
        isCollect = false;
    }else{
        isCollect = true;
    }

    NSDictionary *dict = @{@"id":ID,@"userId":[UserManager shareManager].userModel.ID,@"isLike":@(isCollect)};
    
    [[CLHSessionManager shareManager] requestDataWithPath:[kBaseUrl stringByAppendingString:@"video/likeAndCollect"] paramsJson:[dict JSONString] method:FBLRequestMethodGet WithCompleteBlock:^(NSMutableDictionary *data, NSError *error, ResultModel *resultModel) {
        NSLog(@"%@___%@__%@__%@",data,resultModel.data,resultModel.success,resultModel.errMessage);
        if ([[NSString stringWithFormat:@"%@",resultModel.success] isEqualToString:@"1"]) {
            if (isCollect == true){
            _detailVideo.collectStatus = @"1";
                [self showHint:@"收藏成功"];
            }else{
            _detailVideo.collectStatus = @"0";
                     [self showHint:@"收藏失败"];
            }
            [self.collectionView reloadData];
            
        }else{
            [self showHint:[NSString stringWithFormat:@"%@",resultModel.errMessage]];
        }
        
        
    }];
    
}








- (void)requestVideoDataWithID:(NSString *)ID{
    
    NSDictionary *dict = @{@"id":ID,@"userId":[UserManager shareManager].userModel.ID};
    
    [[CLHSessionManager shareManager] requestDataWithPath:[kBaseUrl stringByAppendingString:@"video/getVideoDetail"] paramsJson:[dict JSONString] method:FBLRequestMethodGet WithCompleteBlock:^(NSMutableDictionary *data, NSError *error, ResultModel *resultModel) {
        NSLog(@"%@___%@__%@__%@",data,resultModel.data,resultModel.success,resultModel.errMessage);
        if ([[NSString stringWithFormat:@"%@",resultModel.success] isEqualToString:@"1"]) {
           
            NSDictionary *videoDict = [resultModel.data objectForKey:@"video"];
            
//            [[UserManager shareManager] savePlayVideo:videoDict];
            _currentViewDict = videoDict;
            _detailVideo = [[DetailVideo alloc] init];
            
            [_detailVideo setValuesForKeysWithDictionary:videoDict];
            NSArray *recommendList = [NSMutableArray arrayWithArray:[resultModel.data objectForKey:@"recommendList"]];
            for (int i = 0; i < recommendList.count; i++) {
                NSDictionary *dict = recommendList[i];
                SearchModel *searchModel = [[SearchModel alloc] init];
                [searchModel setValuesForKeysWithDictionary:dict];
                
                [self.recommendListArray addObject:searchModel];
            }
            [self.collectionView reloadData];
            
            
        }else{
            [self showHint:[NSString stringWithFormat:@"%@",resultModel.errMessage]];
        }
        
        
    }];
    
}
- (void)back{
//    [_playerView destroyPlayer];
    _playerView = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- UICollectionView
- (void)createCollectionViews
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(0, 0);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing =0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
    
    
    self.collectionView.backgroundColor = [UIColor coloreeeeee];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
    self.collectionView.backgroundColor = [UIColor coloreeeeee];
    
    [self.collectionView registerClass:[PlayVideoCollectionViewCell class] forCellWithReuseIdentifier:indentierPlayVideoCollectionViewCell];
    [self.collectionView registerClass:[DownloadDetailCollectionViewCell class] forCellWithReuseIdentifier:indentierDownloadDetailCollectionViewCell];
    
        [self.collectionView registerClass:[RecommdVideoCollectionViewCell class] forCellWithReuseIdentifier:indentierRecommdVideoCollectionViewCell];
    [self.collectionView registerClass:[RecommdCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RecommdCollectionReusableView"];
    
       [self.collectionView registerClass:[EmptyCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"EmptyCollectionReusableView"];
    [self.view addSubview:_collectionView];
    
}





- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if (indexPath.section  == 0) {
        return CGSizeMake(kScreenWidth,   kScreenWidth * 9 / 16 + 10);
    }else if(indexPath.section == 1){
        double cH = 0;
        if (_detailVideo != nil) {
            cH =  _detailVideo.cellHeight;
        }
            return CGSizeMake(kScreenWidth,   (70 + cH + 50));
    }else{
        
        return CGSizeMake(kScreenWidth, 100);
    }
    
}

//通过区的位置来确定区高度
- (CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    if (section== 0 || section == 1) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width,0);
    }
    
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width,40);
    
}
//页眉的设置
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 || indexPath.section == 1) {
        EmptyCollectionReusableView*  emptyCollectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"EmptyCollectionReusableView" forIndexPath:indexPath];
        return emptyCollectionReusableView;
    }
    //设置页眉
     RecommdCollectionReusableView*  recommdCollectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RecommdCollectionReusableView" forIndexPath:indexPath];

    
    return recommdCollectionReusableView;
    
}

#pragma mark -- UICollectionViewDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 1;
    }
    return self.recommendListArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 3;
    
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
        
        PlayVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentierPlayVideoCollectionViewCell forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        if (_detailVideo != nil) {
            [cell.icon sd_setImageWithURL:[NSURL URLWithString:_detailVideo.picUrl]];
            
            [self cl_tableViewCellPlayVideoWithCell:cell];
        }
        
        return cell;
        
    }
    if (indexPath.section == 1) {
        
        DownloadDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentierDownloadDetailCollectionViewCell forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        if (_detailVideo != nil) {
            cell.detailVideo = _detailVideo;
        }
        [cell.leftBtn touchAction:^(SQCustomButton * _Nonnull button) {
            [self downloadVideoDataWithID:self.model.resourceID downCell:cell];
        }];
        [cell.rightBtn touchAction:^(SQCustomButton * _Nonnull button) {
         
            //点击收藏
            [self collectionVideoDataWithID:self.model.resourceID];
        }];
        
        return cell;
        
    }
    RecommdVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentierRecommdVideoCollectionViewCell forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.searchModel = [self.recommendListArray objectAtIndex:indexPath.row];
    
    
    return cell;
 
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 2) {
        if ([UserManager shareManager].isLogin == YES) {
            
//            PlayVideoViewController *pvvc = [PlayVideoViewController new];
            SearchModel *sm =  [self.recommendListArray objectAtIndex:indexPath.row];
            
            
//            pvvc.videoID = sm.ID;
//            [self.navigationController pushViewController:pvvc animated:YES];
            
            
            
            
            
            NSDictionary *downloadDic = [NSString dictionaryWithJsonString:sm.attribute];
            NSString *sku = [NSString stringWithFormat:@"%@",  [downloadDic objectForKey:@"downloadUrl"]];
            NSString *memId = [NSString stringWithFormat:@"%@", [[UserManager shareManager].userModel.utoken objectForKey:@"primary"] ];
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[FRObjectToDictionary getObjectData:sm]];
            id message = [NSString isExistVideoList:sm.ID];
            
            if ([message isKindOfClass:[NSString class]]) {
                if ([message isEqualToString:@"下载中"]) {
                    [self showHint:@"已经在下载中列表"];
                }else{
                    [self showVideoDownloadChoiceWithSku:sku sign:[NSString getSign:[[UIDevice currentDevice].identifierForVendor UUIDString] ]  memId:memId blockProperty:^(NSString * url) {
                        SLDownLoadModel *model1 = [[SLDownLoadModel alloc]init];
                        model1.resourceID = [NSString stringWithFormat:@"%@",sm.ID];
                        model1.downLoadUrlStr = url;
                        model1.thumbnailUrlStr = sm.picUrl;
                        model1.title = sm.title;
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
            
            
            
            
            
            
            
            
            
        }else{
            
            LoginViewController *loginController = [[LoginViewController alloc] init];
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginController];
            [self presentViewController:nav animated:YES completion:nil];
        }
    }
    

    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}
#pragma mark - 点击播放代理
- (void)cl_tableViewCellPlayVideoWithCell:(PlayVideoCollectionViewCell *)cell{
    //记录被点击的Cell
    _cell = cell;
    //销毁播放器
//    [_playerView destroyPlayer];
//    CLPlayerView *playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(0, 0, cell.contentView.width, cell.contentView.height)];
//    _playerView = playerView;
    
   self.playerView = [[PlayVideoView alloc] initWithFrame:CGRectMake(0, 0,cell.contentView.width, cell.contentView.height)];
    
  
    
    
    [cell.contentView addSubview:_playerView];
    _playerView.filePath = self.model.resumeDataPath;
    _playerView.sku = self.model.sku;
    
    _playerView.returnClicked_b = ^(BOOL isFullScreen) {
        NSLog(@"____%d", isFullScreen);
        
        if (isFullScreen == NO) {
            
            [_playerView destroyPlayView];
            
                _playerView = nil;
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    };
    
    
    [_playerView loadVideo];;
    //视频地址
//    _playerView.url = [NSURL URLWithString:_detailVideo.videoUrl];
//    //播放
//    [_playerView playVideo];
//    //返回按钮点击事件回调
//    [_playerView backButton:^(UIButton *button) {
//        NSLog(@"返回按钮被点击");
//    }];
//    //播放完成回调
//    [_playerView endPlay:^{
//        //销毁播放器
//        [_playerView destroyPlayer];
//        _playerView = nil;
//        _cell = nil;
//        NSLog(@"播放完成");
//    }];
}
- (void)dealloc
{
//    [_playerView destroyPlayer];
    _playerView = nil;
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
