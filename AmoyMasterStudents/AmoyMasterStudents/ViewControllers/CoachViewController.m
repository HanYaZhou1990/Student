//
//  CoachViewController.m
//  Student
//
//  Created by Han_YaZhou on 15/2/2.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import "CoachViewController.h"
#import "WWMenuView.h"

@interface CoachViewController ()<WWMenuViewDelegate>
{
    
}
@end

@implementation CoachViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
        {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"教练广场" image:[UIImage imageNamed:@"icon_main_square.png"] selectedImage:[UIImage imageNamed:@"icon_main_square.png"]];
        }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"教练广场";
    
    [self setTopBtnView];
}

-(void)setTopBtnView
{
    WWMenuView *menuView = [[WWMenuView alloc]init];
    menuView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    menuView.delegate = self;
    menuView.imageWidth = 30.0f;
    menuView.btnInformationAry = @[
                                   @[@"附近",[UIImage imageNamed:@"icon_location.png"],[UIImage imageNamed:@"icon_location_active.png"]],
                                   @[@"最便宜",[UIImage imageNamed:@"icon_cheap.png"],[UIImage imageNamed:@"icon_cheap_active.png"]],
                                   @[@"评价最好",[UIImage imageNamed:@"icon_evaluation.png"],[UIImage imageNamed:@"icon_evaluation_active.png"]],
                                   @[@"学员最多",[UIImage imageNamed:@"icon_trainee.png"],[UIImage imageNamed:@"icon_trainee_active.png"]],
                                   @[@"驾照类型",[UIImage imageNamed:@"icon_knowledge.png"],[UIImage imageNamed:@"icon_knowledge_active.png"]]];
    [self.view addSubview:menuView];
    
}

#pragma mark WWMenuViewDelegate

- (void)view:(UIView *)view didSelectIndex:(NSInteger)indexOfButton
{
    DLog(@"%ld",(long)indexOfButton);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
