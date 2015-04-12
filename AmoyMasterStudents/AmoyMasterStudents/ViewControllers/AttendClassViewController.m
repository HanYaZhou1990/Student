//
//  AttendClassViewController.m
//  AmoyMasterStudents
//
//  Created by Apple on 15/3/26.
//  Copyright (c) 2015年 XHH. All rights reserved.
//

#import "AttendClassViewController.h"
#import "InClassView.h"
#import "ResultView.h"
#import "CurriculumEvaluationViewController.h"


/** 
 正在上课
 */
@interface AttendClassViewController () <InClassViewDelegate>
{
    NSString    *_coach;    // 教练名称
    NSString    *_time;     // 上课时间
    NSString    *_content;  // 上课内容
    int         _type;      // 当前状态：正在(马上要)上课250
}
@end

@implementation AttendClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = TSFSutentColor;
    self.title = @"上课确认";
    
    _coach = self.attendClassDict[@"m_name"];       // 教练名称
    _time = self.attendClassDict[@"begin"];         // 开始上课时间
    _content = self.attendClassDict[@"desc"];       // 上课描述
    _type = [self.attendClassDict[@"t"] intValue];  // 通知类型
    [self addSubViews];

}

- (void)addSubViews{
    
    InClassView *inClassView = [[InClassView alloc]init];
    inClassView.delegate = self;
    inClassView.coach.text = [NSString stringWithFormat:@"教练：%@", _coach];
    
    // 上课时间
    NSString *content = [NSString stringWithFormat:@"上课时间    %@\n上课内容    %@", _time, _content];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:12];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    inClassView.notificationContent.attributedText = attributedString;
    
    [self.view addSubview:inClassView];
    CGFloat padding = 17;
    inClassView.x = padding;
    inClassView.y = self.view.height * 0.17;
    inClassView.width = self.view.width - 2*padding;
    
}

#pragma 实现代理方法
- (void)inClassBtClick{
    
# pragma  请求网络判断是否上课结束，如果上课结束，跳到教练评价页面
    NSString *url = [NSString stringWithFormat:@"%@%@", BASE_PLAN_URL, trainee_course_finishClass];
    
    if (self.attendClassDict[@"class_id"] == nil) {
        [SVProgressHUD showErrorWithStatus:@"没有课程正在进行"];
        return;
    }
        NSDictionary *param = @{@"class_id":self.attendClassDict[@"class_id"],@"token":[PublicConfig valueForKey:userToken]};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager POST:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            DLog(@"responseObject -- %@", responseObject);
            if ([responseObject[@"code"] intValue] == 0) {
#pragma 课程结束确认成功，跳转到教练评价页面
                // 直接跳转到评价教练的页面
                CurriculumEvaluationViewController *curriculumEvaluationVc = [[CurriculumEvaluationViewController alloc]init];
                curriculumEvaluationVc.navigationItem.hidesBackButton = YES;
                
                curriculumEvaluationVc.curriculumDict = self.attendClassDict;
                [self.navigationController pushViewController:curriculumEvaluationVc animated:YES];
                DLog(@"上课结束确认，请评价教练");
            }else{
                [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [SVProgressHUD showErrorWithStatus:@"操作请求失败，请稍后再试"];
        }];
    
}



@end
