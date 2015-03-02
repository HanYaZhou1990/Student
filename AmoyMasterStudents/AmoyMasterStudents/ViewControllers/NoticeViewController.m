//
//  NoticeViewController.m
//  AmoyMasterStudents
//
//  Created by julong on 15/2/28.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeTwoViewController.h"
@interface NoticeViewController ()

@end

@implementation NoticeViewController
@synthesize noticeType;

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
    if ([noticeType isEqualToString:@"1"])
    {
        //缴费通知
        self.title = @"缴费通知";
        [self setPaymentNoticeView];
    }
    else if ([noticeType isEqualToString:@"2"])
    {
        //录入成绩
          self.title = @"录入成绩";
        [self setInputScoreView];
    }
    else if ([noticeType isEqualToString:@"3"])
    {
        //成绩确认
          self.title = @"成绩确认";
        [self setScoreConfirmView];
    }
    else if ([noticeType isEqualToString:@"4"])
    {
        //上课确认 课程请求
          self.title = @"上课确认";
        [self setCurriculumRequestView];
    }
    else if ([noticeType isEqualToString:@"5"])
    {
        //上课确认 开始上课
        self.title = @"上课确认";
        [self setClassesBeginView];
    }
    else if ([noticeType isEqualToString:@"6"])
    {
        //上课确认 上课结束
        self.title = @"上课确认";
        [self setClassesEndView];
    }
    else if ([noticeType isEqualToString:@"7"])
    {
        //课程评价 打赏教练
        self.title = @"课程评价";
        [self setRewardsManagerView];
    }
    else if ([noticeType isEqualToString:@"8"])
    {
        //课程评价 教练评分原因
        self.title = @"课程评价";
        [self setCoachCommentReasonView];
    }
    else if ([noticeType isEqualToString:@"9"])
    {
        //投诉
        self.title = @"投诉";
        [self setComplaintView];
    }
    else if ([noticeType isEqualToString:@"10"])
    {
        //课程分享
        self.title = @"课程分享";
        [self setShareView];
    }
    
}

#pragma mark 缴费通知
-(void)setPaymentNoticeView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(10, 60, SCREEN_WIDTH-20, 300);
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.frame = CGRectMake((bgView.frame.size.width-60)/2, 0, 60, 60);
    imgView.image = [UIImage imageNamed:@"icon_money.png"];
    [bgView addSubview:imgView];
    
    UILabel *promptOneLabel= [[UILabel alloc]init];
    promptOneLabel.frame = CGRectMake(40, imgView.frame.origin.y+imgView.frame.size.height+10, bgView.frame.size.width-80, 60);
    promptOneLabel.backgroundColor=[UIColor clearColor];
    promptOneLabel.textAlignment=NSTextAlignmentCenter;
    promptOneLabel.numberOfLines = 2;
    promptOneLabel.font = [UIFont boldSystemFontOfSize:20];
    promptOneLabel.textColor = RGBA(0, 165, 109, 1);
    promptOneLabel.text = @"教练马大仙通知您缴纳补考费用100元";
    [bgView addSubview:promptOneLabel];
    
    UILabel *promptTwoLabel= [[UILabel alloc]init];
    promptTwoLabel.frame = CGRectMake(10, promptOneLabel.frame.origin.y+promptOneLabel.frame.size.height+10, bgView.frame.size.width-20, 16);
    promptTwoLabel.font = [UIFont systemFontOfSize:16];
    promptTwoLabel.textColor = [UIColor grayColor];
    promptTwoLabel.backgroundColor=[UIColor clearColor];
    promptTwoLabel.textAlignment=NSTextAlignmentCenter;
    promptTwoLabel.text = @"缴费完成才可以进入补考排期";
    [bgView addSubview:promptTwoLabel];
    
    UILabel *promptThreeLabel= [[UILabel alloc]init];
    promptThreeLabel.frame = CGRectMake(10, promptTwoLabel.frame.origin.y+promptTwoLabel.frame.size.height+5, bgView.frame.size.width-20, 32);
    promptThreeLabel.font = [UIFont systemFontOfSize:16];
    promptThreeLabel.textColor = [UIColor grayColor];
    promptThreeLabel.backgroundColor=[UIColor clearColor];
    promptThreeLabel.textAlignment=NSTextAlignmentCenter;
    promptThreeLabel.numberOfLines = 2;
    promptThreeLabel.text = @"缴费地址:郑州市金水区。";
    [bgView addSubview:promptThreeLabel];
 
    UIButton *footBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    footBtn.frame = CGRectMake(75, promptThreeLabel.frame.origin.y+promptThreeLabel.frame.size.height+20, SCREEN_WIDTH-170, 30);
    [footBtn setBackgroundColor:RGBA(0, 165, 109, 1)];
    [footBtn setTitle:@"我知道了" forState:UIControlStateNormal];
    [footBtn setTitle:@"我知道了" forState:UIControlStateHighlighted];
    [footBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    footBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    footBtn.layer.masksToBounds=YES;
    footBtn.layer.cornerRadius=15;
    footBtn.tag = 100;
    [footBtn addTarget:self action:@selector(footBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:footBtn];
    
}

#pragma mark 录入成绩
-(void)setInputScoreView
{
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(10, 60, SCREEN_WIDTH-20, 300);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.masksToBounds=YES;
    bgView.layer.cornerRadius=4;
    [self.view addSubview:bgView];
    
    UILabel *promptOneLabel= [[UILabel alloc]init];
    promptOneLabel.frame = CGRectMake(40, 30, bgView.frame.size.width-80, 30);
    promptOneLabel.backgroundColor=[UIColor clearColor];
    promptOneLabel.textAlignment=NSTextAlignmentCenter;
    promptOneLabel.numberOfLines = 2;
    promptOneLabel.font = [UIFont boldSystemFontOfSize:20];
    promptOneLabel.textColor = RGBA(0, 165, 109, 1);
    promptOneLabel.text = @"您已完成科目二考试";
    [bgView addSubview:promptOneLabel];
    
    UILabel *promptTwoLabel= [[UILabel alloc]init];
    promptTwoLabel.frame = CGRectMake(10, promptOneLabel.frame.origin.y+promptOneLabel.frame.size.height+10, bgView.frame.size.width-20, 16);
    promptTwoLabel.font = [UIFont boldSystemFontOfSize:16];
    promptTwoLabel.textColor = RGBA(0, 165, 109, 1);
    promptTwoLabel.backgroundColor=[UIColor clearColor];
    promptTwoLabel.textAlignment=NSTextAlignmentCenter;
    promptTwoLabel.text = @"现在需要录入您的考试成绩";
    [bgView addSubview:promptTwoLabel];
    
    UILabel *promptThreeLabel= [[UILabel alloc]init];
    promptThreeLabel.frame = CGRectMake(10, promptTwoLabel.frame.origin.y+promptTwoLabel.frame.size.height+30, bgView.frame.size.width-20, 16);
    promptThreeLabel.font = [UIFont boldSystemFontOfSize:16];
    promptThreeLabel.textColor = [UIColor blackColor];
    promptThreeLabel.backgroundColor=[UIColor clearColor];
    promptThreeLabel.textAlignment=NSTextAlignmentCenter;
    promptThreeLabel.numberOfLines = 2;
    promptThreeLabel.text = @"科目二成绩:";
    [bgView addSubview:promptThreeLabel];
    
    UILabel *promptFourLabel= [[UILabel alloc]init];
    promptFourLabel.frame = CGRectMake(30, promptThreeLabel.frame.origin.y+promptThreeLabel.frame.size.height+15, bgView.frame.size.width-60, 60);
    promptFourLabel.font = [UIFont systemFontOfSize:36];
    promptFourLabel.textColor = [UIColor blackColor];
    promptFourLabel.backgroundColor=RGBA(235, 235, 235, 1);
    promptFourLabel.textAlignment=NSTextAlignmentCenter;
    promptFourLabel.text = @"97";
    promptFourLabel.layer.masksToBounds=YES;
    promptFourLabel.layer.cornerRadius=2;
    [bgView addSubview:promptFourLabel];
    
    UIButton *footBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    footBtn.frame = CGRectMake(75, promptFourLabel.frame.origin.y+promptFourLabel.frame.size.height+30, SCREEN_WIDTH-170, 40);
    [footBtn setBackgroundColor:[UIColor whiteColor]];
    [footBtn setTitle:@"确认科目二成绩" forState:UIControlStateNormal];
    [footBtn setTitle:@"确认科目二成绩" forState:UIControlStateHighlighted];
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

#pragma mark 成绩确认
-(void)setScoreConfirmView
{
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(10, 60, SCREEN_WIDTH-20, 250);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.masksToBounds=YES;
    bgView.layer.cornerRadius=4;
    [self.view addSubview:bgView];
    
    UILabel *promptOneLabel= [[UILabel alloc]init];
    promptOneLabel.frame = CGRectMake(40, 30, bgView.frame.size.width-80, 30);
    promptOneLabel.backgroundColor=[UIColor clearColor];
    promptOneLabel.textAlignment=NSTextAlignmentCenter;
    promptOneLabel.numberOfLines = 2;
    promptOneLabel.font = [UIFont boldSystemFontOfSize:20];
    promptOneLabel.textColor = RGBA(0, 165, 109, 1);
    promptOneLabel.text = @"您已完成科目二考试";
    [bgView addSubview:promptOneLabel];
    
    UILabel *promptTwoLabel= [[UILabel alloc]init];
    promptTwoLabel.frame = CGRectMake(10, promptOneLabel.frame.origin.y+promptOneLabel.frame.size.height+10, bgView.frame.size.width-20, 16);
    promptTwoLabel.font = [UIFont boldSystemFontOfSize:16];
    promptTwoLabel.textColor = [UIColor blackColor];
    promptTwoLabel.backgroundColor=[UIColor clearColor];
    promptTwoLabel.textAlignment=NSTextAlignmentCenter;
    promptTwoLabel.text = @"您的教练确认您的分数为:";
    [bgView addSubview:promptTwoLabel];
    
    UILabel *promptFourLabel= [[UILabel alloc]init];
    promptFourLabel.frame = CGRectMake(30, promptTwoLabel.frame.origin.y+promptTwoLabel.frame.size.height+20, bgView.frame.size.width-60, 60);
    promptFourLabel.font = [UIFont systemFontOfSize:36];
    promptFourLabel.textColor = RGBA(0, 165, 109, 1);
    promptFourLabel.backgroundColor=[UIColor clearColor];
    promptFourLabel.textAlignment=NSTextAlignmentCenter;
    promptFourLabel.text = @"97分";
    promptFourLabel.layer.masksToBounds=YES;
    promptFourLabel.layer.cornerRadius=2;
    [bgView addSubview:promptFourLabel];
    
    UIButton *footBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    footBtn.frame = CGRectMake(75, promptFourLabel.frame.origin.y+promptFourLabel.frame.size.height+20, SCREEN_WIDTH-170, 40);
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
    footBtn.tag = 102;
    [footBtn addTarget:self action:@selector(footBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:footBtn];
}

#pragma mark 上课确认 课程请求
-(void)setCurriculumRequestView
{
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(10, 60, SCREEN_WIDTH-20, 280);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.masksToBounds=YES;
    bgView.layer.cornerRadius=4;
    [self.view addSubview:bgView];
    
    UILabel *promptOneLabel= [[UILabel alloc]init];
    promptOneLabel.frame = CGRectMake(40, 30, bgView.frame.size.width-80, 30);
    promptOneLabel.backgroundColor=[UIColor clearColor];
    promptOneLabel.textAlignment=NSTextAlignmentLeft;
    promptOneLabel.numberOfLines = 2;
    promptOneLabel.font = [UIFont boldSystemFontOfSize:16];
    promptOneLabel.textColor = [UIColor blackColor];
    promptOneLabel.text = @"您的师傅 马大仙 邀请您加入课程学习";
    [bgView addSubview:promptOneLabel];
    
    UILabel *promptTwoLabel= [[UILabel alloc]init];
    promptTwoLabel.frame = CGRectMake(0, promptOneLabel.frame.origin.y+promptOneLabel.frame.size.height+10, bgView.frame.size.width, 1);
    promptTwoLabel.backgroundColor=RGBA(235, 235, 235, 1);
    [bgView addSubview:promptTwoLabel];
    
    UILabel *promptThreeLabel= [[UILabel alloc]init];
    promptThreeLabel.frame = CGRectMake(40, promptTwoLabel.frame.origin.y+promptTwoLabel.frame.size.height+20, bgView.frame.size.width-80, 16);
    promptThreeLabel.font = [UIFont boldSystemFontOfSize:14];
    promptThreeLabel.textColor = [UIColor blackColor];
    promptThreeLabel.backgroundColor=[UIColor clearColor];
    promptThreeLabel.textAlignment=NSTextAlignmentLeft;
    promptThreeLabel.text = @"上课时间 2014年12月25日 下午";
    [bgView addSubview:promptThreeLabel];
    
    UILabel *promptFourLabel= [[UILabel alloc]init];
    promptFourLabel.frame = CGRectMake(40, promptThreeLabel.frame.origin.y+promptThreeLabel.frame.size.height+15, bgView.frame.size.width-80, 16);
    promptFourLabel.font = [UIFont boldSystemFontOfSize:14];
    promptFourLabel.textColor = [UIColor blackColor];
    promptFourLabel.backgroundColor=[UIColor clearColor];
    promptFourLabel.textAlignment=NSTextAlignmentLeft;
    promptFourLabel.text = @"上课内容 第三节";
    [bgView addSubview:promptFourLabel];
    
    UIButton *footBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    footBtn.frame = CGRectMake(75, promptFourLabel.frame.origin.y+promptFourLabel.frame.size.height+20, SCREEN_WIDTH-170, 40);
    [footBtn setBackgroundColor:[UIColor whiteColor]];
    [footBtn setTitle:@"我有时间" forState:UIControlStateNormal];
    [footBtn setTitle:@"我有时间" forState:UIControlStateHighlighted];
    [footBtn setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateNormal];
    [footBtn setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateHighlighted];
    footBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    footBtn.layer.masksToBounds=YES;
    footBtn.layer.cornerRadius=20;
    footBtn.layer.borderWidth = 1;
    footBtn.layer.borderColor = RGBA(0, 165, 109, 1).CGColor;
    footBtn.tag = 103;
    [footBtn addTarget:self action:@selector(footBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:footBtn];
    
    UIButton *footTwoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    footTwoBtn.frame = CGRectMake(75, footBtn.frame.origin.y+footBtn.frame.size.height+15, SCREEN_WIDTH-170, 40);
    [footTwoBtn setBackgroundColor:[UIColor whiteColor]];
    [footTwoBtn setTitle:@"我没时间，狠心拒绝他" forState:UIControlStateNormal];
    [footTwoBtn setTitle:@"我没时间，狠心拒绝他" forState:UIControlStateHighlighted];
    [footTwoBtn setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateNormal];
    [footTwoBtn setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateHighlighted];
    footTwoBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    footTwoBtn.layer.masksToBounds=YES;
    footTwoBtn.layer.cornerRadius=20;
    footTwoBtn.layer.borderWidth = 1;
    footTwoBtn.layer.borderColor = RGBA(0, 165, 109, 1).CGColor;
    footTwoBtn.tag = 104;
    [footTwoBtn addTarget:self action:@selector(footBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:footTwoBtn];
}

#pragma mark 上课确认 开始上课
-(void)setClassesBeginView
{
    
}

#pragma mark 上课确认 上课结束
-(void)setClassesEndView
{
    
}

#pragma mark 课程评价 打赏教练
-(void)setRewardsManagerView
{
    
}

#pragma mark 课程评价 教练评分原因
-(void)setCoachCommentReasonView
{
    
}

#pragma mark 投诉
-(void)setComplaintView
{
    
}

#pragma mark 课程分享
-(void)setShareView
{
    
}

#pragma mark Btn点击事件
-(void)footBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag)
    {
        case 100: case 101: case 102:
        {
             [self backAction];
        }
            break;
        case 103:
        {
            NoticeTwoViewController *vc = [[NoticeTwoViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.noticeType = @"4";
            vc.noticeTwoType = @"1";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 104:
        {
            NoticeTwoViewController *vc = [[NoticeTwoViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.noticeType = @"4";
            vc.noticeTwoType = @"2";
            [self.navigationController pushViewController:vc animated:YES];
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
