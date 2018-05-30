//
//  HomeListCollectionViewCell.m
//  AppClient
//
//  Created by xinz on 2017/12/28.
//  Copyright © 2017年 Chenlonghai. All rights reserved.
//

#import "HomeListCollectionViewCell.h"
#import "SingleListCollectionViewCell.h"
#import "PlayVideoViewController.h"

@interface HomeListCollectionViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *listColectionView;
@end
static NSString *indentifierSingleListCollectionViewCell = @"SingleListCollectionViewCell";
@implementation HomeListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){

        [self setupUI];
    }
    return self;
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    if (_dataArray != dataArray) {
        _dataArray = dataArray;
    }
    [self.listColectionView reloadData];
    
    
}
- (void)setupUI{
  
    self.icon = [[UIImageView alloc] init];
    [self.contentView addSubview:self.icon];
    
    self.tLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.tLabel];
    

    
    
    
    
    
    
    self.icon.backgroundColor = [UIColor yellowColor];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(15);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    
    self.icon.image = [UIImage imageNamed:@"诵读"];
    self.icon.contentMode = UIViewContentModeScaleAspectFit;
    
    
    self.tLabel.backgroundColor = [UIColor clearColor];
    self.tLabel.font = [UIFont systemFontOfSize:14.0f];
    self.tLabel.text = @"朗诵";
    self.tLabel.textAlignment = NSTextAlignmentLeft;
    self.tLabel.textColor = [UIColor color333333];
    [self.tLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(5);
        make.top.equalTo(self.contentView).offset(0);
        make.size.mas_equalTo(CGSizeMake(150, 15));
    }];
    
    
    
    
    self.moreBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.moreBtn.frame = CGRectMake(kScreenWidth-35, 0, 20, 20);
    [self.moreBtn setBackgroundImage:[UIImage imageNamed:@"更多拷贝2"] forState:UIControlStateNormal];

    [self.moreBtn addTarget:self action:@selector(more:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.moreBtn];
    
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake((kScreenWidth-45)/2.0,130);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 15;
    
    self.listColectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,  20, kScreenWidth,150) collectionViewLayout:layout];
    self.listColectionView.backgroundColor = [UIColor clearColor];
    self.listColectionView.delegate = self;
    self.listColectionView.dataSource = self;
    self.listColectionView.scrollsToTop = NO;
    self.listColectionView.showsVerticalScrollIndicator = NO;
    self.listColectionView.showsHorizontalScrollIndicator = NO;
    [self.listColectionView registerClass:[SingleListCollectionViewCell class] forCellWithReuseIdentifier:indentifierSingleListCollectionViewCell];
    [self.contentView addSubview:self.listColectionView];

    

    
    
}

- (void)more:(UIButton *)moreBtn{
  
    NSLog(@"更多");
    self.lookMore(nil);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

        return CGSizeMake((kScreenWidth-45)/2.0, 130);

}

//通过区的位置来确定区高度
//- (CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    
//
//        return CGSizeMake([UIScreen mainScreen].bounds.size.width,0);
//    
//}
//页眉的设置
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    //设置页眉
//    HomeTittleHeaderCollectionReusableView *  goodsListHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeTittleHeaderCollectionReusableView" forIndexPath:indexPath];
//    goodsListHeaderView.tLabel.text = @"中华经典资源库第五期";
//    
//    return goodsListHeaderView;
//    
//}

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
    cell.videoModel = [self.dataArray objectAtIndex:indexPath.row];
//    cell.contentView.backgroundColor = [UIColor yellowColor];
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([UserManager shareManager].isLogin == YES) {
        
//        PlayVideoViewController *pvvc = [PlayVideoViewController new];
         VideoModel *vm = [self.dataArray objectAtIndex:indexPath.row];
//        pvvc.videoID = vm.ID;
//        [self.viewController.navigationController pushViewController:pvvc animated:YES];
//        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        
//     [self.viewController.navigationController pushViewController:[PlayVideoNowViewController new] animated:YES];
        
        
        NSDictionary *downloadDic = [NSString dictionaryWithJsonString:vm.attribute];
        NSString *sku = [NSString stringWithFormat:@"%@",  [downloadDic objectForKey:@"downloadUrl"]];
        NSString *memId = [NSString stringWithFormat:@"%@", [[UserManager shareManager].userModel.utoken objectForKey:@"primary"] ];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[FRObjectToDictionary getObjectData:vm]];
        id message = [NSString isExistVideoList:vm.ID];
       
        if ([message isKindOfClass:[NSString class]]) {
            if ([message isEqualToString:@"下载中"]) {
                [self.viewController showHint:@"已经在下载中列表"];
            }else{
                [self.viewController showVideoDownloadChoiceWithSku:sku sign:[NSString getSign:[[UIDevice currentDevice].identifierForVendor UUIDString] ]  memId:memId blockProperty:^(NSString * url) {
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
                        [self.viewController showHint:@"已添加下载列表"];
                    });
                }];
            }
            
        }else{
            SLDownLoadModel *model = ( SLDownLoadModel *)message;
            PlayVideoViewController *pvvc = [[PlayVideoViewController alloc] init];
            pvvc.model = model;
            
            [self.viewController.navigationController pushViewController:pvvc animated:YES];
        }

    }else{
        
        LoginViewController *loginController = [[LoginViewController alloc] init];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginController];
        [self.viewController presentViewController:nav animated:YES completion:nil];
    }
}



@end
