//
//  代码地址: https://github.com/iphone5solo/PYSearch
//  代码地址: http://www.code4app.com/thread-11175-1-1.html
//  Created by CoderKo1o.
//  Copyright © 2016年 iphone5solo. All rights reserved.
//

#import "PYSearchSuggestionViewController.h"
#import "PYSearchConst.h"
#import "SearchResultTableViewCell.h"
#import "SearchModel.h"
#import "PlayVideoViewController.h"

@interface PYSearchSuggestionViewController ()
@property (nonatomic, strong) NSMutableArray *searchData;

@end

@implementation PYSearchSuggestionViewController

+ (instancetype)searchSuggestionViewControllerWithDidSelectCellBlock:(PYSearchSuggestionDidSelectCellBlock)didSelectCellBlock
{
    PYSearchSuggestionViewController *searchSuggestionVC = [[PYSearchSuggestionViewController alloc] init];
    searchSuggestionVC.didSelectCellBlock = didSelectCellBlock;
    return searchSuggestionVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.searchData = [NSMutableArray arrayWithCapacity:1];
    
    // 取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

//       [self.tableView reloadData];
}



- (void)setSearchKeyWord:(NSString *)searchKeyWord
{
    if (_searchKeyWord != searchKeyWord) {
        _searchKeyWord = searchKeyWord;
    }
    
    [self requestSearchDataWithKeyword:_searchKeyWord];
}

- (void)requestSearchDataWithKeyword:(NSString *)keyword{
    NSDictionary *dict = @{@"title":keyword};
    
    [[CLHSessionManager shareManager] requestDataWithPath:[kBaseUrl stringByAppendingString:@"video/searchVideoByTitle"] paramsJson:[dict JSONString] method:FBLRequestMethodGet WithCompleteBlock:^(NSMutableDictionary *data, NSError *error, ResultModel *resultModel) {
        NSLog(@"%@___%@__%@__%@",data,resultModel.data,resultModel.success,resultModel.errMessage);
        if ([[NSString stringWithFormat:@"%@",resultModel.success] isEqualToString:@"1"]) {
//            self.searchArray = [NSMutableArray arrayWithArray:resultModel.data];
            NSArray *resultArray = [NSArray arrayWithArray:resultModel.data];
            for (int i = 0; i < resultArray.count; i++) {
                NSDictionary *dict = resultArray[i];
           SearchModel *searchModel = [SearchModel new];
                [searchModel setValuesForKeysWithDictionary:dict];
                
                [self.searchData addObject:searchModel];
                
            
            }
            [self.tableView reloadData];
//
//            [self goToSeachWithArray: self.searchArray];
            
        }else{
            [self showHint:[NSString stringWithFormat:@"%@",resultModel.errMessage]];
        }
        
        
    }];

}

- (void)setSearchSuggestions:(NSArray<NSString *> *)searchSuggestions
{
//    _searchSuggestions = [searchSuggestions copy];
//    
//    // 刷新数据
//    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInSearchSuggestionView:)]) {
//        return [self.dataSource numberOfSectionsInSearchSuggestionView:tableView];
//    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if ([self.dataSource respondsToSelector:@selector(searchSuggestionView:numberOfRowsInSection:)]) {
//        return [self.dataSource searchSuggestionView:tableView numberOfRowsInSection:section];
//    }
//    return self.searchSuggestions.count;
    return self.searchData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    // 使用默认的搜索建议Cell
    static NSString *cellID = @"PYSearchSuggestionCellID";
    // 创建cell
    SearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (!cell) {
        cell = [[SearchResultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];

    }
    
    cell.searchModel = [self.searchData objectAtIndex:indexPath.row];
    // 设置数据

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([self.dataSource respondsToSelector:@selector(searchSuggestionView:heightForRowAtIndexPath:)]) {
//        return [self.dataSource searchSuggestionView:tableView heightForRowAtIndexPath:indexPath];
//    }
    return 120.0;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.didSelectCellBlock) self.didSelectCellBlock([tableView cellForRowAtIndexPath:indexPath]);
    
    if ([UserManager shareManager].isLogin == YES) {
        
//        PlayVideoViewController *pvvc = [PlayVideoViewController new];
          SearchModel *sm =  [self.searchData objectAtIndex:indexPath.row];
//        pvvc.videoID = sm.ID;
//        [self.navigationController pushViewController:pvvc animated:YES];
        
        NSLog(@"______%@",[FRObjectToDictionary getObjectData:sm]);
        
        
        
        
        
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
    
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
