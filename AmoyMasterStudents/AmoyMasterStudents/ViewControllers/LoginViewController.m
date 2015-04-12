//
//  LoginViewController.m
//  AmoyMasterStudents
//
//  Created by julong on 15/2/9.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "LoginViewController.h"
#import "WWTextField.h"
#import "RegisterViewController.h"
#import "ValidateTool.h"
#import "FindPwdViewController.h"
#import "AFNetworking.h"
#import "NSString+MD5.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    WWTextField          *userNameField;
    WWTextField          *userPswField;
    
}
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"登录";
    
    [self setLoginView];
    
}

#pragma mark -
#pragma mark 初始化界面

//初始化登陆界面
-(void)setLoginView
{
    userNameField = [[WWTextField alloc]initWithLeftFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, 44)];
    userNameField.placeholder = @"请输入手机号";
    userNameField.font = [UIFont systemFontOfSize:16];
    userNameField.textColor = [UIColor blackColor];
    userNameField.borderStyle = UITextBorderStyleNone;
    userNameField.delegate =self;
    userNameField.returnKeyType = UIReturnKeyNext;
    userNameField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:userNameField];
    
    
    userPswField = [[WWTextField alloc]initWithFrame:CGRectMake(userNameField.frame.origin.x, userNameField.frame.size.height+userNameField.frame.origin.y+15, userNameField.frame.size.width, userNameField.frame.size.height)];
    userPswField.placeholder = @"请输入密码";
    userPswField.font = [UIFont systemFontOfSize:16];
    userPswField.textColor = [UIColor blackColor];
    userPswField.borderStyle = UITextBorderStyleNone;
    userPswField.delegate =self;
    userPswField.returnKeyType = UIReturnKeyDone;
    userPswField.clearButtonMode = UITextFieldViewModeWhileEditing;
    userPswField.secureTextEntry = YES;//密码样式
    [self.view addSubview:userPswField];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(userNameField.frame.origin.x, userPswField.frame.size.height+userPswField.frame.origin.y+20 , userNameField.frame.size.width, 50);
    [loginButton setBackgroundColor:RGBA(0, 165, 109, 1)];
    [loginButton setTitle:@"登  录" forState:UIControlStateNormal];
    [loginButton setTitle:@"登  录" forState:UIControlStateHighlighted];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    loginButton.layer.masksToBounds=YES;
    loginButton.layer.cornerRadius=4;
    [loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    //找回密码
    UILabel *findPwdLabel = [[UILabel alloc]init];
    findPwdLabel.frame = CGRectMake(loginButton.frame.origin.x, loginButton.frame.size.height+loginButton.frame.origin.y+15, 140, 20);
    findPwdLabel.backgroundColor = [UIColor clearColor];
    findPwdLabel.text = @"找回密码";
    findPwdLabel.textColor = RGBA(0, 165, 109, 1);
    findPwdLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:findPwdLabel];
    
    
    UIButton *findPwdButton =[UIButton buttonWithType:UIButtonTypeCustom];
    findPwdButton.backgroundColor = [UIColor clearColor];
    findPwdButton.frame = CGRectMake(findPwdLabel.frame.origin.x,findPwdLabel.frame.origin.y, findPwdLabel.frame.size.width, findPwdLabel.frame.size.height);
    [findPwdButton addTarget:self action:@selector(findPwdButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:findPwdButton];
    
    
    UILabel *registerLabel = [[UILabel alloc]init];
    registerLabel.frame = CGRectMake(SCREEN_WIDTH-160, loginButton.frame.size.height+loginButton.frame.origin.y+15, 140, 20);
    registerLabel.backgroundColor = [UIColor clearColor];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"没有账号?立即注册"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0,5)];
    [str addAttribute:NSForegroundColorAttributeName value:RGBA(0, 165, 109, 1) range:NSMakeRange(5,4)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 5)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(5, 4)];
//    [str addAttribute:NSUnderlineStyleAttributeName value:(id)[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, 9)];
    registerLabel.attributedText = str;
    registerLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:registerLabel];
    
    
    UIButton *registerButton =[UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.backgroundColor = [UIColor clearColor];
    registerButton.frame = CGRectMake(registerLabel.frame.origin.x,registerLabel.frame.origin.y, registerLabel.frame.size.width, registerLabel.frame.size.height);
    [registerButton addTarget:self action:@selector(registerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
   
    
}

#pragma mark -
#pragma mark 按钮点击事件
//找回密码
-(void)findPwdButtonClicked:(id)sender
{
    FindPwdViewController *vc = [[FindPwdViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//立即注册点击
-(void)registerButtonClicked:(id)sender
{
    RegisterViewController *vc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//登录点击
-(void)loginButtonClicked:(id)sender
{
    //验证不可为空
    [userNameField resignFirstResponder];
    [userPswField resignFirstResponder];
    
     NSString *phoneStr = [userNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
     NSString *pwdStr = [userPswField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //验证手机号码
    if (phoneStr==nil||[phoneStr isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"手机号码不能为空"];
        return;
    }
    else
    {
        //手机号码2
        BOOL isUsed = [ValidateTool validateMobile:phoneStr];
        if (isUsed==NO)
        {
            [PublicConfig waringInfo:@"手机号码格式不正确"];
            userPswField.text = nil;
            return;
        }
    }
    
    //验证密码
    if (pwdStr==nil||[pwdStr isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"密码不能为空"];
        [userPswField becomeFirstResponder];
        return;
    }

    [self sendLoginData]; //发送登录协议
}

//登录协议
-(void)sendLoginData
{
    [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"登录中..." animated:YES];
    
    NSString *useUrl = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL,trainee_traineeRead_login];
    NSString *md5Password = [NSString md5StringFromString:userPswField.text];
    
    // 取出push的deviceToken
//    NSString *documentDirectorty = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES)[0];
//    NSString *path = [documentDirectorty stringByAppendingPathComponent:DeviceTokenFileName];
//    NSDictionary *deviceTokenDict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:DEST_PATH_DeviceToken];
    DLog(@"dict --- %@", dict);
    NSString *deviceToken = dict[@"deviceToken"];
    
    if (!deviceToken) {
        deviceToken = @"";
    }
    NSDictionary *params = @{@"account":userNameField.text,@"password":md5Password,@"push_token":deviceToken,@"push_account":userNameField.text,@"type":@"2"}; //type 设备类型(1android 2iphone)
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:useUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
                          {
                              [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                              
                              NSDictionary *responseDic = (NSDictionary *)responseObject;
                              
                              //打印结果 方便查看
                              NSString *responseString = [PublicConfig dictionaryToJson:responseDic];
                              DLog(@"返回结果字符串 : %@",responseString);
                              
                              NSString *resultCode = [responseDic valueForKey:@"code"]; //0成功 1失败
                              if ([resultCode boolValue]==NO)
                              {
                                  [PublicConfig setValue:userNameField.text forKey:userAccount];
                                  
                                  [PublicConfig setValue:md5Password forKey:userPassword];
                                  
                                  NSString *dataStr = [responseDic valueForKey:@"data"];
                                  dataStr = [PublicConfig isSpaceString:@"" andReplace:dataStr];
                                  [PublicConfig setValue:dataStr forKey:userToken];
                                  
                                  //发送登录协议
                                  [[NSNotificationCenter defaultCenter]postNotificationName:loginDidSuccessNotification object:nil];
                              }
                              else
                              {
                                  NSString *msgStr = [responseDic valueForKey:@"msg"];
                                  //[SVProgressHUD showErrorWithStatus:[PublicConfig isSpaceString:msgStr andReplace:@"登录失败"]];
                                  [PublicConfig waringInfo:[PublicConfig isSpaceString:msgStr andReplace:@"登录失败"]];
                              }
                          }
                               failure:^(AFHTTPRequestOperation *operation, NSError *error)
                          {
                              [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                              //[SVProgressHUD showErrorWithStatus:@"登录请求失败"];
                              [PublicConfig waringInfo:@"登录请求失败"];
                          }]; 
}

#pragma mark -
#pragma mark 屏幕点击事件
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [userNameField resignFirstResponder];
    [userPswField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField ==userNameField)
    {
        [userPswField becomeFirstResponder];
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
