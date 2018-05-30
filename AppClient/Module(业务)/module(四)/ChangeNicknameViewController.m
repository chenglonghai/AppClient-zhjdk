//
//  ChangeNicknameViewController.m
//  AppClient
//
//  Created by xinz on 2018/1/13.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "ChangeNicknameViewController.h"

@interface ChangeNicknameViewController ()
@property (weak, nonatomic) IBOutlet UIView *bg;
@property (weak, nonatomic) IBOutlet UILabel *tLabel;
@property (weak, nonatomic) IBOutlet UITextField *ntf;

@end

@implementation ChangeNicknameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改昵称";
    self.view.backgroundColor = [UIColor coloreeeeee];
    // Do any additional setup after loading the view from its nib.
    [self customUI];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    saveBtn.frame = CGRectMake(0, 0, 44, 44);
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.textColor = [UIColor color8a8a8a];
    saveBtn.tintColor = [UIColor blackColor];
    
    [saveBtn addTarget:self action:@selector(savenickname:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    
}
- (void)savenickname:(UIButton *)btn{

    if ([self.ntf.text isEqualToString:@""]) {
        [self showHint:@"修改昵称不为空"];
        return;
    }
        
        NSDictionary *dict = @{@"nickname":self.ntf.text,@"id":[UserManager shareManager].userModel.ID};
        
        [[CLHSessionManager shareManager] requestDataWithPath:[kBaseUrl stringByAppendingString:@"user/updateUser"] paramsJson:[dict JSONString] method:FBLRequestMethodGet WithCompleteBlock:^(NSMutableDictionary *data, NSError *error, ResultModel *resultModel) {
            NSLog(@"___%@__%@__%@",resultModel.data,resultModel.success,resultModel.errMessage);
            if ([[NSString stringWithFormat:@"%@",resultModel.success] isEqualToString:@"1"]) {
                [self showHint:@"修改成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (self.didComplete) {
                        self.didComplete(nil);
                        
                    }
                    
                    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary: [[UserManager shareManager] getLocalUserInfo]];
                    [dict setObject:[NSString stringWithFormat:@"%@",self.ntf.text] forKey:@"nickname"];
                    [[UserManager shareManager] saveUserInfo:dict];
                    
                    
                    [UserManager shareManager].userModel.nickname = [NSString stringWithFormat:@"%@",self.ntf.text];
                    [self.navigationController popViewControllerAnimated:YES];
                    
                });
                
            }else{
                [self showHint:[NSString stringWithFormat:@"%@",resultModel.errMessage]];
            }
            
            
        }];

}

- (void)customUI{
    
    
    self.bg.backgroundColor = [UIColor whiteColor];
    [self.bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(5);
        make.right.equalTo(self.view).offset(0);
        make.height.equalTo(@45);
    }];
    
    self.tLabel.textColor = [UIColor color333333];
    self.tLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bg).offset(15);
        make.top.bottom.equalTo(self.bg).offset(0);
        make.width.equalTo(@60);
    }];
    self.ntf.font = [UIFont systemFontOfSize:14.0f];
    self.ntf.text = [UserManager shareManager].userModel.nickname;
  
    [self.ntf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tLabel.mas_right).offset(10);
        make.top.equalTo(self.bg).offset(5);
         make.bottom.equalTo(self.bg).offset(-5);
        make.width.equalTo(@150);
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
