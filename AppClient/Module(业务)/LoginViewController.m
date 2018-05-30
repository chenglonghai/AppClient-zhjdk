//
//  LoginViewController.m
//  AppClient
//
//  Created by xinz on 2018/1/4.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "LoginViewController.h"
#import "ZFJSegmentedControl.h"
#import "ICON_TEXT.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import "FLVerifyButton.h"
@interface LoginViewController ()

@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIImageView *lgView;

@property (nonatomic, strong) UIImageView *codeLoginView;
@property (nonatomic, strong) UIImageView *passwordLoginView;

@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) ZFJSegmentedControl *zvc;

@property (nonatomic, strong) UITextField *codePhoneTF;
@property (nonatomic, strong) UITextField *codeMaTF;
@property (nonatomic, strong) FLVerifyButton *codeBtn;

@property (nonatomic, strong) UITextField *passwordPhoneTF;
@property (nonatomic, strong) UITextField *passwordMaTF;

@property (nonatomic, assign) BOOL isCodeLogin;


@end

@implementation LoginViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    self.isCodeLogin = YES;
    [self config];
    
    
 
    // Do any additional setup after loading the view.
}
- (void)config{
    self.bgView = [[UIImageView alloc] init];
    self.bgView.userInteractionEnabled = YES;
    self.bgView.image = [UIImage imageNamed:@"组16"];
    [self.view addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view).offset(0);
    }];

    
    self.lgView = [[UIImageView alloc] init];
    self.lgView.image = [UIImage imageNamed:@"矩形5"];
        self.lgView.userInteractionEnabled = YES;
    [self.bgView addSubview:self.lgView];
    [self.lgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(178/2.0);
        make.left.equalTo(self.bgView).offset(15);
        make.right.equalTo(self.bgView).offset(-15);
        make.bottom.equalTo(self.bgView).offset(-136/2.0);
    }];
    
    
    
    UIImageView *logoView = [[UIImageView alloc] init];
    logoView.image = [UIImage imageNamed:@"icon"];
    logoView.userInteractionEnabled = YES;
    [self.lgView addSubview:logoView];
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lgView.mas_top).offset(-66/2.0);
        make.size.mas_equalTo(CGSizeMake(66, 66));
        make.centerX.equalTo(self.lgView);
    }];
    
    
    
    self.zvc = [[ZFJSegmentedControl alloc]initwithTitleArr:@[@"密码登录"] iconArr:nil SCType:SCType_None];
    self.zvc.backgroundColor = [UIColor clearColor];
    self.zvc.titleColor = [UIColor colorc1c1c1];
    self.zvc.selectTitleColor =[UIColor color7c4b00];
    self.zvc.titleFont = [UIFont boldSystemFontOfSize:16];
    self.zvc.selectBtnFont = [UIFont boldSystemFontOfSize:18];
    self.zvc.selectType = ^(NSInteger selectIndex,NSString *selectIndexTitle){
        NSLog(@"selectIndexTitle == %@== %ld",selectIndexTitle,selectIndex);
//        if (selectIndex == 0) {
//            self.codeLoginView.hidden = NO;
//            self.passwordLoginView.hidden = YES;
//                self.isCodeLogin = YES;
//        }
//        if (selectIndex == 1) {
//            self.codeLoginView.hidden = YES;
//            self.passwordLoginView.hidden = NO;
//                self.isCodeLogin = NO;
//        }
          };
     [self.lgView addSubview:self.zvc];
     self.zvc.frame = CGRectMake(30, 92, 100, 40);

    self.loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                     self.bgView.userInteractionEnabled = YES;
    [self.bgView addSubview:self.loginBtn];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(37);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-140);
        make.right.equalTo(self.view).offset(-37);
        make.height.equalTo(@44);
    }];
    [self.loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTintColor:[UIColor whiteColor]];
    self.loginBtn.backgroundColor = [UIColor colorddbb99];
    self.loginBtn.userInteractionEnabled = YES;
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.clipsToBounds = YES;
    
   [self addCodeLoginView];
   [self addPasswordView];
    
    
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.bgView   addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(37);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-80);
        make.right.equalTo(self.view).offset(-37);
        make.height.equalTo(@30);
    }];
    [registerBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    registerBtn.backgroundColor = [UIColor clearColor];
    registerBtn.tintColor = [UIColor colorc1c1c1];
    registerBtn.font = [UIFont boldSystemFontOfSize:15];
    [registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];

 

    
    
}
- (void)registerAction:(UIButton *)btn{
    NSLog(@"注册");
    RegisterViewController *registerVC = [RegisterViewController new];
    [self.navigationController pushViewController:registerVC animated:YES];
}
- (void)login:(UIButton *)loginBtn{
    //验证码登录
    [self cancelKeyBoardAll];
    
    
//    if (self.isCodeLogin == YES) {
//
//        if (![NSString validateMobile:self.codePhoneTF.text]) {
//            [self showHint:@"请输入正确的手机号"];
//            return;
//        }
//        if ([self.codeMaTF.text isEqualToString:@""]) {
//            [self showHint:@"验证码不为空"];
//            return;
//        }
//
//        [self loginWithCode:self.codeMaTF.text phone:self.codePhoneTF.text];
//
//    }else{
        if (![NSString validateMobile:self.passwordPhoneTF.text]) {
            [self showHint:@"请输入正确的手机号"];
            return;
        }
        if ([self.passwordMaTF.text isEqualToString:@""]) {
            [self showHint:@"密码不为空"];
            return;
        }
        
        [self loginWithPassword:self.passwordMaTF.text phone:self.passwordPhoneTF.text];
//    }

}
//验证码登录
- (void)addCodeLoginView{
   self.codeLoginView = [[UIImageView alloc] init];
    self.codeLoginView.backgroundColor = [UIColor clearColor];
    self.codeLoginView.hidden = YES;
    self.codeLoginView.userInteractionEnabled = YES;
    [self.lgView addSubview:self.codeLoginView];
    [self.codeLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.zvc.mas_bottom).offset(0);
        make.left.right.equalTo(self.lgView).offset(0);
        make.bottom.equalTo(self.loginBtn.mas_top).offset(0);
    }];
    ICON_TEXT *icon_text = [[ICON_TEXT alloc] initWithFrame:CGRectMake(37, 20, 80, 20) icon:@"手机号" tittle:@"手机号"];
    [self.codeLoginView  addSubview:icon_text];
    
    
    UILabel *phoneNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(37, icon_text.bottom + 10, 40, 30)];
    phoneNameLabel.font = [UIFont boldSystemFontOfSize:18];
    phoneNameLabel.textColor = [UIColor color7c4b00];
    phoneNameLabel.text = @"+86";
    phoneNameLabel.backgroundColor =[UIColor clearColor];
    phoneNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.codeLoginView addSubview:phoneNameLabel];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(phoneNameLabel.right, icon_text.bottom + 10, 10, 30)];
    icon.image = [UIImage imageNamed:@"7"];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    [self.codeLoginView addSubview:icon];
    
    
    UIImageView *line01 = [[UIImageView alloc] initWithFrame:CGRectMake(icon.right+2, icon_text.bottom + 15, 0.5, 20)];
    line01.backgroundColor = [UIColor colorddbb99];
    line01.contentMode = UIViewContentModeScaleAspectFit;
    [self.codeLoginView addSubview:line01];
    
    
    
       //手机号码
       self.codePhoneTF = [[UITextField alloc] initWithFrame:CGRectMake(line01.right+5,  icon_text.bottom + 10, (kScreenWidth -line01.right - 20-37 ), 30)];
        self.codePhoneTF.backgroundColor = [UIColor clearColor];
       self.codePhoneTF.keyboardType = UIKeyboardTypePhonePad;
    [self.codeLoginView  addSubview: self.codePhoneTF];
    
    UIImageView *phoneLine = [[UIImageView alloc] initWithFrame:CGRectMake(37, self.codePhoneTF.bottom  + 5, kScreenWidth -30-37-37 , 0.5)];
    phoneLine.backgroundColor = [UIColor colorddbb99];
    [self.codeLoginView addSubview:phoneLine];
    
    
    
    ICON_TEXT *icon_text1 = [[ICON_TEXT alloc] initWithFrame:CGRectMake(37, phoneLine.bottom+30, 80, 20) icon:@"验证码-2" tittle:@"验证码"];
    [self.codeLoginView  addSubview:icon_text1];
    
    
    
    //验证码
    self.codeMaTF = [[UITextField alloc] initWithFrame:CGRectMake(37,  icon_text1.bottom + 10, kScreenWidth *0.3, 30)];
    self.codeMaTF.backgroundColor = [UIColor clearColor];
    self.codeMaTF.placeholder = @"输入验证码";
    self.codeMaTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.codeLoginView  addSubview: self.codeMaTF];
  
    self.codeBtn = [FLVerifyButton buttonWithType:UIButtonTypeSystem];
    self.codeBtn.frame = CGRectMake(kScreenWidth-30-100-37, icon_text1.bottom + 10, 100, 30);
    [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.codeBtn.countDownTime = 90;
    self.codeBtn.verifyCountDownCompete = ^{
        NSLog(@"%s",__func__);
    };
    [self.codeBtn addTarget:self action:@selector(goToSendCode) forControlEvents:UIControlEventTouchUpInside];
    self.codeBtn.layer.cornerRadius = 5;
    self.codeBtn.clipsToBounds  = YES;
    self.codeBtn.backgroundColor = [UIColor colorddbb99];
    self.codeBtn.tintColor = [UIColor whiteColor];
    [self.codeLoginView  addSubview:self.codeBtn];
    
    
    UIImageView *codeLine = [[UIImageView alloc] initWithFrame:CGRectMake(37, self.codeMaTF.bottom   + 5, kScreenWidth -30-37-37 , 0.5)];
    codeLine.backgroundColor = [UIColor colorddbb99];
    [self.codeLoginView addSubview:codeLine];
    

    


}
-(void)goToSendCode{
    [self cancelKeyBoardAll];
    if (![NSString validateMobile:self.codePhoneTF.text]) {
        [self showHint:@"输入正确的电话号码"];
        return;
    }
    
    [self sendVerificationCode:self.codePhoneTF.text];

}

- (void)cancelKeyBoardAll{
    [self.codePhoneTF resignFirstResponder];
    [self.codeMaTF resignFirstResponder];
    [self.passwordPhoneTF resignFirstResponder];
    [self.passwordMaTF resignFirstResponder];

}
//发送验证码
- (void)sendVerificationCode:(NSString *)phone{
    
    NSDictionary *dict = @{@"phone":phone};
    
    [[CLHSessionManager shareManager] requestDataWithPath:[@"http://47.94.139.183:8080/pep_sms" stringByAppendingString:@"/sms/verify"] paramsJson:[dict JSONString] method:FBLRequestMethodPost WithCompleteBlock:^(NSMutableDictionary *data, NSError *error, ResultModel *resultModel) {
        NSLog(@"___%@__%@__%@",data,resultModel.success,resultModel.errMessage);
        if ([[NSString stringWithFormat:@"%@",resultModel.success] isEqualToString:@"1"]) {
            [self.codeBtn startTime];
        }else{
            [self showHint:[NSString stringWithFormat:@"%@",resultModel.errMessage]];
        }
        
        
    }];
    
    
}

//验证码登录
- (void)loginWithCode:(NSString *)smsCode phone:(NSString *)phone{
    
    NSDictionary *dict = @{@"smsCode":smsCode,@"phone":phone};
    
    [[CLHSessionManager shareManager] requestDataWithPath:[kBaseUrl stringByAppendingString:@"user/login"] paramsJson:[dict JSONString] method:FBLRequestMethodPost WithCompleteBlock:^(NSMutableDictionary *data, NSError *error, ResultModel *resultModel) {
        NSLog(@"___%@__%@__%@",resultModel.data,resultModel.success,resultModel.errMessage);
        if ([[NSString stringWithFormat:@"%@",resultModel.success] isEqualToString:@"1"]) {
            [[UserManager shareManager] saveUserInfo:resultModel.data];
            [self dismissViewControllerAnimated:YES completion:nil];
            
                [self showHint:@"登录成功"];
            
        }else{
            [self showHint:[NSString stringWithFormat:@"%@",resultModel.errMessage]];
        }
        
        
    }];
    
    
}


//密码登录
- (void)addPasswordView{
    
    self.passwordLoginView = [[UIImageView alloc] init];
    self.passwordLoginView.backgroundColor = [UIColor clearColor];
    self.passwordLoginView.userInteractionEnabled = YES;
    self.passwordLoginView.hidden = NO;
    [self.lgView addSubview:self.passwordLoginView];
    [self.passwordLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.zvc.mas_bottom).offset(0);
        make.left.right.equalTo(self.lgView).offset(0);
        make.bottom.equalTo(self.loginBtn.mas_top).offset(0);
    }];
    
    
    ICON_TEXT *icon_text = [[ICON_TEXT alloc] initWithFrame:CGRectMake(37, 20, 80, 20) icon:@"手机号" tittle:@"手机号"];
    [self.passwordLoginView  addSubview:icon_text];
    
    
    UILabel *phoneNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(37, icon_text.bottom + 10, 40, 30)];
    phoneNameLabel.font = [UIFont boldSystemFontOfSize:18];
    phoneNameLabel.textColor = [UIColor color7c4b00];
    phoneNameLabel.text = @"+86";
    phoneNameLabel.backgroundColor =[UIColor clearColor];
    phoneNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.passwordLoginView addSubview:phoneNameLabel];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(phoneNameLabel.right, icon_text.bottom + 10, 10, 30)];
    icon.image = [UIImage imageNamed:@"7"];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    [self.passwordLoginView addSubview:icon];
    
    
    UIImageView *line01 = [[UIImageView alloc] initWithFrame:CGRectMake(icon.right+2, icon_text.bottom + 15, 0.5, 20)];
    line01.backgroundColor = [UIColor colorddbb99];
    line01.contentMode = UIViewContentModeScaleAspectFit;
    [self.passwordLoginView addSubview:line01];
    
    
    
    //手机号码
    self.passwordPhoneTF = [[UITextField alloc] initWithFrame:CGRectMake(line01.right+5,  icon_text.bottom + 10, (kScreenWidth -line01.right - 20-37 ), 30)];
    self.passwordPhoneTF.backgroundColor = [UIColor clearColor];
    self.passwordPhoneTF.keyboardType = UIKeyboardTypePhonePad;
    [self.passwordLoginView  addSubview: self.passwordPhoneTF];
    
    UIImageView *phoneLine = [[UIImageView alloc] initWithFrame:CGRectMake(37, self.passwordPhoneTF.bottom  + 5, kScreenWidth -30-37-37 , 0.5)];
    phoneLine.backgroundColor = [UIColor colorddbb99];
    [self.passwordLoginView addSubview:phoneLine];
    
    
    
    ICON_TEXT *icon_text1 = [[ICON_TEXT alloc] initWithFrame:CGRectMake(37, phoneLine.bottom+30, 80, 20) icon:@"密码" tittle:@"密码"];
    [self.passwordLoginView  addSubview:icon_text1];
    
    
    
    //验证码
    self.passwordMaTF = [[UITextField alloc] initWithFrame:CGRectMake(37,  icon_text1.bottom + 10, kScreenWidth *0.6, 30)];
    self.passwordMaTF.backgroundColor = [UIColor clearColor];
    self.passwordMaTF.placeholder = @"输入6-20位密码";
    self.passwordMaTF.keyboardType = UIKeyboardTypeASCIICapable;
    self.passwordMaTF.secureTextEntry = YES;
    [self.passwordLoginView  addSubview: self.passwordMaTF];
    

    
    
    UIImageView *codeLine = [[UIImageView alloc] initWithFrame:CGRectMake(37, self.passwordMaTF.bottom   + 5, kScreenWidth -30-37-37 , 0.5)];
    codeLine.backgroundColor = [UIColor colorddbb99];
    [self.passwordLoginView addSubview:codeLine];
    
    
    
    
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    forgetBtn.frame = CGRectMake(37, codeLine.bottom + 5,80, 30);
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetBtn.backgroundColor = [UIColor clearColor];
    forgetBtn.tintColor = [UIColor colorc1c1c1];
    [forgetBtn addTarget:self action:@selector(forgetAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.passwordLoginView  addSubview:forgetBtn];

}

//验证码登录
- (void)loginWithPassword:(NSString *)password phone:(NSString *)phone{
    
    NSDictionary *dict = @{@"password":password,@"phone":phone};
    
    [[CLHSessionManager shareManager] requestDataWithPath:[kBaseUrl stringByAppendingString:@"user/login"] paramsJson:[dict JSONString] method:FBLRequestMethodPost WithCompleteBlock:^(NSMutableDictionary *data, NSError *error, ResultModel *resultModel) {
        NSLog(@"___%@__%@__%@",resultModel.data,resultModel.success,resultModel.errMessage);
        if ([[NSString stringWithFormat:@"%@",resultModel.success] isEqualToString:@"1"]) {
            [[UserManager shareManager] saveUserInfo:resultModel.data];
            [self dismissViewControllerAnimated:YES completion:nil];
            
            [self showHint:@"登录成功"];
            
        }else{
            [self showHint:[NSString stringWithFormat:@"%@",resultModel.errMessage]];
        }
        
        
    }];
    
    
}

- (void)forgetAction:(UIButton *)btn{
    ForgetPasswordViewController *fvc = [ForgetPasswordViewController new];
    [self.navigationController pushViewController:fvc animated:YES];
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
