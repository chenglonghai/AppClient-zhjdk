//
//  AdviceViewController.m
//  AppClient
//
//  Created by xinz on 2018/1/10.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import "AdviceViewController.h"
#import "JYZTextView.h"

@interface AdviceViewController ()<UITextViewDelegate>

@property (nonatomic, strong)JYZTextView *textView;
@property (strong, nonatomic) UILabel * numLabel;
@property (nonatomic, strong)UITextField *phoneTF;


@end

@implementation AdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"意见反馈";
    [self customUI];
    
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    saveBtn.frame = CGRectMake(0, 0, 44, 44);
    [saveBtn setTitle:@"提交" forState:UIControlStateNormal];
    saveBtn.titleLabel.textColor = [UIColor color8a8a8a];
    saveBtn.tintColor = [UIColor blackColor];
    
    [saveBtn addTarget:self action:@selector(commitContent:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    
    

    // Do any additional setup after loading the view.
}


- (void)submitAdviceData{
    
    NSDictionary *dict = @{@"nickname":[UserManager shareManager].userModel.nickname,@"phone":self.phoneTF.text,@"content":self.textView.text};
    
    [[CLHSessionManager shareManager] requestDataWithPath:[kBaseUrl stringByAppendingString:@"feedback/saveFeedBack"] paramsJson:[dict JSONString] method:FBLRequestMethodGet WithCompleteBlock:^(NSMutableDictionary *data, NSError *error, ResultModel *resultModel) {
        NSLog(@"%@___%@__%@__%@",data,resultModel.data,resultModel.success,resultModel.errMessage);
        if ([[NSString stringWithFormat:@"%@",resultModel.success] isEqualToString:@"1"]) {
            
            [self showHint:@"提交成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [self showHint:@"不好意思，提交出问题了"];
        }
        
        
    }];
    
}

- (void)commitContent:(UIBarButtonItem *)bar
{
    
    [self.textView resignFirstResponder];
    [self.phoneTF resignFirstResponder];
    if ([self.textView.text isEqualToString:@""] || [self.phoneTF.text isEqualToString:@""]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您未输入意见内容或者手机号码" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
        
        return;
    }
    if ( ![self isValidateMobile:self.phoneTF.text]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您的电话号码不正确" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }else{
        
        [self submitAdviceData];
        
    }
    
    
    
    
    
}

- (void)customUI
{
    UIView *myBackgrondView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth ,302)];
    myBackgrondView.backgroundColor = [UIColor whiteColor];
//    myBackgrondView.layer.borderWidth = 0.5;
//    myBackgrondView.layer.borderColor = [UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:1].CGColor;
    [self.view addSubview:myBackgrondView];
    
    UILabel *adLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    adLabel.text = @"     反馈内容";
    adLabel.textColor = [UIColor blackColor];
    adLabel.font = [UIFont systemFontOfSize:14.0f];
    adLabel.backgroundColor = [UIColor coloreeeeee];
    [myBackgrondView addSubview:adLabel];
    
    
    
    self.textView = [[JYZTextView alloc]initWithFrame:CGRectMake(15, adLabel.bottom,kScreenWidth -30, 170)];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:14.f];
    _textView.layer.borderColor = [UIColor clearColor].CGColor;
    _textView.layer.borderWidth = 1;
    _textView.textColor = [UIColor colorddbb99];
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.placeholder = @"期待您的宝贵意见...";
    [myBackgrondView addSubview:_textView];
    
    _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _textView.bottom, kScreenWidth -25, 30)];
    _numLabel.textAlignment = NSTextAlignmentRight;
    _numLabel.text = @"0/500";
    _numLabel.textColor = [UIColor grayColor];
    _numLabel.backgroundColor = [UIColor whiteColor];
    [myBackgrondView addSubview:_numLabel];
    
    
    
    UILabel *pLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _numLabel.bottom, kScreenWidth, 30)];
    pLabel.text = @"     联系方式";
    pLabel.textColor = [UIColor blackColor];
    pLabel.backgroundColor = [UIColor coloreeeeee];
    pLabel.font = [UIFont systemFontOfSize:14.0f];
    [myBackgrondView addSubview:pLabel];
    
    
    self.phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(15, pLabel.bottom, kScreenWidth-30, 42)];
    self.phoneTF.backgroundColor = [UIColor whiteColor];
    self.phoneTF.placeholder = @"请留下手机号方便我们联系您";
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTF.secureTextEntry = NO;
    [myBackgrondView addSubview:self.phoneTF];
    
    
    
    
}

#pragma mark textField的字数限制

//在这个地方计算输入的字数
- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger wordCount = textView.text.length;
    self.numLabel.text = [NSString stringWithFormat:@"%ld/500",(long)wordCount];
    [self wordLimit:textView];
}

#pragma mark 超过300字不能输入
-(BOOL)wordLimit:(UITextView *)text{
    if (text.text.length < 500) {
        //        NSLog(@"%ld",text.text.length);
        self.textView.editable = YES;
    }
    else{
        self.textView.editable = NO;
        
    }
    return nil;
}
//判断手机号是否正确
-(BOOL)isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((17[0-9])|(13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
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
