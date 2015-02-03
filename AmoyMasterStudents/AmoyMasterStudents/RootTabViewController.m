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

@interface RootTabViewController ()

@end

@implementation RootTabViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self initTabbarUI];
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
    
    self.tabBar.tintColor = UIColorFromRGB(0xca1407);//取tabItem颜色
    
    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      UIColorFromRGB(0xca1407), NSForegroundColorAttributeName,
      nil]forState:UIControlStateSelected];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
