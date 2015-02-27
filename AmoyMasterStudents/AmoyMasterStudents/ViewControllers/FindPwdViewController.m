//
//  FindPwdViewController.m
//  AmoyMasterStudents
//
//  Created by julong on 15/2/9.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "FindPwdViewController.h"
#import "WWTextField.h"
#import "ValidateTool.h"
#import "RegisterViewController.h"
#import "ReSetPwdViewController.h"
#import "AFNetworking.h"

@interface FindPwdViewController ()<UITextFieldDelegate>
{
    WWTextField *phoneTextField;
    WWTextField *captchaTextField;
    
    UIButton *captchaBtn;
    
    AFHTTPRequestOperation *validOperation;
    AFHTTPRequestOperation *findPwdOperation;
}

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) int miao;

@end

@implementation FindPwdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"找回密码";
    
    [self leftBarItem];
    
     [self setUseView];
}

- (void)leftBarItem
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"icon_return.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"icon_return.png"] forState:UIControlStateHighlighted];
    backButton.frame = CGRectMake(0, 0, 21.5, 13.5);    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}
-(void)backAction
{
    [findPwdOperation cancel];
    findPwdOperation=nil;
    [validOperation cancel];
    validOperation=nil;
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark 初始化界面

-(void)setUseView
{
    phoneTextField = [[WWTextField alloc]initWithLeftFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, 44)];
    phoneTextField.font = [UIFont systemFontOfSize:16];
    phoneTextField.textColor = [UIColor blackColor];
    phoneTextField.borderStyle = UITextBorderStyleNone;
    phoneTextField.delegate =self;
    phoneTextField.returnKeyType = UIReturnKeyNext;
    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    phoneTextField.placeholder = @"请输入手机号码";
    [self.view addSubview:phoneTextField];
    
    
    captchaTextField = [[WWTextField alloc]initWithFrame:CGRectMake(phoneTextField.frame.origin.x, phoneTextField.frame.size.height+phoneTextField.frame.origin.y+15, SCREEN_WIDTH-60-120, phoneTextField.frame.size.height)];
    captchaTextField.textColor = [UIColor blackColor];
    captchaTextField.font = [UIFont systemFontOfSize:16];
    captchaTextField.placeholder = @"验证码";
    captchaTextField.keyboardType = UIKeyboardTypeNumberPad;
    captchaTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:captchaTextField];
    
    captchaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    captchaBtn.frame =CGRectMake(SCREEN_WIDTH-20-130, captchaTextField.frame.origin.y, 130, captchaTextField.frame.size.height);
    captchaBtn.backgroundColor = [UIColor grayColor];
    [captchaBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [captchaBtn setTitle:@"发送验证码" forState:UIControlStateHighlighted];
    [captchaBtn setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateHighlighted];
    [captchaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    captchaBtn.layer.masksToBounds=YES;
    captchaBtn.layer.cornerRadius=4;
    captchaBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [captchaBtn addTarget:self action: @selector(captchaBtnClick) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:captchaBtn];
    
    UIButton *findPwdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    findPwdButton.frame = CGRectMake(phoneTextField.frame.origin.x, captchaTextField.frame.size.height+captchaTextField.frame.origin.y+20, phoneTextField.frame.size.width, 50);
    [findPwdButton setBackgroundColor:RGBA(0, 165, 109, 1)];
    [findPwdButton setTitle:@"找回密码" forState:UIControlStateNormal];
    [findPwdButton setTitle:@"找回密码" forState:UIControlStateHighlighted];
    [findPwdButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [findPwdButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    findPwdButton.layer.masksToBounds=YES;
    findPwdButton.layer.cornerRadius=4;
    [findPwdButton addTarget:self action:@selector(findPwdButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:findPwdButton];
    
    UILabel *registerLabel = [[UILabel alloc]init];
    registerLabel.frame = CGRectMake(SCREEN_WIDTH-160, findPwdButton.frame.size.height+findPwdButton.frame.origin.y+15, 140, 20);
    registerLabel.backgroundColor = [UIColor clearColor];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"没有账号?立即注册"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0,5)];
    [str addAttribute:NSForegroundColorAttributeName value:RGBA(0, 165, 109, 1) range:NSMakeRange(5,4)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 5)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(5, 4)];
    registerLabel.attributedText = str;
    registerLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:registerLabel];
    
    
    UIButton *registerButton =[UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.backgroundColor = [UIColor clearColor];
    registerButton.frame = CGRectMake(registerLabel.frame.origin.x,registerLabel.frame.origin.y, registerLabel.frame.size.width, registerLabel.frame.size.height);
    [registerButton addTarget:self action:@selector(registerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
}

-(void)onTimer
{
    self.miao--;
    NSString *captchBtnStr;
    
    if (self.miao==0)
    {
        captchBtnStr = @"重新获取验证码";
        [self.timer invalidate];
        captchaBtn.userInteractionEnabled = YES;
    }
    else
    {
        captchBtnStr = [NSString stringWithFormat:@"(%ds)重新获取验证码",self.miao];
        captchaBtn.userInteractionEnabled = NO;
    }
    [captchaBtn setTitle:captchBtnStr forState:UIControlStateNormal];
    [captchaBtn setTitle:captchBtnStr forState:UIControlStateHighlighted];
}

#pragma mark -
#pragma mark 按钮点击事件

//获取验证码
-(void)captchaBtnClick
{
    [captchaTextField resignFirstResponder];
    [phoneTextField resignFirstResponder];
    
    NSString *phoneStr = [phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (phoneStr==nil||[phoneStr isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"手机号码不能为空"];
        [phoneTextField becomeFirstResponder];
        return;
    }
    else
    {
        //手机号码2
        BOOL isUsed = [ValidateTool validateMobile:phoneStr];
        if (isUsed==NO)
        {
            [PublicConfig waringInfo:@"手机号码格式不正确"];
            [phoneTextField becomeFirstResponder];
            captchaTextField.text = nil;
            return;
        }
    }
    
    //获取校验码
    [self getValidCodeData:phoneStr];
    
    self.miao = 60;
    if (self.timer)
    {
        [self.timer invalidate];
    }
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES ];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

//注册
-(void)findPwdButtonClick
{
    //发送注册请求 请求成功返回
    [captchaTextField resignFirstResponder];
    [phoneTextField resignFirstResponder];
    
    NSString *phoneStr = [phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *captchaStr = [captchaTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (phoneStr==nil||[phoneStr isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"手机号码不能为空"];
        [phoneTextField becomeFirstResponder];
        return;
    }
    else
    {
        //手机号码2
        BOOL isUsed = [ValidateTool validateMobile:phoneStr];
        if (isUsed==NO)
        {
            [PublicConfig waringInfo:@"手机号码格式不正确"];
            [phoneTextField becomeFirstResponder];
            captchaTextField.text = nil;
            return;
        }
    }
    
    if (captchaStr==nil||[captchaStr isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"验证码不能为空"];
        [captchaTextField becomeFirstResponder];
        return;
    }
    
    //验证后成功后发送请求
    [self setUserData:phoneStr andPassCode:captchaStr];
    
}

//立即注册点击
-(void)registerButtonClicked:(id)sender
{
    RegisterViewController *vc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -
#pragma mark 请求相关

//找回密码验证请求
-(void)setUserData:(NSString *)phoneNumber andPassCode:(NSString *)passCode
{
    [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"加载中..." animated:YES];
    
    NSString *useUrl = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL,trainee_traineeRead_requestPwdRese];
    
            NSDictionary *params = @{@"cellphone":phoneNumber,@"vCode":passCode};
    
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            findPwdOperation =  [manager POST:useUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
                          {
                              [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
                              NSDictionary *responseDic = (NSDictionary *)responseObject;
                              NSString *resultCode = [responseDic valueForKey:@"code"]; //0成功 1失败
                              if ([resultCode boolValue]==NO)
                              {
                                  NSString *dataStr = [responseDic valueForKey:@"data"];
                                  
                                  //验证成功进入重置密码页面
                                  ReSetPwdViewController *vc = [[ReSetPwdViewController alloc]init];
                                  vc.dataStr = dataStr;
                                  [self.navigationController pushViewController:vc animated:YES];
                              }
                              else
                              {
                                  NSString *msgStr = [responseDic valueForKey:@"msg"];
                                  [SVProgressHUD showErrorWithStatus:[PublicConfig isSpaceString:msgStr andReplace:@"找回密码验证失败"]];
                              }
                          }
                               failure:^(AFHTTPRequestOperation *operation, NSError *error)
                          {
                              [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                              [SVProgressHUD showErrorWithStatus:@"找回密码验证请求失败"];
                          }];
}

//给用户发送短信验证码
-(void)getValidCodeData:(NSString *)hp
{
        [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"获取验证码中..." animated:YES];
    
        NSString *useUrl = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL,trainee_traineeRead_sendPwdResetSMS];
    
        NSDictionary *params = @{@"cellphone":hp};
    
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        validOperation =  [manager POST:useUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
                      {
                          [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
                          NSDictionary *responseDic = (NSDictionary *)responseObject;
                          NSString *resultCode = [responseDic valueForKey:@"code"]; //0成功 1失败
                          if ([resultCode boolValue]==NO)
                          {
                              DLog(@"验证码获取成功");
                          }
                          else
                          {
                              NSString *msgStr = [responseDic valueForKey:@"msg"];
                              [SVProgressHUD showErrorWithStatus:[PublicConfig isSpaceString:msgStr andReplace:@"验证码获取失败"]];
                          }
                      }
                           failure:^(AFHTTPRequestOperation *operation, NSError *error)
                      {
                          [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                          [SVProgressHUD showErrorWithStatus:@"验证码获取请求失败"];
                      }];
}

#pragma mark -
#pragma mark 屏幕点击事件

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [captchaTextField resignFirstResponder];
    [phoneTextField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeyDone)
    {
        [captchaTextField resignFirstResponder];
        [phoneTextField resignFirstResponder];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    textField.text = @"";
    return YES;
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
