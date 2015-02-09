//
//  ChangePwdViewController.m
//  AmoyMasterStudents
//
//  Created by julong on 15/2/9.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "ChangePwdViewController.h"
#import "WWTextField.h"
#import "ValidateTool.h"

@interface ChangePwdViewController ()<UITextFieldDelegate>
{
    WWTextField *phoneTextField;
    WWTextField *userOldPswField;
    WWTextField *userPswField;
    WWTextField *userConPswField;
    WWTextField *captchaTextField;
    
    UIButton *captchaBtn;
}

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) int miao;
@end

@implementation ChangePwdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"修改密码";
    
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
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark 初始化界面

-(void)setUseView
{
    phoneTextField = [[WWTextField alloc]initWithLeftFrame:CGRectMake(20, 15, SCREEN_WIDTH-40, 44)];
    phoneTextField.font = [UIFont systemFontOfSize:16];
    phoneTextField.textColor = [UIColor blackColor];
    phoneTextField.borderStyle = UITextBorderStyleNone;
    phoneTextField.delegate =self;
    phoneTextField.placeholder = @"请输入手机号码";
    if (self.phoneStr.length>0)
    {
        phoneTextField.text = self.phoneStr;
    }
    phoneTextField.returnKeyType = UIReturnKeyNext;
    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:phoneTextField];
    
    userOldPswField = [[WWTextField alloc]initWithFrame:CGRectMake(phoneTextField.frame.origin.x, phoneTextField.frame.size.height+phoneTextField.frame.origin.y+10, phoneTextField.frame.size.width, phoneTextField.frame.size.height)];
    userOldPswField.placeholder = @"请输入原密码";
    userOldPswField.font = [UIFont systemFontOfSize:16];
    userOldPswField.textColor = [UIColor blackColor];
    userOldPswField.borderStyle = UITextBorderStyleNone;
    userOldPswField.returnKeyType = UIReturnKeyNext;
    userOldPswField.delegate = self;
    userOldPswField.secureTextEntry = YES;//密码样式
    [self.view addSubview:userOldPswField];
    
    userPswField = [[WWTextField alloc]initWithFrame:CGRectMake(userOldPswField.frame.origin.x, userOldPswField.frame.size.height+userOldPswField.frame.origin.y+10, userOldPswField.frame.size.width, userOldPswField.frame.size.height)];
    userPswField.placeholder = @"请输入新密码";
    userPswField.font = [UIFont systemFontOfSize:16];
    userPswField.textColor = [UIColor blackColor];
    userPswField.borderStyle = UITextBorderStyleNone;
    userPswField.returnKeyType = UIReturnKeyNext;
    userPswField.delegate = self;
    userPswField.secureTextEntry = YES;//密码样式
    [self.view addSubview:userPswField];
    
    userConPswField = [[WWTextField alloc]initWithFrame:CGRectMake(phoneTextField.frame.origin.x, userPswField.frame.size.height+userPswField.frame.origin.y+10, phoneTextField.frame.size.width, phoneTextField.frame.size.height)];
    userConPswField.placeholder = @"请确认新密码";
    userConPswField.font = [UIFont systemFontOfSize:16];
    userConPswField.textColor = [UIColor blackColor];
    userConPswField.borderStyle = UITextBorderStyleNone;
    userConPswField.returnKeyType = UIReturnKeyNext;
    userConPswField.delegate = self;
    userConPswField.secureTextEntry = YES;//密码样式
    [self.view addSubview:userConPswField];
    
    captchaTextField = [[WWTextField alloc]initWithFrame:CGRectMake(userPswField.frame.origin.x, userConPswField.frame.size.height+userConPswField.frame.origin.y+10, SCREEN_WIDTH-60-120, userPswField.frame.size.height)];
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
    
    UIButton *changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    changeButton.frame = CGRectMake(phoneTextField.frame.origin.x, captchaTextField.frame.size.height+captchaTextField.frame.origin.y+15, phoneTextField.frame.size.width, 50);
    [changeButton setBackgroundColor:RGBA(0, 165, 109, 1)];
    [changeButton setTitle:@"确认修改" forState:UIControlStateNormal];
    [changeButton setTitle:@"确认修改" forState:UIControlStateHighlighted];
    [changeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changeButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    changeButton.layer.masksToBounds=YES;
    changeButton.layer.cornerRadius=4;
    [changeButton addTarget:self action:@selector(changeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeButton];
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

//确认修改
-(void)changeButtonClick
{
    //发送确认修改请求 请求成功返回
    [captchaTextField resignFirstResponder];
    [phoneTextField resignFirstResponder];
    [userOldPswField resignFirstResponder];
    [userPswField resignFirstResponder];
    [userConPswField resignFirstResponder];
    
    NSString *phoneStr = [phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *oldPwdStr = [userOldPswField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
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
    
    if (oldPwdStr==nil||[oldPwdStr isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"原密码不能为空"];
        [userPswField becomeFirstResponder];
        return;
    }
    else
    {
        NSString *userPwdStr = [PublicConfig valueForKey:userPassword];
        if (![userPwdStr isEqualToString:oldPwdStr])
        {
            [PublicConfig waringInfo:@"原密码输入不正确"];
        }
    }
    
    if (pwdStr==nil||[pwdStr isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"密码不能为空"];
        [userPswField becomeFirstResponder];
        return;
    }
    else
    {
        if ([oldPwdStr isEqualToString:pwdStr])
        {
            [PublicConfig waringInfo:@"新密码与原密码一样"];
            return;
        }
    }
    
    if (conPwdStr==nil||[conPwdStr isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"确认新密码不能为空"];
        [userPswField becomeFirstResponder];
        return;
    }
    else
    {
        if (![pwdStr isEqualToString:conPwdStr])
        {
            [PublicConfig waringInfo:@"两次新密码输入不一致"];
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
    [self setUserData:phoneStr andPassword:pwdStr andPassCode:captchaStr];
    
}

-(void)loginButtonClicked:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark 请求相关

-(void)setUserData:(NSString *)phoneNumber andPassword:(NSString *)password andPassCode:(NSString *)passCode
{
    [[NSNotificationCenter defaultCenter]postNotificationName:refreshMemberCenterVCNotification object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

//给用户发送短信验证码
-(void)getValidCodeData:(NSString *)hp
{
    
}

#pragma mark -
#pragma mark 屏幕点击事件

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [captchaTextField resignFirstResponder];
    [phoneTextField resignFirstResponder];
    [userOldPswField resignFirstResponder];
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
        [userOldPswField becomeFirstResponder];
    }
    if (textField ==userOldPswField)
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
