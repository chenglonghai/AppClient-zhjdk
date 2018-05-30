//
//  DownloadedViewController.m
//  AppClient
//
//  Created by xinz on 2018/1/8.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "DownloadedViewController.h"
#import "DownloadedTableViewCell.h"


#import "SQCustomButton.h"
#define BW 100
#define KW kScreenWidth/2.0
#import "DownLoadModel.h"
#import "HSDownloadManager.h"
#import "PlayBendiVideoViewController.h"
@interface DownloadedViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *view1;

@property (nonatomic, strong) SQCustomButton *leftBtn;
@property (nonatomic, strong) SQCustomButton *rightBtn;

@property (nonatomic, strong) SQCustomButton *editBtn;
@property (nonatomic, strong) NSMutableArray *downloadedArray;
@property (nonatomic, strong) NSMutableArray *downloadModelArray;
@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, assign) BOOL isAllSelected;



@end

@implementation DownloadedViewController

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        //        _tableView.estimatedRowHeight = 80.0 ;
        _tableView.backgroundColor = [UIColor coloreeeeee];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DownloadedTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([DownloadedTableViewCell class])];
        
        
        
        
    }
    return _tableView;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.downloadedArray = [NSMutableArray arrayWithArray:[[UserManager shareManager] getCompleteVideoVieoListArray]];
    
    [self.downloadModelArray removeAllObjects];
    
    for (int i = 0; i <self.downloadedArray.count ; i++) {
        NSDictionary *ddict = [self.downloadedArray objectAtIndex:i];
        DownLoadModel *downloadModel = [[DownLoadModel alloc] init];
        downloadModel.isSelected = NO;
        [downloadModel setValuesForKeysWithDictionary:ddict];
        
        [self.downloadModelArray addObject:downloadModel];
    }
    self.isEdit = NO;
    [self.tableView reloadData];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    
    self.isAllSelected = NO;
    self.downloadModelArray = [NSMutableArray arrayWithCapacity:1];
    self.leftBtn = [[SQCustomButton alloc]initWithFrame:CGRectMake(15,5,BW,30)
                                                   type:SQCustomButtonLeftImageType
                                              imageSize:CGSizeMake(20, 20) midmargin:10];
    self.leftBtn.isShowSelectBackgroudColor = NO;
    self.leftBtn.imageView.image = [UIImage imageNamed:@"椭圆8"];
    self.leftBtn.backgroundColor = [UIColor clearColor];
    self.leftBtn.titleLabel.textColor = [UIColor color8a8a8a];
    self.leftBtn.titleLabel.text = @"全选";
    
    [self.leftBtn touchAction:^(SQCustomButton * _Nonnull button) {
        NSLog(@"左图标，左文字");
        
        if (_isAllSelected == NO) {
            _isAllSelected = YES;
                self.leftBtn.imageView.image = [UIImage imageNamed:@"组155"];
            for (int i = 0; i < self.downloadModelArray.count; i++) {
                DownLoadModel *downloadModel = [self.downloadModelArray objectAtIndex:i];
                downloadModel.isSelected = YES;
                [self.downloadModelArray replaceObjectAtIndex:i withObject:downloadModel];
            }
        }else{
             self.leftBtn.imageView.image = [UIImage imageNamed:@"椭圆8"];
           _isAllSelected = NO;
            for (int i = 0; i < self.downloadModelArray.count; i++) {
                DownLoadModel *downloadModel = [self.downloadModelArray objectAtIndex:i];
                downloadModel.isSelected = NO;
                [self.downloadModelArray replaceObjectAtIndex:i withObject:downloadModel];
            }
        }
        
    
        [self.tableView reloadData];
        
        
    }];
    
    self.rightBtn = [[SQCustomButton alloc]initWithFrame:CGRectMake((kScreenWidth-BW-15),5,BW,30)
                                                    type:SQCustomButtonLeftImageType
                                               imageSize:CGSizeMake(20, 20) midmargin:10];
    self.rightBtn.isShowSelectBackgroudColor = YES;
    self.rightBtn.imageView.image = [UIImage imageNamed:@"删除拷贝"];
    self.rightBtn.backgroundColor = [UIColor clearColor];
    self.rightBtn.titleLabel.text = @"删除下载";
    self.rightBtn.titleLabel.textColor = [UIColor color8a8a8a];
    [self.rightBtn touchAction:^(SQCustomButton * _Nonnull button) {
        NSMutableArray *allModles = [NSMutableArray arrayWithArray:self.downloadModelArray];
       
        for (int i = 0; i < allModles.count; i++) {
             DownLoadModel *downloadModel = [allModles objectAtIndex:i];
            if (downloadModel.isSelected == YES) {
                [[UserManager shareManager] removeVieo:[self.downloadedArray objectAtIndex:i]];
                NSString *downloadUrl = [NSString stringWithFormat:@"%@",downloadModel.videoUrl];
                [[HSDownloadManager sharedInstance] deleteFile:downloadUrl];
                [self.downloadedArray removeObjectAtIndex:i];
                [self.downloadModelArray removeObjectAtIndex:i];
            }
            
        }
        
        self.isEdit = NO;
        [self.tableView reloadData];
    }];
    

    self.editBtn = [[SQCustomButton alloc]initWithFrame:CGRectMake((kScreenWidth-100-15),5,100,30)
                                                    type:SQCustomButtonLeftImageType
                                               imageSize:CGSizeMake(20, 20) midmargin:10];
    self.editBtn.isShowSelectBackgroudColor = YES;
    self.editBtn.imageView.image = [UIImage imageNamed:@"sett"];
    self.editBtn.backgroundColor = [UIColor clearColor];
    self.editBtn.titleLabel.text = @"编辑";
    self.editBtn.titleLabel.textColor = [UIColor color8a8a8a];
    [self.editBtn touchAction:^(SQCustomButton * _Nonnull button) {
        NSLog(@"编辑");
        
        if (_isEdit == NO) {
            _isEdit = YES;

        }else{
            _isEdit = NO;
        }
           [self.tableView reloadData];
    }];
    
    self.view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    
    [self.view1 addSubview:self.leftBtn];
    [self.view1 addSubview:self.rightBtn];
    [self.view1 addSubview:self.editBtn];
    self.isEdit = NO;
    self.view1.backgroundColor = [UIColor coloreeeeee];
    
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        // make.edges.mas_equalTo(self.view);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    // Do any additional setup after loading the view.
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    
    return  self.downloadModelArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    DownloadedTableViewCell*cell = [DownloadedTableViewCell cellWithIndexPath:indexPath];
    cell.downloadModel = [self.downloadModelArray objectAtIndex:indexPath.row];
    
    cell.didSelect = ^(DownLoadModel *dm) {
        if (dm.isSelected == NO) {
            dm.isSelected  = YES;
        }else{
          dm.isSelected  = NO;
        }
       [self.downloadModelArray replaceObjectAtIndex:indexPath.row withObject:dm];
        [self.tableView reloadData];
        
    };
    cell.isEdit = self.isEdit;
    
    return cell;
    
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        
        
//        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
//      
//        [view1 addSubview:self.leftBtn];
//        [view1 addSubview:self.rightBtn];
//        view1.backgroundColor = [UIColor coloreeeeee];
        if (self.isEdit == NO) {
            self.leftBtn.hidden = YES;
            self.rightBtn.hidden = YES;
            self.editBtn.hidden = NO;
        }else{
        
            self.leftBtn.hidden = NO;
            self.rightBtn.hidden = NO;
            self.editBtn.hidden = YES;
        }
        
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, kScreenWidth, 0.5)];
        lineView.backgroundColor = [UIColor colorcecece];
        [self.view1 addSubview:lineView];
        return self.view1;
    }
    return nil;
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    }
    return 0;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PlayBendiVideoViewController *pbdvc = [[PlayBendiVideoViewController alloc] init];
   DownLoadModel *downloadModel =  [self.downloadModelArray objectAtIndex:indexPath.row];

    
    NSLog(@"=-=========%@",[[HSDownloadManager sharedInstance] saveLocalUrl:downloadModel.videoUrl]);
    pbdvc.videoUrl = downloadModel.videoUrl;
    
    [self.parentViewController.navigationController pushViewController:pbdvc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
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
