//
//  NoticeViewController.m
//  AmoyMasterStudents
//
//  Created by julong on 15/2/28.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "NoticeViewController.h"

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
    promptThreeLabel.frame = CGRectMake(10, promptTwoLabel.frame.origin.y+promptTwoLabel.frame.size.height+5, bgView.frame.size.width-20, 40);
    promptThreeLabel.font = [UIFont systemFontOfSize:16];
    promptThreeLabel.textColor = [UIColor grayColor];
    promptThreeLabel.backgroundColor=[UIColor clearColor];
    promptThreeLabel.textAlignment=NSTextAlignmentCenter;
    promptThreeLabel.numberOfLines = 2;
    promptThreeLabel.text = @"缴费地址:郑州市金水区。";
    [bgView addSubview:promptThreeLabel];
 
}

#pragma mark 录入成绩
-(void)setInputScoreView
{
    
}

#pragma mark 成绩确认
-(void)setScoreConfirmView
{
    
}

#pragma mark 上课确认 课程请求
-(void)setCurriculumRequestView
{
    
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
