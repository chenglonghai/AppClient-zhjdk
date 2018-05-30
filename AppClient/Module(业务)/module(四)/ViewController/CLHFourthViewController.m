//
//  CLHFourthViewController.m
//  AppClient
//
//  Created by APAPA on 2017/6/27.
//  Copyright © 2017年 Chenlonghai. All rights reserved.
//

#import "CLHFourthViewController.h"
#import "MeItemCollectionViewCell.h"
#import "MeHeaderCollectionReusableView.h"
#import "LineCollectionReusableView.h"
#import "MyCollectionViewController.h"
#import "AdviceViewController.h"
#import "PersonInfoViewController.h"
#define ITEM_WIDTH   kScreenWidth-30
#define ITEM_HEIGHT 55
@interface CLHFourthViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *iconArray;
@property (nonatomic, strong) NSArray *tittleArray;

@end


static NSString *indentifierMeItemCollectionViewCell = @"MeItemCollectionViewCell";
static NSString *indentifierLineCollectionReusableView = @"LineCollectionReusableView";
@implementation CLHFourthViewController
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
      [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
        self.navigationController.navigationBar.hidden = NO;
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
 
    self.tittleArray = @[@[@"我的收藏",@"意见反馈",@"客服电话",@"消息通知"]];
    [self createCollectionViews];
    
}


#pragma mark -- UICollectionView
- (void)createCollectionViews
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-44 ) collectionViewLayout:layout];
    
    
    self.collectionView.backgroundColor = [UIColor coloreeeeee];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
    self.collectionView.backgroundColor = [UIColor coloreeeeee];
    
    [self.collectionView registerClass:[MeItemCollectionViewCell class] forCellWithReuseIdentifier:indentifierMeItemCollectionViewCell];

    [self.collectionView registerClass:[MeHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MeHeaderCollectionReusableView"];
    [self.collectionView registerClass:[LineCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LineCollectionReusableView"];
    
    [self.view addSubview:_collectionView];
    
}





- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    

        
        return CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
    
    
}

//通过区的位置来确定区高度
- (CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    if (section== 0) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width,200);
    }
    
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width,15);
    
}
//页眉的设置
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //设置页眉
    
    
    if (indexPath.section == 0) {
        MeHeaderCollectionReusableView *  meHeaderCollectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MeHeaderCollectionReusableView" forIndexPath:indexPath];
        
        
        if ([[UserManager shareManager].userModel.picUrl hasPrefix:@"http"]) {
                   [meHeaderCollectionReusableView.icon sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@",[UserManager shareManager].userModel.picUrl]]];
        }else{
        [meHeaderCollectionReusableView.icon sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",kBaseUrl,[UserManager shareManager].userModel.picUrl]]];
        }
        meHeaderCollectionReusableView.nameLabel.text = [NSString stringWithFormat:@"%@",[UserManager shareManager].userModel.nickname];
        meHeaderCollectionReusableView.didGo = ^(id param) {
            PersonInfoViewController *ps = [PersonInfoViewController new];
            [self.navigationController pushViewController:ps animated:YES];
        };
        return meHeaderCollectionReusableView;
    }
    LineCollectionReusableView *  lineCollectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LineCollectionReusableView" forIndexPath:indexPath];
    return lineCollectionReusableView;
 
}

#pragma mark -- UICollectionViewDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    return 0;
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
    
    
    

        
        MeItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentifierMeItemCollectionViewCell forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor clearColor];
        
        cell.tLabel.text = [self.tittleArray[indexPath.section] objectAtIndex:indexPath.row];
        cell.icon.image = [UIImage imageNamed:[self.tittleArray[indexPath.section] objectAtIndex:indexPath.row]];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.arrowhead.hidden = NO;
            cell.phoneLabel.hidden = YES;
        }
        if (indexPath.row == 1) {
            cell.arrowhead.hidden = NO;
                   cell.phoneLabel.hidden = YES;
        }
        if (indexPath.row == 2) {
            
                   cell.phoneLabel.hidden = NO;
            cell.arrowhead.hidden = YES;
            
   
            
        }
    }
    
        return cell;
 
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MyCollectionViewController *myCollectionViewController = [MyCollectionViewController new];
            [self.navigationController pushViewController:myCollectionViewController animated:YES];
        }
        if (indexPath.row == 1) {
            AdviceViewController *adVC = [AdviceViewController new];
            [self.navigationController pushViewController:adVC animated:YES];
        }
        
        if (indexPath.row == 2) {
        //拨打电话
            NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"01052368952"];
        
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
        }
    }
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
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
