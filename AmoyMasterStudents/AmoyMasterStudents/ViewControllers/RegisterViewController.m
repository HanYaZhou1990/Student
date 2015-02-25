//
//  RegisterViewController.m
//  AmoyMasterStudents
//
//  Created by julong on 15/2/9.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "RegisterViewController.h"
#import "WWTextField.h"
#import "ValidateTool.h"
#import "AFNetworking.h"

@interface RegisterViewController ()<UITextFieldDelegate>
{
    WWTextField *phoneTextField;
    WWTextField *userPswField;
    WWTextField *userConPswField; //确认密码
    WWTextField *captchaTextField;
    
    UIButton *captchaBtn;
    
    AFHTTPRequestOperation *validOperation;
    AFHTTPRequestOperation *registerOperation;
}

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) int miao;

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"注册";
    
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
    [registerOperation cancel];
    registerOperation=nil;
    [validOperation cancel];
    validOperation=nil;
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    
    userPswField = [[WWTextField alloc]initWithFrame:CGRectMake(phoneTextField.frame.origin.x, phoneTextField.frame.size.height+phoneTextField.frame.origin.y+15, phoneTextField.frame.size.width, phoneTextField.frame.size.height)];
    userPswField.placeholder = @"请输入密码";
    userPswField.font = [UIFont systemFontOfSize:16];
    userPswField.textColor = [UIColor blackColor];
    userPswField.borderStyle = UITextBorderStyleNone;
    userPswField.returnKeyType = UIReturnKeyNext;
    userPswField.delegate = self;
    userPswField.secureTextEntry = YES;//密码样式
    [self.view addSubview:userPswField];
    
    userConPswField = [[WWTextField alloc]initWithFrame:CGRectMake(phoneTextField.frame.origin.x, userPswField.frame.size.height+userPswField.frame.origin.y+15, phoneTextField.frame.size.width, phoneTextField.frame.size.height)];
    userConPswField.placeholder = @"确认密码";
    userConPswField.font = [UIFont systemFontOfSize:16];
    userConPswField.textColor = [UIColor blackColor];
    userConPswField.borderStyle = UITextBorderStyleNone;
    userConPswField.returnKeyType = UIReturnKeyNext;
    userConPswField.delegate = self;
    userConPswField.secureTextEntry = YES;//密码样式
    [self.view addSubview:userConPswField];
    
    captchaTextField = [[WWTextField alloc]initWithFrame:CGRectMake(userPswField.frame.origin.x, userConPswField.frame.size.height+userConPswField.frame.origin.y+15, SCREEN_WIDTH-60-120, userPswField.frame.size.height)];
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
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.frame = CGRectMake(phoneTextField.frame.origin.x, captchaTextField.frame.size.height+captchaTextField.frame.origin.y+30, phoneTextField.frame.size.width, 50);
    [registerButton setBackgroundColor:RGBA(0, 165, 109, 1)];
    [registerButton setTitle:@"注  册" forState:UIControlStateNormal];
    [registerButton setTitle:@"注  册" forState:UIControlStateHighlighted];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    registerButton.layer.masksToBounds=YES;
    registerButton.layer.cornerRadius=4;
    [registerButton addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    UILabel *registerLabel = [[UILabel alloc]init];
    registerLabel.frame = CGRectMake(SCREEN_WIDTH-160, registerButton.frame.size.height+registerButton.frame.origin.y+15, 140, 20);
    registerLabel.backgroundColor = [UIColor clearColor];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"已有账号?立即登录"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0,5)];
    [str addAttribute:NSForegroundColorAttributeName value:RGBA(0, 165, 109, 1) range:NSMakeRange(5,4)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 5)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(5, 4)];
    registerLabel.attributedText = str;
    registerLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:registerLabel];
    
    
    UIButton *loginButton =[UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.backgroundColor = [UIColor clearColor];
    loginButton.frame = CGRectMake(registerLabel.frame.origin.x,registerLabel.frame.origin.y, registerLabel.frame.size.width, registerLabel.frame.size.height);
    [loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
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
-(void)registerBtnClick
{
    //发送注册请求 请求成功返回
    [captchaTextField resignFirstResponder];
    [phoneTextField resignFirstResponder];
    [userPswField resignFirstResponder];
    [userConPswField resignFirstResponder];
    
    NSString *phoneStr = [phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *pwdStr = [userPswField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *conPwdStr = [userConPswField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
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
    
    if (pwdStr==nil||[pwdStr isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"密码不能为空"];
        [userPswField becomeFirstResponder];
        return;
    }
    
    if (conPwdStr==nil||[conPwdStr isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"确认密码不能为空"];
        [userPswField becomeFirstResponder];
        return;
    }
    else
    {
        if (![pwdStr isEqualToString:conPwdStr])
        {
            [PublicConfig waringInfo:@"两次密码输入不一致"];
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
    [self registerUserData:phoneStr andPassword:pwdStr andPassCode:captchaStr];
    
}

-(void)loginButtonClicked:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark 请求相关

//注册请求
-(void)registerUserData:(NSString *)phoneNumber andPassword:(NSString *)password andPassCode:(NSString *)passCode
{
    [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"注册中..." animated:YES];
    
    NSString *useUrl = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL,trainee_traineeWrite_register];
    
    NSDictionary *params = @{@"account":phoneNumber,@"password":password};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    registerOperation =  [manager POST:useUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
                       {
                           [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                           
                           NSDictionary *responseDic = (NSDictionary *)responseObject;
                           NSString *resultCode = [responseDic valueForKey:@"code"]; //0成功 1失败
                           if ([resultCode boolValue]==NO)
                           {
                               [PublicConfig waringInfo:@"注册成功"];
                               //注册成功 返回去登陆
                               [self.navigationController popViewControllerAnimated:YES];
                           }
                           else
                           {
                               NSString *dataStr = [responseDic valueForKey:@"data"];
                               [SVProgressHUD showErrorWithStatus:[PublicConfig isSpaceString:dataStr andReplace:@"注册失败"]];
                           }
                       }
                            failure:^(AFHTTPRequestOperation *operation, NSError *error)
                       {
                           [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                            [SVProgressHUD showErrorWithStatus:@"注册请求失败"];
                       }];
}

//给用户发送短信验证码
-(void)getValidCodeData:(NSString *)hp
{
    
//    [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"获取验证码中..." animated:YES];
//    
//    NSString *useUrl = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL,@""];
//    
//    NSDictionary *params = @{@"cellphone":@""};
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    validOperation =  [manager POST:useUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
//                  {
//                      [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//                      
//                      NSDictionary *responseDic = (NSDictionary *)responseObject;
//                      NSString *resultCode = [responseDic valueForKey:@"code"]; //0成功 1失败
//                      if ([resultCode boolValue]==NO)
//                      {
//                          NSString *dataStr = [responseDic valueForKey:@"data"];
//                          [PublicConfig waringInfo:[PublicConfig isSpaceString:dataStr andReplace:@"注册成功"]];
//                      }
//                      else
//                      {
//                          NSString *dataStr = [responseDic valueForKey:@"data"];
//                          [SVProgressHUD showErrorWithStatus:[PublicConfig isSpaceString:dataStr andReplace:@"验证码获取失败"]];
//                      }
//                  }
//                       failure:^(AFHTTPRequestOperation *operation, NSError *error)
//                  {
//                      [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//                      DLog(@"请求失败");
//                  }];

}

#pragma mark -
#pragma mark 屏幕点击事件

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [captchaTextField resignFirstResponder];
    [phoneTextField resignFirstResponder];
    [userPswField resignFirstResponder];
    [userConPswField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField ==phoneTextField)
    {
        [userPswField becomeFirstResponder];
    }
    if (textField ==userPswField)
    {
        [userConPswField becomeFirstResponder];
    }
    if (textField ==userConPswField)
    {
        [captchaTextField becomeFirstResponder];
    }
    if (textField.returnKeyType == UIReturnKeyDone)
    {
        [self loginButtonClicked:nil];
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
