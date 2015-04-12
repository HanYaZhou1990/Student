//
//  RemoteNotification.m
//  AmoyMasterStudents
//
//  Created by Apple on 15/3/26.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#pragma mark - 没有用了

#import "RemoteNotification.h"
#import "CoachAppointmentController.h"

@interface RemoteNotification ()

@property (nonatomic,strong) UIWindow *window;

@end

@implementation RemoteNotification

typedef enum
{
    SuccessCoachAppointmentNotification = 10,   // 预约教练成功
    PaymentNotification = 100,                  // 缴费通知
    TimeTableBNotification = 200,               // 排课通知
    AttendClassNotification = 201,              // 上课通知
    AttendingClassesNotification = 250,         // 正在上课通知
    MakeUpNotification = 280                    // 补课通知
}NotificationType; // 通知类型

- (void)initWithDictionary:(NSDictionary *)notificationContent{
    
    int type = [notificationContent[@"type"] intValue];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window.windowLevel = UIWindowLevelAlert + 1;
    window.backgroundColor = [UIColor redColor];
    self.window = window;
    
    switch (type) {
        case SuccessCoachAppointmentNotification:
            
            break;
        case PaymentNotification:
            self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[CoachAppointmentController alloc] init]];
            [self.window makeKeyAndVisible];
            break;
        case TimeTableBNotification:

            break;
        case AttendClassNotification:

            break;
        case AttendingClassesNotification:

            break;
        case MakeUpNotification:

            break;
 
    }
    DLog(@"type : %d", type);
//    [notificationContent objectForKey:@"type"];
    
//    PaymentModel *payment = [PaymentModel objectWithKeyValues:notificationContent];
//    DLog(@"教练名称：%@ , 缴费金额：%ld, 教练地址：%@", payment.master_name, payment.money, payment.address);

    
}

@end
