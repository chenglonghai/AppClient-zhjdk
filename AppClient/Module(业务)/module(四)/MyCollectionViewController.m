//
//  MyCollectionViewController.m
//  AppClient
//
//  Created by xinz on 2018/1/9.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyCollectionTableViewCell.h"
#import "SearchModel.h"
#import "PlayVideoViewController.h"
#import "SQCustomButton.h"
#define BW 100
#define KW kScreenWidth/2.0

@interface MyCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) SQCustomButton *leftBtn;
@property (nonatomic, strong) SQCustomButton *rightBtn;
@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, assign) BOOL isEdit;

@property (nonatomic, strong) UIView *bottomView;
@end

@implementation MyCollectionViewController


- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        //        _tableView.estimatedRowHeight = 80.0 ;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyCollectionTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MyCollectionTableViewCell class])];
        
        
        
        
    }
    return _tableView;
}


- (void)requestCollectionVideoData{
    
    NSDictionary *dict = @{@"userId":[UserManager shareManager].userModel.ID};
    
    [[CLHSessionManager shareManager] requestDataWithPath:[kBaseUrl stringByAppendingString:@"video/getCollectVideoList"] paramsJson:[dict JSONString] method:FBLRequestMethodGet WithCompleteBlock:^(NSMutableDictionary *data, NSError *error, ResultModel *resultModel) {
        NSLog(@"%@___%@__%@__%@",data,resultModel.data,resultModel.success,resultModel.errMessage);
        if ([[NSString stringWithFormat:@"%@",resultModel.success] isEqualToString:@"1"]) {
            
            NSArray *arr = [NSArray arrayWithArray:resultModel.data];
            
            for (int i = 0; i < arr.count; i++) {
                NSDictionary *dict =arr[i];
                SearchModel *searchModel = [SearchModel new];
                searchModel.isSelected = NO;
                [searchModel setValuesForKeysWithDictionary:dict];
                [self.dataArray addObject:searchModel];
            }
            [self.tableView reloadData];
            
        }else{
            [self showHint:[NSString stringWithFormat:@"%@",resultModel.errMessage]];
        }
        
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isEdit =NO;
    self.navigationItem.title = @"我的收藏";
    self.dataArray = [NSMutableArray arrayWithCapacity:1];
    [self.view addSubview:self.tableView];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        // make.edges.mas_equalTo(self.view);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(-44);
    }];
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-44-64, kScreenWidth, 44)];
    self.bottomView.backgroundColor = [UIColor coloreeeeee];
    self.bottomView.hidden = YES;
    [self.view addSubview:self.bottomView];
    
    self.leftBtn = [[SQCustomButton alloc]initWithFrame:CGRectMake((KW -BW)/2.0,0,BW,44)
                                                   type:SQCustomButtonLeftImageType
                                              imageSize:CGSizeMake(20, 20) midmargin:10];
    self.leftBtn.isShowSelectBackgroudColor = YES;
    self.leftBtn.imageView.image = [UIImage imageNamed:@"未选中"];
    self.leftBtn.backgroundColor = [UIColor clearColor];
    self.leftBtn.titleLabel.textColor = [UIColor color8a8a8a];
    self.leftBtn.titleLabel.text = @"全选";
    
    [self.leftBtn touchAction:^(SQCustomButton * _Nonnull button) {
        NSLog(@"左图标，左文字");
        if ([self isAllSelected] == YES) {
            [self unselectedAll];
               self.leftBtn.imageView.image = [UIImage imageNamed:@"未选中"];
        }else{
            [self selectedAll];
             self.leftBtn.imageView.image = [UIImage imageNamed:@"选中"];
        }
        
    }];

    self.rightBtn = [[SQCustomButton alloc]initWithFrame:CGRectMake((KW -BW)/2.0 +kScreenWidth/2.0,0,BW,44)
                                                    type:SQCustomButtonLeftImageType
                                               imageSize:CGSizeMake(20, 20) midmargin:10];
    self.rightBtn.isShowSelectBackgroudColor = YES;
    self.rightBtn.imageView.image = [UIImage imageNamed:@"收藏删除"];
    self.rightBtn.backgroundColor = [UIColor clearColor];
    self.rightBtn.titleLabel.text = @"删除";
    self.rightBtn.titleLabel.textColor = [UIColor color8a8a8a];
    [self.rightBtn touchAction:^(SQCustomButton * _Nonnull button) {
        NSLog(@"右图标，左文字");
        [self deleteArray:[self selectedArray]];
    }];
    
    [self.bottomView addSubview:self.leftBtn];
    [self.bottomView addSubview:self.rightBtn];
    
    
    
    
    self.editBtn = [UIButton buttonWithType:UIButtonTypeSystem];
     self.editBtn .frame = CGRectMake(0, 0, 44, 44);
    [ self.editBtn  setTitle:@"编辑" forState:UIControlStateNormal];
     self.editBtn .titleLabel.textColor = [UIColor color8a8a8a];
     self.editBtn .tintColor = [UIColor blackColor];
    
    [ self.editBtn  addTarget:self action:@selector(editContent:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: self.editBtn ];
    
    
    
    [self requestCollectionVideoData];
    // Do any additional setup after loading the view.
}

- (void)editContent:(UIButton *)ed{
    if (self.isEdit == YES) {
        self.isEdit = NO;
          [self.editBtn  setTitle:@"编辑" forState:UIControlStateNormal];
  
        self.bottomView.hidden = YES;
    }else{
        self.isEdit = YES;
             [self.editBtn  setTitle:@"完成" forState:UIControlStateNormal];
         self.bottomView.hidden = NO;
    }
    
    [self.tableView reloadData];


}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    
    return  self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    MyCollectionTableViewCell*cell = [MyCollectionTableViewCell cellWithIndexPath:indexPath];
    cell.searchModel = [self.dataArray objectAtIndex:indexPath.row];
    cell.isEdit = self.isEdit;
    return cell;
    
    
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//    if (section == 0) {
//        
//        
//        
//        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
//        
//  
//        return view1;
//    }
//    return nil;
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 120;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 0;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (self.isEdit == NO) {
        if ([UserManager shareManager].isLogin == YES) {
            
//            PlayVideoViewController *pvvc = [PlayVideoViewController new];
            SearchModel *sm =  [self.dataArray objectAtIndex:indexPath.row];
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
        
    }else{
        SearchModel * searchModel = [self.dataArray objectAtIndex:indexPath.row];
        if (searchModel.isSelected == NO) {
            searchModel.isSelected = YES;
        }else{
           searchModel.isSelected = NO;
        }
        [self.dataArray replaceObjectAtIndex:indexPath.row withObject:searchModel];
        
        BOOL isAll = [self isAllSelected];
        if (isAll == YES) {
            self.leftBtn.imageView.image = [UIImage imageNamed:@"选中"];
        }else{
         self.leftBtn.imageView.image = [UIImage imageNamed:@"未选中"];
        }
        
        [self.tableView reloadData];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (void)selectedAll{
    for (int i = 0; i < self.dataArray.count; i++) {
        SearchModel *searchModel = [self.dataArray objectAtIndex:i];
        searchModel.isSelected = YES;
        [self.dataArray replaceObjectAtIndex:i withObject:searchModel];
    }
    [self.tableView reloadData];
}

- (void)unselectedAll{
    for (int i = 0; i < self.dataArray.count; i++) {
        SearchModel *searchModel = [self.dataArray objectAtIndex:i];
        searchModel.isSelected = NO;
        [self.dataArray replaceObjectAtIndex:i withObject:searchModel];
    }
    [self.tableView reloadData];
}

- (BOOL)isAllSelected{
    BOOL isAll = NO;
    for (int i = 0; i < self.dataArray.count; i++) {
        SearchModel *searchModel = [self.dataArray objectAtIndex:i];
        if (searchModel.isSelected == NO) {
            return NO;
        }else{
            isAll = YES;
        }
    }
    return isAll;
    
}

- (NSMutableArray *)selectedArray{

    NSMutableArray *dataArr = [NSMutableArray arrayWithCapacity:1];
    for (int i = 0; i < self.dataArray.count; i++) {
        SearchModel *searchModel = [self.dataArray objectAtIndex:i];
        if (searchModel.isSelected== YES) {
            [dataArr addObject:searchModel];
        }
    }
    
    return dataArr;
}


- (void)deleteArray:(NSMutableArray *)DArray{

    
    if (DArray.count == 0) {
        [self showHint:@"您未选择收藏"];
        return;
    }

    NSString *ids = @"";
    
    for (int i = 0; i < DArray.count; i++) {
        SearchModel *sm = [self.dataArray objectAtIndex:i];
        if (i == 0) {
            ids = sm.ID;
        }else{
            ids = [ids stringByAppendingString:[NSString stringWithFormat:@",%@",sm.ID]];
        }
       
    }
    
    
    NSDictionary *dict = @{@"userId":[UserManager shareManager].userModel.ID,@"ids":ids};
    
    NSLog(@"%@",dict);
    [[CLHSessionManager shareManager] requestDataWithPath:[kBaseUrl stringByAppendingString:@"video/uncollectBatch"] paramsJson:[dict JSONString] method:FBLRequestMethodGet WithCompleteBlock:^(NSMutableDictionary *data, NSError *error, ResultModel *resultModel) {
        NSLog(@"%@___%@__%@__%@",data,resultModel.data,resultModel.success,resultModel.errMessage);
        if ([[NSString stringWithFormat:@"%@",resultModel.success] isEqualToString:@"1"]) {
            for (SearchModel *ssm in DArray) {
                if ([self.dataArray containsObject:ssm]) {
                    [self.dataArray removeObject:ssm];
                }
            }
            
            [self.tableView reloadData];
            
        }else{
            [self showHint:[NSString stringWithFormat:@"%@",resultModel.errMessage]];
        }
        
        
    }];
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
