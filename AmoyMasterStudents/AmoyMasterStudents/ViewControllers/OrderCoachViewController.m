//
//  OrderCoachViewController.m
//  AmoyMasterStudents
//
//  Created by julong on 15/2/11.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "OrderCoachViewController.h"

@interface OrderCoachViewController ()

@end

@implementation OrderCoachViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"预约结果";
    
    [self leftBarItem];
    
    [self setView];

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

//初始化界面
-(void)setView
{
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.frame = CGRectMake((SCREEN_WIDTH-59)/2, 60, 59, 59);
    [self.view addSubview:imgView];
    
    UILabel *scoreLabel= [[UILabel alloc]init];
    scoreLabel.frame = CGRectMake(10, imgView.frame.origin.y+imgView.frame.size.height+10, SCREEN_WIDTH-20, 50);
    scoreLabel.backgroundColor=[UIColor clearColor];
    scoreLabel.textAlignment=NSTextAlignmentCenter;
    scoreLabel.font = [UIFont boldSystemFontOfSize:24];
    scoreLabel.textColor = RGBA(0, 165, 109, 1);
    [self.view addSubview:scoreLabel];
    
    UILabel *promptOneLabel= [[UILabel alloc]init];
    promptOneLabel.frame = CGRectMake(10, scoreLabel.frame.origin.y+scoreLabel.frame.size.height+10, SCREEN_WIDTH-20, 20);
    promptOneLabel.font = [UIFont systemFontOfSize:16];
    promptOneLabel.textColor = [UIColor grayColor];
    promptOneLabel.backgroundColor=[UIColor clearColor];
    promptOneLabel.textAlignment=NSTextAlignmentCenter;
    promptOneLabel.numberOfLines = 2;
    [self.view addSubview:promptOneLabel];
    
    if ([self.orderType isEqualToString:@"1"])
    {
        //通过
        imgView.image = [UIImage imageNamed:@"icon_success.png"];
        scoreLabel.text = @"恭喜您预约成功!";
        promptOneLabel.text = @"您可以等待教练联系您，也可以致电教练进行沟通";
    }
   else
   {
        //未通过
        imgView.image = [UIImage imageNamed:@"test_ico_suc.png"];
       scoreLabel.text = @"预约失败!";
       promptOneLabel.text = @"请尝试换个时间预约该教练";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
