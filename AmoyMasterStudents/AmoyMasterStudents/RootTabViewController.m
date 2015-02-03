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
    
    self.tabBar.tintColor = UIColorFromRGB(0xca1407);//取tabItem颜色
    
    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      UIColorFromRGB(0xca1407), NSForegroundColorAttributeName,
      nil]forState:UIControlStateSelected];

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
