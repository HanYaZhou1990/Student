//
//  RootBarViewController.m
//  Student
//
//  Created by Han_YaZhou on 15/2/2.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import "RootBarViewController.h"
#import "AppDelegate.h"

@interface RootBarViewController ()

@end

@implementation RootBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc]init];
    
    /**/
    KnowledgeViewController *knowledgeVC = [[KnowledgeViewController alloc]init];
    UINavigationController *knowledgeNav = [[UINavigationController alloc]initWithRootViewController:knowledgeVC];
    [viewControllers addObject:knowledgeNav];
    
    /**/
    CoachViewController *coachVC = [[CoachViewController alloc]init];
    UINavigationController *coachNav = [[UINavigationController alloc]initWithRootViewController:coachVC];
    [viewControllers addObject:coachNav];
    
    /**/
    ProcessViewController *processVC = [[ProcessViewController alloc]init];
    UINavigationController *processNav = [[UINavigationController alloc]initWithRootViewController:processVC];
    [viewControllers addObject:processNav];
    
    /**/
    MemberCenterViewController *memberVC = [[MemberCenterViewController alloc]init];
    UINavigationController *memberNav = [[UINavigationController alloc]initWithRootViewController:memberVC];
    [viewControllers addObject:memberNav];
    
    self.viewControllers = viewControllers;
    
    self.tabBar.tintColor = UIColorFromRGB(0xca1407);//取tabItem颜色 橘色
    
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
