//
//  ChangePasswordViewController.m
//  AppClient
//
//  Created by xinz on 2018/1/10.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "FLVerifyButton.h"
@interface ChangePasswordViewController ()
@property (weak, nonatomic) IBOutlet UIView *bg1;
@property (weak, nonatomic) IBOutlet UILabel *plabel;
@property (weak, nonatomic) IBOutlet UITextField *ptf;

@property (weak, nonatomic) IBOutlet UIView *bg2;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UITextField *codetf;
@property (weak, nonatomic) IBOutlet  FLVerifyButton *codeBtn;

@property (weak, nonatomic) IBOutlet UIView *bg3;
@property (weak, nonatomic) IBOutlet UILabel *pnewLabel;
@property (weak, nonatomic) IBOutlet UITextField *pnewtf;

@property (nonatomic, strong) UIButton *nextBtn;
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
    self.view.backgroundColor = [UIColor coloreeeeee];
    // Do any additional setup after loading the view from its nib.
    [self customUI];
}

- (void)customUI{
  
    
    self.bg1.backgroundColor = [UIColor whiteColor];
    [self.bg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(5);
        make.right.equalTo(self.view).offset(0);
        make.height.equalTo(@45);
    }];

    self.plabel.textColor = [UIColor color333333];
    self.plabel.font = [UIFont systemFontOfSize:14.0f];
    [self.plabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bg1).offset(15);
        make.top.bottom.equalTo(self.bg1).offset(0);
        make.width.equalTo(@60);
    }];
    self.ptf.font = [UIFont systemFontOfSize:14.0f];
    self.ptf.placeholder = @"输入电话号码";
        self.ptf.keyboardType = UIKeyboardTypeNumberPad;
    [self.ptf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.plabel.mas_right).offset(10);
        make.top.bottom.equalTo(self.bg1).offset(0);
        make.width.equalTo(@150);
    }];
    
    //二条
    self.bg2.backgroundColor = [UIColor whiteColor];
    [self.bg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.bg1.mas_bottom).offset(0.5);
        make.right.equalTo(self.view).offset(0);
        make.height.equalTo(@45);
    }];
    

    
    self.codeLabel.textColor = [UIColor color333333];
    self.codeLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bg2).offset(15);
        make.top.bottom.equalTo(self.bg2).offset(0);
        make.width.equalTo(@60);
    }];
    self.codetf.font = [UIFont systemFontOfSize:14.0f];
    self.codetf.placeholder = @"输入验证码";
    self.codetf.keyboardType = UIKeyboardTypeNumberPad;
    [self.codetf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.codeLabel.mas_right).offset(10);
        make.top.bottom.equalTo(self.bg2).offset(0);
        make.width.equalTo(@100);
    }];
    
    
    self.codeBtn.font = [UIFont systemFontOfSize:14.0f];
    [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.codeBtn.countDownTime = 90;
    self.codeBtn.verifyCountDownCompete = ^{
        NSLog(@"%s",__func__);
    };
    self.codeBtn.backgroundColor = [UIColor colorddbb99];
    self.codeBtn.layer.cornerRadius = 5;
    self.codeBtn.clipsToBounds = YES;
    self.codeBtn.tintColor = [UIColor whiteColor];
    [self.codeBtn addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bg2).offset(-10);
        make.centerY.equalTo(self.bg2).offset(0);
        make.size.mas_equalTo(CGSizeMake(85, 30));
    }];
    
    
    
    
    
    //三条
    self.bg3.backgroundColor = [UIColor whiteColor];
    [self.bg3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.bg2.mas_bottom).offset(0.5);
        make.right.equalTo(self.view).offset(0);
        make.height.equalTo(@45);
    }];

    self.pnewLabel.textColor = [UIColor color333333];
    self.pnewLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.pnewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bg3).offset(15);
        make.top.bottom.equalTo(self.bg3).offset(0);
        make.width.equalTo(@60);
    }];
    self.pnewtf.font = [UIFont systemFontOfSize:14.0f];
    self.pnewtf.placeholder = @"输入新密码";
    self.pnewtf.keyboardType = UIKeyboardTypeASCIICapable;
    self.pnewtf.secureTextEntry = YES;
    [self.pnewtf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pnewLabel.mas_right).offset(10);
        make.top.bottom.equalTo(self.bg3).offset(0);
        make.width.equalTo(@150);
    }];
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view  addSubview:self.nextBtn];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(37);
        make.top.equalTo(self.pnewtf.mas_bottom).offset(40);
        make.right.equalTo(self.view).offset(-37);
        make.height.equalTo(@44);
    }];
    [self.nextBtn addTarget:self action:@selector(completeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.nextBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.nextBtn setTintColor:[UIColor whiteColor]];
    self.nextBtn.backgroundColor = [UIColor colorddbb99];
    self.nextBtn.userInteractionEnabled = YES;
    self.nextBtn.layer.cornerRadius = 5;
    self.nextBtn.clipsToBounds = YES;
}

- (void)completeAction:(UIButton *)btn{
    [self cancalKeyBorad];
    
    if(![NSString validateMobile:self.ptf.text]){
        [self showHint:@"请输入正确的电话号码"];
        return;
    }
    if (self.pnewtf.text.length <6|| self.pnewtf.text.length > 20) {
        [self showHint:@"密码为6-20位数字或英文组成"];
        return;
    }
    if([self.codetf.text isEqualToString:@""]   ){
        [self showHint:@"验证码不为空"];
        return;
    }
    
    NSDictionary *dict = @{@"phone":self.ptf.text,@"password":self.pnewtf.text,@"id":[UserManager shareManager].userModel.ID,@"smsCode":self.codetf.text};
    
    [[CLHSessionManager shareManager] requestDataWithPath:[kBaseUrl stringByAppendingString:@"user/updateUser"] paramsJson:[dict JSONString] method:FBLRequestMethodGet WithCompleteBlock:^(NSMutableDictionary *data, NSError *error, ResultModel *resultModel) {
        NSLog(@"___%@__%@__%@",resultModel.data,resultModel.success,resultModel.errMessage);
        if ([[NSString stringWithFormat:@"%@",resultModel.success] isEqualToString:@"1"]) {
            [self showHint:@"修改成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
  
            });
            
        }else{
            [self showHint:[NSString stringWithFormat:@"%@",resultModel.errMessage]];
        }
        
        
    }];
}

- (void)sendCode:(UIButton *)codeBtn{
    [self cancalKeyBorad];
    
    if(![NSString validateMobile:self.ptf.text]){
        [self showHint:@"请输入正确的电话号码"];
        return;
    }
    
    [self sendVerificationCode:self.ptf.text];
}
- (void)cancalKeyBorad{
    [self.ptf resignFirstResponder];
    [self.codetf resignFirstResponder];
    [self.pnewtf resignFirstResponder];
}
- (void)sendVerificationCode:(NSString *)phone{
    
    NSDictionary *dict = @{@"phone":phone,@"type":@"1"};
    
    [[CLHSessionManager shareManager] requestDataWithPath:[kBaseUrl stringByAppendingString:@"user/sendVerificationCode"] paramsJson:[dict JSONString] method:FBLRequestMethodGet WithCompleteBlock:^(NSMutableDictionary *data, NSError *error, ResultModel *resultModel) {
        NSLog(@"___%@__%@__%@",resultModel.data,resultModel.success,resultModel.errMessage);
        if ([[NSString stringWithFormat:@"%@",resultModel.success] isEqualToString:@"1"]) {
            [self.codeBtn startTime];
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
