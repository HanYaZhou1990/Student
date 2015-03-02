//
//  NoticeTwoViewController.m
//  AmoyMasterStudents
//
//  Created by julong on 15/3/2.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "NoticeTwoViewController.h"

@interface NoticeTwoViewController ()

@end

@implementation NoticeTwoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor =RGBA(0, 165, 109, 1);
    
    [self leftBarItem];
    
    [self setUseView];
}

- (void)leftBarItem
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"icon_return.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"icon_return.png"] forState:UIControlStateHighlighted];
    backButton.frame = CGRectMake(0, 0, 21.5, 13.5);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}
-(void)backAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)setUseView
{
    if ([self.noticeType isEqualToString:@"4"]&&[self.noticeTwoType isEqualToString:@"1"])
    {
        //上课确认 拒绝上课
        self.title = @"上课确认";
        [self setRefuseClassView];
    }
    else if ([self.noticeType isEqualToString:@"4"]&&[self.noticeTwoType isEqualToString:@"2"])
    {
        //上课确认 确认上课
        self.title = @"上课确认";
        [self setAgreeClassView];
    }
}

//拒绝上课
-(void)setRefuseClassView
{
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(10, 60, SCREEN_WIDTH-20, 280);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.masksToBounds=YES;
    bgView.layer.cornerRadius=4;
    [self.view addSubview:bgView];
    
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.frame = CGRectMake((bgView.frame.size.width-60)/2, 50, 60, 60);
    imgView.image = [UIImage imageNamed:@"icon_money.png"];
    [bgView addSubview:imgView];
    
    UILabel *promptOneLabel= [[UILabel alloc]init];
    promptOneLabel.frame = CGRectMake(40, imgView.frame.origin.y+imgView.frame.size.height+10, bgView.frame.size.width-80, 30);
    promptOneLabel.backgroundColor=[UIColor clearColor];
    promptOneLabel.textAlignment=NSTextAlignmentCenter;
    promptOneLabel.font = [UIFont boldSystemFontOfSize:20];
    promptOneLabel.textColor = RGBA(0, 165, 109, 1);
    promptOneLabel.text = @"您已拒绝本次课程";
    [bgView addSubview:promptOneLabel];
    
    UILabel *promptTwoLabel= [[UILabel alloc]init];
    promptTwoLabel.frame = CGRectMake(10, promptOneLabel.frame.origin.y+promptOneLabel.frame.size.height+10, bgView.frame.size.width-20, 16);
    promptTwoLabel.font = [UIFont systemFontOfSize:16];
    promptTwoLabel.textColor = [UIColor blackColor];
    promptTwoLabel.backgroundColor=[UIColor clearColor];
    promptTwoLabel.textAlignment=NSTextAlignmentCenter;
    promptTwoLabel.text = @"请耐心等待下次上课通知";
    [bgView addSubview:promptTwoLabel];
    
    UIButton *footBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    footBtn.frame = CGRectMake(75, promptTwoLabel.frame.origin.y+promptTwoLabel.frame.size.height+30, SCREEN_WIDTH-170, 40);
    [footBtn setBackgroundColor:[UIColor whiteColor]];
    [footBtn setTitle:@"我知道了" forState:UIControlStateNormal];
    [footBtn setTitle:@"我知道了" forState:UIControlStateHighlighted];
    [footBtn setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateNormal];
    [footBtn setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateHighlighted];
    footBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    footBtn.layer.masksToBounds=YES;
    footBtn.layer.cornerRadius=20;
    footBtn.layer.borderWidth = 1;
    footBtn.layer.borderColor = RGBA(0, 165, 109, 1).CGColor;
    footBtn.tag = 100;
    [footBtn addTarget:self action:@selector(footBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:footBtn];
    
}

//确认上课成功
-(void)setAgreeClassView
{
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(10, 60, SCREEN_WIDTH-20, 280);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.masksToBounds=YES;
    bgView.layer.cornerRadius=4;
    [self.view addSubview:bgView];
    
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.frame = CGRectMake((bgView.frame.size.width-60)/2, 50, 60, 60);
    imgView.image = [UIImage imageNamed:@"icon_money.png"];
    [bgView addSubview:imgView];
    
    UILabel *promptOneLabel= [[UILabel alloc]init];
    promptOneLabel.frame = CGRectMake(40, imgView.frame.origin.y+imgView.frame.size.height+10, bgView.frame.size.width-80, 30);
    promptOneLabel.backgroundColor=[UIColor clearColor];
    promptOneLabel.textAlignment=NSTextAlignmentCenter;
    promptOneLabel.font = [UIFont boldSystemFontOfSize:20];
    promptOneLabel.textColor = RGBA(0, 165, 109, 1);
    promptOneLabel.text = @"您已成功参与课程第三节";
    [bgView addSubview:promptOneLabel];
    
    UILabel *promptTwoLabel= [[UILabel alloc]init];
    promptTwoLabel.frame = CGRectMake(10, promptOneLabel.frame.origin.y+promptOneLabel.frame.size.height+10, bgView.frame.size.width-20, 16);
    promptTwoLabel.font = [UIFont systemFontOfSize:16];
    promptTwoLabel.textColor = [UIColor blackColor];
    promptTwoLabel.backgroundColor=[UIColor clearColor];
    promptTwoLabel.textAlignment=NSTextAlignmentCenter;
    promptTwoLabel.text = @"请您按时上课";
    [bgView addSubview:promptTwoLabel];
    
    UIButton *footBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    footBtn.frame = CGRectMake(75, promptTwoLabel.frame.origin.y+promptTwoLabel.frame.size.height+30, SCREEN_WIDTH-170, 40);
    [footBtn setBackgroundColor:[UIColor whiteColor]];
    [footBtn setTitle:@"我知道了" forState:UIControlStateNormal];
    [footBtn setTitle:@"我知道了" forState:UIControlStateHighlighted];
    [footBtn setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateNormal];
    [footBtn setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateHighlighted];
    footBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    footBtn.layer.masksToBounds=YES;
    footBtn.layer.cornerRadius=20;
    footBtn.layer.borderWidth = 1;
    footBtn.layer.borderColor = RGBA(0, 165, 109, 1).CGColor;
    footBtn.tag = 101;
    [footBtn addTarget:self action:@selector(footBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:footBtn];
}

#pragma mark Btn点击事件
-(void)footBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag)
    {
        case 100: case 101:
        {
            [self backAction];
        }
            break;
            
        default:
            break;
    }
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
