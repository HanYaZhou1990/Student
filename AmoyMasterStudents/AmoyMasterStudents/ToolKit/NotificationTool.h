//
//  NotificationTool.h
//  AmoyMasterStudents
//
//  Created by Apple on 15/3/28.
//  Copyright (c) 2015年 XHH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationTool : UIView

// 展示推送内容
- (void)displayNotificationWithRootViewController:(UIViewController *)rootViewController notificationContent:(NSDictionary *)notificationContent;

@end
