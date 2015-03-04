//
//  ChangePhoneViewController.m
//  AmoyMasterStudents
//
//  Created by julong on 15/2/9.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "ChangePhoneViewController.h"
#import "WWTextField.h"
#import "ValidateTool.h"
#import "AFNetworking.h"

@interface ChangePhoneViewController ()<UITextFieldDelegate>
{
    WWTextField *phoneTextField;
    WWTextField *userNewPhoneField;
    WWTextField *userConPswField;
    WWTextField *captchaTextField;
    
    UIButton *captchaBtn;
    
    AFHTTPRequestOperation *validOperation;
    AFHTTPRequestOperation *operation;
}

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) int miao;

@end

@implementation ChangePhoneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"修改联系方式";
    
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
    [operation cancel];
    operation=nil;
    [validOperation cancel];
    validOperation=nil;
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
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
    phoneTextField.placeholder = @"请输入原手机号码";
    phoneTextField.returnKeyType = UIReturnKeyNext;
    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:phoneTextField];
    
    userNewPhoneField = [[WWTextField alloc]initWithFrame:CGRectMake(phoneTextField.frame.origin.x, phoneTextField.frame.size.height+phoneTextField.frame.origin.y+10, phoneTextField.frame.size.width, phoneTextField.frame.size.height)];
    userNewPhoneField.font = [UIFont systemFontOfSize:16];
    userNewPhoneField.textColor = [UIColor blackColor];
    userNewPhoneField.borderStyle = UITextBorderStyleNone;
    userNewPhoneField.delegate =self;
    userNewPhoneField.placeholder = @"请输入新手机号码";
    userNewPhoneField.returnKeyType = UIReturnKeyNext;
    userNewPhoneField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:userNewPhoneField];
    
    userConPswField = [[WWTextField alloc]initWithFrame:CGRectMake(phoneTextField.frame.origin.x, userNewPhoneField.frame.size.height+userNewPhoneField.frame.origin.y+10, phoneTextField.frame.size.width, phoneTextField.frame.size.height)];
    userConPswField.placeholder = @"请确认新密码";
    userConPswField.font = [UIFont systemFontOfSize:16];
    userConPswField.textColor = [UIColor blackColor];
    userConPswField.borderStyle = UITextBorderStyleNone;
    userConPswField.returnKeyType = UIReturnKeyNext;
    userConPswField.delegate = self;
    userConPswField.secureTextEntry = YES;//密码样式
    [self.view addSubview:userConPswField];
    
    captchaTextField = [[WWTextField alloc]initWithFrame:CGRectMake(userConPswField.frame.origin.x, userConPswField.frame.size.height+userConPswField.frame.origin.y+10, SCREEN_WIDTH-60-120, userConPswField.frame.size.height)];
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
    [userNewPhoneField resignFirstResponder];
    
    NSString *phoneStr = [userNewPhoneField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (phoneStr==nil||[phoneStr isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"新手机号码不能为空"];
        [userNewPhoneField becomeFirstResponder];
        return;
    }
    else
    {
        //手机号码2
        BOOL isUsed = [ValidateTool validateMobile:phoneStr];
        if (isUsed==NO)
        {
            [PublicConfig waringInfo:@"手机号码格式不正确"];
            [userNewPhoneField becomeFirstResponder];
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
    [userNewPhoneField resignFirstResponder];
    [userConPswField resignFirstResponder];
    
    NSString *phoneStr = [phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *newPhoneStr = [userNewPhoneField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
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
    
    if (newPhoneStr==nil||[newPhoneStr isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"新手机号不能为空"];
        return;
    }
    else
    {
        //手机号码2
        BOOL isUsed = [ValidateTool validateMobile:newPhoneStr];
        if (isUsed==NO)
        {
            [PublicConfig waringInfo:@"新手机号码格式不正确"];
            [userNewPhoneField becomeFirstResponder];
            return;
        }
        else
        {
            if ([phoneStr isEqualToString:newPhoneStr])
            {
                [PublicConfig waringInfo:@"两次输入号码一致"];
                return;
            }
        }
    }
    
    
    if (conPwdStr==nil||[conPwdStr isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"确认密码不能为空"];
        return;
    }
    
    if (captchaStr==nil||[captchaStr isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"验证码不能为空"];
        [captchaTextField becomeFirstResponder];
        return;
    }
    
    //验证后成功后发送请求
    [self setUserData:phoneStr andNewPhone:newPhoneStr andPassword:conPwdStr andPassCode:captchaStr];
    
}

-(void)loginButtonClicked:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark 请求相关

-(void)setUserData:(NSString *)phoneNumber andNewPhone:(NSString *)newPhoneNumer andPassword:(NSString *)password andPassCode:(NSString *)passCode
{
    [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"修改联系方式中..." animated:YES];
    
    NSString *useUrl = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL,trainee_traineeWrite_updateContact];
    
    NSDictionary *params = @{@"cellphone":phoneNumber,@"cellphoneNew":newPhoneNumer,@"password":password,@"vCode":passCode,@"token":userToken};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    operation =  [manager POST:useUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
                         {
                             [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                             
                             NSDictionary *responseDic = (NSDictionary *)responseObject;
                             
                             //打印结果 方便查看
                             NSString *responseString = [PublicConfig dictionaryToJson:responseDic];
                             DLog(@"返回结果字符串 : %@",responseString);
                             
                             NSString *resultCode = [responseDic valueForKey:@"code"]; //0成功 1失败
                             if ([resultCode boolValue]==NO)
                             {
                                 [[NSNotificationCenter defaultCenter]postNotificationName:refreshMemberCenterVCNotification object:nil];
                                 [self.navigationController popViewControllerAnimated:YES];
                             }
                             else
                             {
                                 NSString *msgStr = [responseDic valueForKey:@"msg"];
                                 [SVProgressHUD showErrorWithStatus:[PublicConfig isSpaceString:msgStr andReplace:@"修改联系方式失败"]];
                             }
                         }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error)
                         {
                             [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                             [SVProgressHUD showErrorWithStatus:@"修改联系方式请求失败"];
                         }];
}

//给用户发送短信验证码
-(void)getValidCodeData:(NSString *)hp
{
    [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"获取验证码中..." animated:YES];
    
    NSString *useUrl = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL,trainee_traineeRead_sendUpdateContactSMS];
    
    NSDictionary *params = @{@"cellphone":hp,@"token":userToken};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    validOperation =  [manager POST:useUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
                       {
                           [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                           
                           NSDictionary *responseDic = (NSDictionary *)responseObject;
                           
                           //打印结果 方便查看
                           NSString *responseString = [PublicConfig dictionaryToJson:responseDic];
                           DLog(@"返回结果字符串 : %@",responseString);
                           
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
    [userNewPhoneField resignFirstResponder];
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
        [userNewPhoneField becomeFirstResponder];
    }
    if (textField ==userNewPhoneField)
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
