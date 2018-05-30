//
//  RegisterDetailViewController.m
//  AppClient
//
//  Created by xinz on 2018/1/7.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "RegisterDetailViewController.h"
#import "DPPhotoGroupViewController.h"
#import "HandeData.h"

@interface RegisterDetailViewController ()<UINavigationControllerDelegate,DPPhotoGroupViewControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIImageView *photoImg;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UITextField *nicknameTF;
@property (weak, nonatomic) IBOutlet UIImageView *mesIcon;
@property (weak, nonatomic) IBOutlet UILabel *mesWordLabel;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *cameraBg;
@property (nonatomic, strong) UIImage *uploadImg;

@end

@implementation RegisterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.uploadImg = nil;
    // Do any additional setup after loading the view from its nib.
    
    [self addViews];
    
 
}
- (void)addViews{
   [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.view).offset(10);
       make.top.equalTo(self.view).offset(20);
       make.size.mas_equalTo(CGSizeMake(44, 44));
   }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backBtn.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(15);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth *0.4, 75));
    }];
    self.label1.font = [UIFont boldSystemFontOfSize:15.0f];
    self.label1.textColor = [UIColor color7c4b00];
    self.cameraBg.contentMode  = UIViewContentModeScaleAspectFill;
    self.cameraBg.clipsToBounds = YES;
    [self.cameraBg setContentScaleFactor:[[UIScreen mainScreen] scale]];
    
    UITapGestureRecognizer *tap1  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(IMAGE:)];
    [self.cameraBg addGestureRecognizer:tap1];
    [self.cameraBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backBtn.mas_bottom).offset(20);
        make.right.equalTo(self.view).offset(-15);
        make.size.mas_equalTo(CGSizeMake(75, 75));
    }];

    
    [self.photoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backBtn.mas_bottom).offset(20+15);
        make.right.equalTo(self.view).offset(-30);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    
    self.photoImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(IMAGE:)];
    [self.photoImg addGestureRecognizer:tap];
    
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label1.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(15);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth *0.4, 30));
    }];
    self.nickName.font = [UIFont boldSystemFontOfSize:15.0f];
    self.nickName.textColor = [UIColor color7c4b00];
    
    
    
    [self.nicknameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickName.mas_bottom).offset(5);
        make.left.equalTo(self.view).offset(15);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth -30, 30));
    }];
    
    
    self.nicknameTF.font = [UIFont boldSystemFontOfSize:28.0f];
    self.nicknameTF.placeholder = @"请输入您的昵称";
    self.nicknameTF.keyboardType = UIKeyboardTypeASCIICapable;
    UIImageView *lineView = [[UIImageView alloc] init];
        lineView.backgroundColor = [UIColor colorddbb99];
        [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(self.nicknameTF.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake( kScreenWidth -30, 0.5));

    }];


    
    
    [self.mesIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];

    [self.mesWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(15);
        make.left.equalTo(self.mesIcon.mas_right).offset(15);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth *0.8, 20));
    }];
    self.mesWordLabel.font = [UIFont systemFontOfSize:15.0f];
    
    [self.completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo( self.mesWordLabel.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(15);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth -30, 40));
    }];
    self.completeBtn.layer.cornerRadius = 5;
    self.completeBtn.backgroundColor = [UIColor colorddbb99];
    self.completeBtn.tintColor = [UIColor whiteColor];
    
    [self.completeBtn addTarget:self action:@selector(complete:) forControlEvents:UIControlEventTouchUpInside];
}
// --10
- (void)complete:(UIButton *)btn{
    
    [self.nicknameTF resignFirstResponder];
    if (self.uploadImg == nil) {
        [self showHint:@"请上传头像"];
        return;
    }
    
    
    if ([self.nicknameTF.text isEqualToString:@""]) {
        [self showHint:@"昵称不为空"];
        return;
    }
    
    [self completeRegister];

}

//w
- (void)completeRegister{
    NSDictionary *dict = @{@"id":self.userid,@"nickname":self.nicknameTF.text};
    
    [[CLHSessionManager shareManager] requestDataWithPath:[kBaseUrl stringByAppendingString:@"user/updateUser"] paramsJson:[dict JSONString] method:FBLRequestMethodGet WithCompleteBlock:^(NSMutableDictionary *data, NSError *error, ResultModel *resultModel) {
        NSLog(@"___%@__%@__%@",resultModel.data,resultModel.success,resultModel.errMessage);
        if ([[NSString stringWithFormat:@"%@",resultModel.success] isEqualToString:@"1"]) {
           
            [self showHint:@"完成注册"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [self showHint:[NSString stringWithFormat:@"%@",resultModel.errMessage]];
        }
        
        
    }];
}

- (void)IMAGE:(UITapGestureRecognizer *)tap{
    [self select_action];
}
- (IBAction)pop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
        self.cameraBg.image = self.uploadImg;
        self.photoImg.hidden = YES;
        
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
        self.cameraBg.image = self.uploadImg;
        self.photoImg.hidden = YES;
        
        [self uploadImage:self.uploadImg];
        
    }
    
   
    //添加的
    
    
    
    
    
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    
}

//- (void)uploadImage:(UIImage *)img{
//    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{@"id":self.userid}];
//    [HandeData pictureHttpPostRequest:[kBaseUrl stringByAppendingString:@"user/updateUser"] WithFormdata:dict WithSuccess:^(ResultModel *response) {
//        
//        NSLog(@"xxxxxxxxxxxx%@xxxxxxxx%@xxxxxx%@",response.data,response.errCode, response.success);
//        
//    } failure:^(NSError *error) {
//        
//    } image:img avatarPicture:@"picUrl"];
//    
//    
//    
//    
//    
//    
//
//}




- (void)uploadImage:(UIImage *)img{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{@"id":self.userid}];
    [HandeData pictureHttpPostRequest:[kBaseUrl stringByAppendingString:@"fileUpload/upload"] WithFormdata:dict WithSuccess:^(ResultModel *response) {
             NSLog(@"xxxxxxxxxxxx%@xxxxxxxx%@xxxxxx%@",response.data,response.errCode, response.success);
        if ([[NSString stringWithFormat:@"%@",response.success] isEqualToString:@"1"]) {
//            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary: [[UserManager shareManager] getLocalUserInfo]];
//            [dict setObject:[NSString stringWithFormat:@"%@",response.data] forKey:@"picUrl"];
//            [[UserManager shareManager] saveUserInfo:dict];
//            
//            
//            [UserManager shareManager].userModel.picUrl = [NSString stringWithFormat:@"%@",response.data];
            [self updatePicUrl:[NSString stringWithFormat:@"%@",response.data]];
        }else{
            
            
            
            [self showHint:@"更换失败"];
        }
        
        
    } failure:^(NSError *error) {
        [self showHint:@"更换失败"];
        
        
    } image:img avatarPicture:@"file"];
    
}

- (void)updatePicUrl:(NSString *)picUrl{
    NSDictionary *dict = @{@"picUrl":picUrl,@"id":self.userid};
    
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
