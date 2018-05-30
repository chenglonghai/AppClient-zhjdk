//
//  PlayBendiVideoViewController.m
//  AppClient
//
//  Created by xinz on 2018/1/20.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "PlayBendiVideoViewController.h"
#import "CLPlayerView.h"
#import "PlayVideoCollectionViewCell.h"
@interface PlayBendiVideoViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
     PlayVideoCollectionViewCell * _cell;
}
@property (nonatomic, weak) CLPlayerView *playerView;
@property (nonatomic, strong) UICollectionView *collectionView;
@end
static NSString *indentierPlayVideoCollectionViewCell = @"PlayVideoCollectionViewCell";
@implementation PlayBendiVideoViewController

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
    self.navigationItem.title = @"播放本地视频";
       [self createCollectionViews];
    
    UIButton *button = [self buttonWithTitle:nil
                                       image:[UIImage imageNamed:@"top-back"]
                            highLightedImage:nil];
    [button addTarget:self
               action:@selector(back)
     forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(10, 20, 44, 44);
    [self.view addSubview:button];
    
    

    
}

- (void)back{
    [_playerView destroyPlayer];
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
  
    [self.view addSubview:_collectionView];
    
}





- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    

        return CGSizeMake(kScreenWidth,   kScreenWidth * 9 / 16 + 10);

    
}

//通过区的位置来确定区高度
- (CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
 
        return CGSizeMake([UIScreen mainScreen].bounds.size.width,0);
  
    
}
//页眉的设置
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    
//    if (indexPath.section == 0 || indexPath.section == 1) {
//        EmptyCollectionReusableView*  emptyCollectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"EmptyCollectionReusableView" forIndexPath:indexPath];
//        return emptyCollectionReusableView;
//    }
//    //设置页眉
//    RecommdCollectionReusableView*  recommdCollectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RecommdCollectionReusableView" forIndexPath:indexPath];
//    
//    
//    return recommdCollectionReusableView;
//    
//}

#pragma mark -- UICollectionViewDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
 
        return 1;
    
  
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
    
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
    
    
   
        
        PlayVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentierPlayVideoCollectionViewCell forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
    
            
            [self cl_tableViewCellPlayVideoWithCell:cell];

        return cell;
        

    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    

    
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}
#pragma mark - 点击播放代理
- (void)cl_tableViewCellPlayVideoWithCell:(PlayVideoCollectionViewCell *)cell{
    //记录被点击的Cell
    _cell = cell;
    //销毁播放器
    [_playerView destroyPlayer];
    CLPlayerView *playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(0, 0, cell.contentView.width, cell.contentView.height)];
    _playerView = playerView;
    [cell.contentView addSubview:_playerView];
    //视频地址
//    NSData *videoData = [[NSData alloc] initWithContentsOfFile:self.videoUrl];
    
    _playerView.fileUrl = [NSURL URLWithString:self.videoUrl];
    //播放
    [_playerView playVideo];
    //返回按钮点击事件回调
    [_playerView backButton:^(UIButton *button) {
        NSLog(@"返回按钮被点击");
    }];
    //播放完成回调
    [_playerView endPlay:^{
        //销毁播放器
        [_playerView destroyPlayer];
        _playerView = nil;
        _cell = nil;
        NSLog(@"播放完成");
    }];
}
- (void)dealloc
{
    [_playerView destroyPlayer];
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
