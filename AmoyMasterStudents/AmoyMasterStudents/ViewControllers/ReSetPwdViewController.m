//
//  ReSetPwdViewController.m
//  AmoyMasterStudents
//
//  Created by julong on 15/2/9.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "ReSetPwdViewController.h"
#import "WWTextField.h"
#import "RegisterViewController.h"
#import "AFNetworking.h"

@interface ReSetPwdViewController ()<UITextFieldDelegate>
{
    WWTextField *userPswField;
    WWTextField *userConPswField; //确认密码
    
    AFHTTPRequestOperation *operation;
    
}
@end

@implementation ReSetPwdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"重置密码";
    
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
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark 初始化界面

-(void)setUseView
{
    userPswField = [[WWTextField alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, 44)];
    userPswField.placeholder = @"请输入密码";
    userPswField.font = [UIFont systemFontOfSize:16];
    userPswField.textColor = [UIColor blackColor];
    userPswField.borderStyle = UITextBorderStyleNone;
    userPswField.returnKeyType = UIReturnKeyNext;
    userPswField.delegate = self;
    userPswField.secureTextEntry = YES;//密码样式
    [self.view addSubview:userPswField];
    
    userConPswField = [[WWTextField alloc]initWithFrame:CGRectMake(userPswField.frame.origin.x, userPswField.frame.size.height+userPswField.frame.origin.y+15, userPswField.frame.size.width, userPswField.frame.size.height)];
    userConPswField.placeholder = @"确认新密码";
    userConPswField.font = [UIFont systemFontOfSize:16];
    userConPswField.textColor = [UIColor blackColor];
    userConPswField.borderStyle = UITextBorderStyleNone;
    userConPswField.returnKeyType = UIReturnKeyDone;
    userConPswField.delegate = self;
    userConPswField.secureTextEntry = YES;//密码样式
    [self.view addSubview:userConPswField];
    
    UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    finishButton.frame = CGRectMake(userPswField.frame.origin.x, userConPswField.frame.size.height+userConPswField.frame.origin.y+20, userPswField.frame.size.width, 50);
    [finishButton setBackgroundColor:RGBA(0, 165, 109, 1)];
    [finishButton setTitle:@"完  成" forState:UIControlStateNormal];
    [finishButton setTitle:@"完  成" forState:UIControlStateHighlighted];
    [finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finishButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    finishButton.layer.masksToBounds=YES;
    finishButton.layer.cornerRadius=4;
    [finishButton addTarget:self action:@selector(finishButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishButton];
    
    UILabel *registerLabel = [[UILabel alloc]init];
    registerLabel.frame = CGRectMake(SCREEN_WIDTH-160, finishButton.frame.size.height+finishButton.frame.origin.y+15, 140, 20);
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

#pragma mark -
#pragma mark 按钮点击事件
-(void)finishButtonClick
{
    [userPswField resignFirstResponder];
    [userConPswField resignFirstResponder];
    
    NSString *pwdStr = [userPswField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *conPwdStr = [userConPswField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
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
    
    //验证后成功后发送请求
    [self changePwdDataByPassword:pwdStr];
    
}

//立即注册点击
-(void)registerButtonClicked:(id)sender
{
    RegisterViewController *vc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark 请求相关
//完成请求
-(void)changePwdDataByPassword:(NSString *)password
{
    [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"重置密码中..." animated:YES];
    
    NSString *useUrl = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL,trainee_traineeWrite_resetPassword];
    
    NSString *tokenStr = [PublicConfig isSpaceString:self.dataStr andReplace:@""];
    
    NSDictionary *params = @{@"token":tokenStr,@"password":password,@"password_":password,@"token":userToken};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    operation =  [manager POST:useUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
                         {
                             [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                             
                             NSDictionary *responseDic = (NSDictionary *)responseObject;
                             NSString *resultCode = [responseDic valueForKey:@"code"]; //0成功 1失败
                             if ([resultCode boolValue]==NO)
                             {
                                 //修改成功 返回去登陆
                                 [self.navigationController popToRootViewControllerAnimated:YES];
                             }
                             else
                             {
                                 NSString *msgStr = [responseDic valueForKey:@"msg"];
                                 [SVProgressHUD showErrorWithStatus:[PublicConfig isSpaceString:msgStr andReplace:@"重置密码失败"]];
                             }
                         }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error)
                         {
                             [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                             [SVProgressHUD showErrorWithStatus:@"重置密码请求失败"];
                         }]; 
}
#pragma mark -
#pragma mark 屏幕点击事件

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
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
    if (textField ==userPswField)
    {
        [userConPswField becomeFirstResponder];
    }
    if (textField.returnKeyType == UIReturnKeyDone)
    {
        [self finishButtonClick];
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
