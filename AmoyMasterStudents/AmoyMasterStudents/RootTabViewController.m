//
//  RootTabViewController.m
//  AmoyMasterStudents
//
//  Created by julong on 15/2/3.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "RootTabViewController.h"
#import "KnowledgeViewController.h"
#import "CoachViewController.h"
#import "ProcessViewController.h"
#import "MemberCenterViewController.h"
#import "LoginViewController.h"

@interface RootTabViewController ()

@end

@implementation RootTabViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self initTabbarUI];
    
    //登录成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessfull) name:loginDidSuccessNotification object:nil];
    
    //退出登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutSuccessfull) name:logoutDidSuccessNotification object:nil];

}

-(void)initTabbarUI
{
    NSMutableArray *viewControllers = [[NSMutableArray alloc]init];
    
    /*学车知识*/
    KnowledgeViewController *knowledgeVC = [[KnowledgeViewController alloc]init];
    UINavigationController *knowledgeNav = [[UINavigationController alloc]initWithRootViewController:knowledgeVC];
    [viewControllers addObject:knowledgeNav];
    
    /*教练广场*/
    CoachViewController *coachVC = [[CoachViewController alloc]init];
    UINavigationController *coachNav = [[UINavigationController alloc]initWithRootViewController:coachVC];
    [viewControllers addObject:coachNav];
    
    /*学车进程*/
    ProcessViewController *processVC = [[ProcessViewController alloc]init];
    UINavigationController *processNav = [[UINavigationController alloc]initWithRootViewController:processVC];
    [viewControllers addObject:processNav];
    
    /*个人中心*/
    MemberCenterViewController *memberVC = [[MemberCenterViewController alloc]init];
    UINavigationController *memberNav = [[UINavigationController alloc]initWithRootViewController:memberVC];
    [viewControllers addObject:memberNav];
    
    self.viewControllers = viewControllers;
    
    self.tabBar.tintColor = RGBA(0, 165, 109, 1);//取tabItem颜色
    
    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      RGBA(0, 165, 109, 1), NSForegroundColorAttributeName,
      nil]forState:UIControlStateSelected];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self getLoginState]; //判断登录状态
}

#pragma mark
#pragma mark 登录相关
-(void)getLoginState
{
    NSString *loginAccount = [PublicConfig valueForKey:userAccount];
    if (loginAccount.length==0)
    {
        [self loginView];
    }
}

//弹出登陆界面
-(void)loginView
{
    //登录失败 或未登录
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginViewController];
    [self.navigationController presentViewController:nav animated:NO completion:nil];
}

//让登陆界面下去
-(void)loginSuccessfull
{
     [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

//退出登录
-(void)logoutSuccessfull
{
    [PublicConfig setValue:@"" forKey:userAccount];
    
    [self getLoginState];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
