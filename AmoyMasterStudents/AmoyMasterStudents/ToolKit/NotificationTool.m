//
//  NotificationTool.m
//  AmoyMasterStudents
//
//  Created by Apple on 15/3/28.
//  Copyright (c) 2015年 XHH. All rights reserved.
//



#import "NotificationTool.h"

#import "RemoteNotification.h"
#import "CoachAppointmentController.h"
#import "PaymentViewController.h"
#import "AttendClassViewController.h"
#import "TimetableViewController.h"
#import "ResultTimeTableController.h"
#import "CurriculumEvaluationViewController.h"

@interface NotificationTool ()
{
    int type;
}
@end

@implementation NotificationTool

typedef enum
{
    SuccessCoachAppointmentNotification = 10, // 预约教练成功
    PaymentNotification = 100, // 缴费通知
    TimetableNotification = 200, // 排课通知
    AttendClassNotification = 201, // 上课前通知
    ClassBeginNotification = 250, // 正在上课通知
    ClassOverNotification = 210, // 上课结束通知
    MakeUpNotification = 280 // 补课通知
}NotificationType;

- (void)displayNotificationWithRootViewController:(UIViewController *)rootViewController notificationContent:(NSDictionary *)notificationContent{
    
    type =[notificationContent [@"t"] intValue]; // t : type
    
    CoachAppointmentController *coachAppointmentVc;
    PaymentViewController *paymentVc;
    TimetableViewController *timeTableVc;
    AttendClassViewController *attendClassVc;
    CurriculumEvaluationViewController *curriculumEvaluationVc;
    
    rootViewController.navigationController.navigationBarHidden = NO;
    
    switch (type) {
        case SuccessCoachAppointmentNotification: // 预约教练成功
            coachAppointmentVc = [[CoachAppointmentController alloc] init];
            // 隐藏back按钮
            coachAppointmentVc.navigationItem.hidesBackButton = YES;
            coachAppointmentVc.coachAppointmentDict = notificationContent;
            [rootViewController.navigationController pushViewController:coachAppointmentVc animated:YES];
            break;
        case PaymentNotification: // 缴费通知
            paymentVc = [[PaymentViewController alloc] init];
            // 隐藏back按钮
            paymentVc.navigationItem.hidesBackButton = YES;
            paymentVc.paymentDict = notificationContent;
            [rootViewController.navigationController pushViewController:paymentVc animated:YES];
            break;
        case ClassBeginNotification: // 正在上课通知
            attendClassVc = [[AttendClassViewController alloc] init];
            // 隐藏back按钮
            attendClassVc.navigationItem.hidesBackButton = YES;
            attendClassVc.attendClassDict = notificationContent;
            [rootViewController.navigationController pushViewController:attendClassVc animated:YES];
            break;
            
        case TimetableNotification: // 排课通知
        case MakeUpNotification: // 补课通知
        case AttendClassNotification: // 上课前通知(会在上课前通知很多次，直到上课时间到)
            timeTableVc = [[TimetableViewController alloc] init];
            timeTableVc.navigationItem.hidesBackButton = YES;
            timeTableVc.timeTableDict = notificationContent;
            [rootViewController.navigationController pushViewController:timeTableVc animated:YES];
            break;
        case ClassOverNotification: // 上课结束通知
            // 直接跳转到评价教练的页面
            curriculumEvaluationVc = [[CurriculumEvaluationViewController alloc]init];
            curriculumEvaluationVc.navigationItem.hidesBackButton = YES;
            curriculumEvaluationVc.curriculumDict = notificationContent;
            DLog(@"curriculumEvaluationVc -- %@",curriculumEvaluationVc.curriculumDict);
            [rootViewController.navigationController pushViewController:curriculumEvaluationVc animated:YES];
            break;
    }
    if (!type) { // 如果type没有值，说明没有通知，那么就不需要根控制器的导航栏
        rootViewController.navigationController.navigationBarHidden = YES;
    }
    
}

@end
