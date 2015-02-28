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
    
  
    
    [self leftBarItem];
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
    }
    else if ([noticeType isEqualToString:@"2"])
    {
        //录入成绩
          self.title = @"录入成绩";
    }
    else if ([noticeType isEqualToString:@"3"])
    {
        //成绩确认
          self.title = @"成绩确认";
    }
    else if ([noticeType isEqualToString:@"4"])
    {
        //上课确认 课程请求
          self.title = @"上课确认";
    }
    else if ([noticeType isEqualToString:@"5"])
    {
        //上课确认 开始上课
        self.title = @"上课确认";
    }
    else if ([noticeType isEqualToString:@"6"])
    {
        //上课确认 上课结束
        self.title = @"上课确认";
    }
    else if ([noticeType isEqualToString:@"7"])
    {
        //课程评价 打赏教练
        self.title = @"课程评价";
    }
    else if ([noticeType isEqualToString:@"8"])
    {
        //课程评价 教练评分原因
        self.title = @"课程评价";
    }
    else if ([noticeType isEqualToString:@"9"])
    {
        //投诉
        self.title = @"投诉";
    }
    else if ([noticeType isEqualToString:@"10"])
    {
        //课程分享
        self.title = @"课程分享";
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
