//
//  ForgetPasswordViewController.m
//  AppClient
//
//  Created by xinz on 2018/1/7.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ICON_TEXT.h"
#import "FLVerifyButton.h"

@interface ForgetPasswordViewController ()
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIImageView *lgView;

@property (nonatomic, strong) UILabel *tLabel;

@property (nonatomic, strong) UIImageView *registerView;


@property (nonatomic, strong) UIButton *nextBtn;


@property (nonatomic, strong) UITextField *codePhoneTF;
@property (nonatomic, strong) UITextField *codeMaTF;
@property (nonatomic, strong) FLVerifyButton *codeBtn;


@property (nonatomic, strong) UITextField *passwordMaTF;
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"忘记密码";
    [self config];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame = CGRectMake(15, 20,44, 44);
    [backBtn setImage:[[UIImage imageNamed:@"返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    backBtn.tintColor = [UIColor colorc1c1c1];
    [backBtn addTarget:self action:@selector(pop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:backBtn];
    // Do any additional setup after loading the view.
}
- (void)pop:(UIButton *)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)config{
    self.bgView = [[UIImageView alloc] init];
    self.bgView.userInteractionEnabled = YES;
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view).offset(0);
    }];
    
    
    self.lgView = [[UIImageView alloc] init];
    self.lgView.backgroundColor = [UIColor whiteColor];
    self.lgView.userInteractionEnabled = YES;
    [self.bgView addSubview:self.lgView];
    [self.lgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(120/2.0);
        make.left.equalTo(self.bgView).offset(15);
        make.right.equalTo(self.bgView).offset(-15);
        make.bottom.equalTo(self.bgView).offset(-136/2.0);
    }];
    
    
    
    UIImageView *logoView = [[UIImageView alloc] init];
//    logoView.image = [UIImage imageNamed:@"icon"];
    logoView.userInteractionEnabled = YES;
    [self.lgView addSubview:logoView];
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lgView.mas_top).offset(-66/2.0);
        make.size.mas_equalTo(CGSizeMake(66, 66));
        make.centerX.equalTo(self.lgView);
    }];
    
    
    
    self.tLabel = [[UILabel alloc] initWithFrame:CGRectMake(37, 52, 200, 40)];
    self.tLabel.text = @"忘记密码";
    self.tLabel.textColor = [UIColor color7c4b00];
    self.tLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    [self.lgView addSubview:self.tLabel];
    
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.bgView addSubview:self.nextBtn];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(37);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-140);
        make.right.equalTo(self.view).offset(-37);
        make.height.equalTo(@44);
    }];
    [self.nextBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.nextBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.nextBtn setTintColor:[UIColor whiteColor]];
    self.nextBtn.backgroundColor = [UIColor colorddbb99];
    self.nextBtn.userInteractionEnabled = YES;
    self.nextBtn.layer.cornerRadius = 5;
    self.nextBtn.clipsToBounds = YES;
    
    [self addRegisterView];
    
    
    
    
    
    
    
    
    
}

- (void)sendCode:(UIButton *)sendBtn{
    
    [self.codePhoneTF resignFirstResponder];
    [self.codeMaTF resignFirstResponder];
    [self.passwordMaTF resignFirstResponder];
    
    if (self.codePhoneTF.text.length == 11) {
        [self sendVerificationCode:self.codePhoneTF.text];
    }else{
        [self showHint:@"请输入正确的手机号码"];
    }
    
    
}

- (void)changeAction:(UIButton *)loginBtn{
    [self completeAction:loginBtn];

}
//注册View
- (void)addRegisterView{
    self.registerView = [[UIImageView alloc] init];
    self.registerView.backgroundColor = [UIColor clearColor];
    self.registerView.hidden = NO;
    self.registerView.userInteractionEnabled = YES;
    [self.lgView addSubview:self.registerView];
    [self.registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tLabel.mas_bottom).offset(0);
        make.left.right.equalTo(self.lgView).offset(0);
        make.bottom.equalTo(self.nextBtn.mas_top).offset(0);
    }];
    ICON_TEXT *icon_text = [[ICON_TEXT alloc] initWithFrame:CGRectMake(37, 20, 80, 20) icon:@"手机号" tittle:@"手机号"];
    [self.registerView  addSubview:icon_text];
    
    
    UILabel *phoneNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(37, icon_text.bottom + 10, 40, 30)];
    phoneNameLabel.font = [UIFont boldSystemFontOfSize:18];
    phoneNameLabel.textColor = [UIColor color7c4b00];
    phoneNameLabel.text = @"+86";
    phoneNameLabel.backgroundColor =[UIColor clearColor];
    phoneNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.registerView addSubview:phoneNameLabel];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(phoneNameLabel.right, icon_text.bottom + 10, 10, 30)];
    icon.image = [UIImage imageNamed:@"7"];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    [self.registerView addSubview:icon];
    
    
    UIImageView *line01 = [[UIImageView alloc] initWithFrame:CGRectMake(icon.right+2, icon_text.bottom + 15, 0.5, 20)];
    line01.backgroundColor = [UIColor colorddbb99];
    line01.contentMode = UIViewContentModeScaleAspectFit;
    [self.registerView addSubview:line01];
    
    
    
    //手机号码
    self.codePhoneTF = [[UITextField alloc] initWithFrame:CGRectMake(line01.right+5,  icon_text.bottom + 10, (kScreenWidth -line01.right - 20-37 ), 30)];
    self.codePhoneTF.backgroundColor = [UIColor clearColor];
    self.codePhoneTF.keyboardType = UIKeyboardTypePhonePad;
    [self.registerView  addSubview: self.codePhoneTF];
    
    UIImageView *phoneLine = [[UIImageView alloc] initWithFrame:CGRectMake(37, self.codePhoneTF.bottom  + 5, kScreenWidth -30-37-37 , 0.5)];
    phoneLine.backgroundColor = [UIColor colorddbb99];
    [self.registerView addSubview:phoneLine];
    
    
    
    ICON_TEXT *icon_text1 = [[ICON_TEXT alloc] initWithFrame:CGRectMake(37, phoneLine.bottom+30, 80, 20) icon:@"验证码-2" tittle:@"验证码"];
    [self.registerView  addSubview:icon_text1];
    
    
    
    //验证码
    self.codeMaTF = [[UITextField alloc] initWithFrame:CGRectMake(37,  icon_text1.bottom + 10, kScreenWidth *0.3, 30)];
    self.codeMaTF.backgroundColor = [UIColor clearColor];
    self.codeMaTF.placeholder = @"输入验证码";
    self.codeMaTF.keyboardType = UIKeyboardTypeDefault;
    [self.registerView  addSubview: self.codeMaTF];
    
    
    
    
    self.codeBtn = [FLVerifyButton buttonWithType:UIButtonTypeSystem];
    self.codeBtn.frame = CGRectMake(kScreenWidth-30-100-37, icon_text1.bottom + 10, 100, 30);
    [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    self.codeBtn.countDownTime = 90;
    self.codeBtn.verifyCountDownCompete = ^{
        NSLog(@"%s",__func__);
    };
    [self.codeBtn addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
    self.codeBtn.layer.cornerRadius = 5;
    self.codeBtn.clipsToBounds  = YES;
    self.codeBtn.backgroundColor = [UIColor colorddbb99];
    self.codeBtn.tintColor = [UIColor whiteColor];
    [self.registerView  addSubview:self.codeBtn];
    
    
    UIImageView *codeLine = [[UIImageView alloc] initWithFrame:CGRectMake(37, self.codeMaTF.bottom   + 5, kScreenWidth -30-37-37 , 0.5)];
    codeLine.backgroundColor = [UIColor colorddbb99];
    [self.registerView addSubview:codeLine];
    
    
    
    ICON_TEXT *icon_text2 = [[ICON_TEXT alloc] initWithFrame:CGRectMake(37, codeLine.bottom+10, 80, 20) icon:@"密码" tittle:@"密码"];
    [self.registerView  addSubview:icon_text1];
    
    
    
    //密码
    self.passwordMaTF = [[UITextField alloc] initWithFrame:CGRectMake(37,  icon_text2.bottom + 10, kScreenWidth -30-37-37, 30)];
    self.passwordMaTF.backgroundColor = [UIColor clearColor];
    self.passwordMaTF.placeholder = @"输入6-20位密码";
    self.passwordMaTF.keyboardType = UIKeyboardTypeDefault;
    self.passwordMaTF.secureTextEntry = YES;
    [self.registerView  addSubview: self.passwordMaTF];
    
    UIImageView *passwordLine = [[UIImageView alloc] initWithFrame:CGRectMake(37, self.passwordMaTF.bottom   + 5, kScreenWidth -30-37-37 , 0.5)];
    passwordLine.backgroundColor = [UIColor colorddbb99];
    [self.registerView addSubview:passwordLine];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//发送验证码
- (void)sendVerificationCode:(NSString *)phone{
    
    NSDictionary *dict = @{@"phone":phone,@"type":@"1"};
    //    （type： 0-注册验证；1-修改密码验证码；2-修改绑定的手机号（即登录账号））
    [[CLHSessionManager shareManager] requestDataWithPath:[kBaseUrl stringByAppendingString:@"user/sendVerificationCode"] paramsJson:[dict JSONString] method:FBLRequestMethodGet WithCompleteBlock:^(NSMutableDictionary *data, NSError *error, ResultModel *resultModel) {
        NSLog(@"___%@__%@__%@",resultModel.data,resultModel.success,resultModel.errMessage);
        if ([[NSString stringWithFormat:@"%@",resultModel.success] isEqualToString:@"1"]) {
            [self.codeBtn startTime];
        }else{
            [self showHint:[NSString stringWithFormat:@"%@",resultModel.errMessage]];
        }
        
        
    }];
    
    
}
- (void)completeAction:(UIButton *)btn{

    
    if(![NSString validateMobile: self.codePhoneTF.text]){
        [self showHint:@"请输入正确的电话号码"];
        return;
    }
    if (self.passwordMaTF.text.length <6|| self.passwordMaTF.text.length > 20) {
        [self showHint:@"密码为6-20位数字或英文组成"];
        return;
    }
    if([self.codeMaTF.text isEqualToString:@""]   ){
        [self showHint:@"验证码不为空"];
        return;
    }
    
    NSDictionary *dict = @{@"phone":self.codePhoneTF.text,@"password":self.passwordMaTF.text,@"smsCode":self.codeMaTF.text};
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
