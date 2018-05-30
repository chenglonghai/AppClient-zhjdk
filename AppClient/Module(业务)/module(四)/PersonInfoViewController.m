//
//  PersonInfoViewController.m
//  AppClient
//
//  Created by xinz on 2018/1/10.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "PhotoTableViewCell.h"
#import "InfoListTableViewCell.h"
#import "ChangePasswordViewController.h"
#import "DPPhotoGroupViewController.h"
#import "HandeData.h"
#import "ChangeNicknameViewController.h"
@interface PersonInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,DPPhotoGroupViewControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImage *uploadImg;
@property (nonatomic, strong) NSArray *tArray;


@end

@implementation PersonInfoViewController


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
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PhotoTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([PhotoTableViewCell class])];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([InfoListTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([InfoListTableViewCell class])];
        
        
        
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.uploadImg = nil;
    self.navigationItem.title = @"个人资料";
    [self.view addSubview:self.tableView];
    self.tArray = @[@"头像",@"昵称",@"性别",@"修改密码"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        // make.edges.mas_equalTo(self.view);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    submitBtn.frame = CGRectMake(15, kScreenHeight -64-44-30, kScreenWidth-30, 44);
    [submitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = 5;
    submitBtn.clipsToBounds = YES;
    submitBtn.titleLabel.textColor = [UIColor whiteColor];
    submitBtn.tintColor = [UIColor whiteColor];
    submitBtn.backgroundColor = [UIColor colorddbb99];
    [submitBtn addTarget:self action:@selector(outLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    // Do any additional setup after loading the view.
}
- (void)outLogin:(UIButton *)outLogin{
           [[UserManager shareManager] cleanUserInfo];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    
    return   self.tArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
        PhotoTableViewCell*cell = [PhotoTableViewCell cellWithIndexPath:indexPath];
        
        if ([[UserManager shareManager].userModel.picUrl hasPrefix:@"http"]) {
            [cell.photo  sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@",[UserManager shareManager].userModel.picUrl]]];
        }else{
            [cell.photo  sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",kBaseUrl,[UserManager shareManager].userModel.picUrl]]];
        }
    
        
        NSLog(@"___%@", [UserManager shareManager].userModel.picUrl);
        cell.tLabel.text = [self.tArray objectAtIndex:indexPath.row];
        return cell;
    }


        InfoListTableViewCell*cell = [InfoListTableViewCell cellWithIndexPath:indexPath];
            cell.tLabel.text = [self.tArray objectAtIndex:indexPath.row];
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
    
    if (indexPath.row == 0) {
        return 90;
    }
    
    return 45;
    
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
    
    if (indexPath.row == 0) {
        [self select_action];
    }
    
    if (indexPath.row == 1) {
        ChangeNicknameViewController *cnvc = [ChangeNicknameViewController new];
        cnvc.didComplete = ^(id param) {
            [self.tableView reloadData];
        };
         [self.navigationController pushViewController:cnvc animated:YES];
    }
    if (indexPath.row == 2) {
        [self select_sex_action];
    }
    if (indexPath.row == 3) {
        ChangePasswordViewController *cpVC = [ChangePasswordViewController new];
        
        [self.navigationController pushViewController:cpVC animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)select_action
{
    //  [self upLoadHeadImg:nil];
    NSArray *arr = @[@"拍照",@"相册选择"];
    UIActionSheet*   sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: nil];
    
    sheet.tag = 1010;
    for (NSString *input_text in arr) {
        
        [sheet addButtonWithTitle:input_text];
        
    }
    
    
    [sheet showInView:self.view];
    
    
    
    
}
- (void)select_sex_action
{
    //  [self upLoadHeadImg:nil];
    NSArray *arr = @[@"男",@"女"];
    UIActionSheet*   sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: nil];
    
    sheet.tag = 1011;
    for (NSString *input_text in arr) {
        
        [sheet addButtonWithTitle:input_text];
        
    }
    
    
    [sheet showInView:self.view];
    
    
    
    
}


#pragma mark - sheet的协议方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet.tag == 1010) {
        //相机
        if (buttonIndex == 1) {
            [self takePictures];
        }
        //相册选择
        if (buttonIndex == 2) {
            [self clickShow];
            
        }
        
    }
    if (actionSheet.tag == 1011) {
        //男
        if (buttonIndex == 1) {
            [self resetSex:@"1"];
        }
        //女
        if (buttonIndex == 2) {
                    [self resetSex:@"0"];
            
        }
        
    }
}

- (void)resetSex:(NSString *)sex{
    NSDictionary *dict = @{@"gender":sex,@"id":[UserManager shareManager].userModel.ID};
    
    [[CLHSessionManager shareManager] requestDataWithPath:[kBaseUrl stringByAppendingString:@"user/updateUser"] paramsJson:[dict JSONString] method:FBLRequestMethodGet WithCompleteBlock:^(NSMutableDictionary *data, NSError *error, ResultModel *resultModel) {
        NSLog(@"___%@__%@__%@",resultModel.data,resultModel.success,resultModel.errMessage);
        if ([[NSString stringWithFormat:@"%@",resultModel.success] isEqualToString:@"1"]) {
                [self showHint:@"修改成功"];
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary: [[UserManager shareManager] getLocalUserInfo]];
                [dict setObject:[NSString stringWithFormat:@"%@",sex] forKey:@"gender"];
                [[UserManager shareManager] saveUserInfo:dict];

                [UserManager shareManager].userModel.gender = [NSString stringWithFormat:@"%@",sex];
                  [self.tableView reloadData];
            
        }else{
            [self showHint:[NSString stringWithFormat:@"%@",resultModel.errMessage]];
        }
        
        
    }];


}

#pragma mark - ---------------------- action
- (void)clickShow
{
    
    
    DPPhotoGroupViewController *groupVC = [DPPhotoGroupViewController new];
    
    
    groupVC.maxSelectionCount = 1;
    groupVC.delegate = self;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:groupVC] animated:YES completion:nil];
    
    
}

#pragma mark - ---------------------- DPPhotoGroupViewControllerDelegate
- (void)didSelectPhotos:(NSMutableArray *)photos{
    
    NSLog(@"%@",photos);
    if (photos.count != 0) {
        self.uploadImg = [photos firstObject];

        
        [self uploadImage:self.uploadImg];
    }
    
    
    
}
- (NSInteger)selectedImg{
    
    
    return 1;
}

#pragma mark - 拍照
-(void)takePictures
{
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = sourceType;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
        
        
        
    }else
    {
        NSLog(@"模拟器中无法使用");
    }
}

#pragma mark - 选择图片的响应事件
//对此方法进行修改

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"])
    {
        
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        if (img == nil) {
            img =   [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        }
        
        self.uploadImg = img;
        
    
        
        [self uploadImage:self.uploadImg];
        
    }
    
    
    //添加的
    
    
    
    
    
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    
}

- (void)uploadImage:(UIImage *)img{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{@"id":[UserManager shareManager].userModel.ID}];
    [HandeData pictureHttpPostRequest:[kBaseUrl stringByAppendingString:@"fileUpload/upload"] WithFormdata:dict WithSuccess:^(ResultModel *response) {
//           NSLog(@"xxxxxxxxxxxx%@xxxxxxxx%@xxxxxx%@",response.data,response.errCode, response.success);
         if ([[NSString stringWithFormat:@"%@",response.success] isEqualToString:@"1"]) {
             PhotoTableViewCell*cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
             cell.photo.image = self.uploadImg;
             NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary: [[UserManager shareManager] getLocalUserInfo]];
             [dict setObject:[NSString stringWithFormat:@"%@",response.data] forKey:@"picUrl"];
             [[UserManager shareManager] saveUserInfo:dict];
             
             
             [UserManager shareManager].userModel.picUrl = [NSString stringWithFormat:@"%@",response.data];
             [self updatePicUrl:[UserManager shareManager].userModel.picUrl];
         }else{
             
             
             
                    [self showHint:@"更换失败"];
         }
     
        
    } failure:^(NSError *error) {
           [self showHint:@"更换失败"];
        
        
    } image:img avatarPicture:@"file"];
    
}

- (void)updatePicUrl:(NSString *)picUrl{
    NSDictionary *dict = @{@"picUrl":picUrl,@"id":[UserManager shareManager].userModel.ID};
    
    [[CLHSessionManager shareManager] requestDataWithPath:[kBaseUrl stringByAppendingString:@"user/updateUser"] paramsJson:[dict JSONString] method:FBLRequestMethodGet WithCompleteBlock:^(NSMutableDictionary *data, NSError *error, ResultModel *resultModel) {
        NSLog(@"___%@__%@__%@",resultModel.data,resultModel.success,resultModel.errMessage);
        if ([[NSString stringWithFormat:@"%@",resultModel.success] isEqualToString:@"1"]) {
        [self showHint:@"更换成功"];
       
            
        }else{
            [self showHint:[NSString stringWithFormat:@"%@",resultModel.errMessage]];
        }
        
        
    }];
    
    
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
