//
//  RemoteNotification.h
//  AmoyMasterStudents
//
//  Created by Apple on 15/3/26.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemoteNotification : NSObject

//@param notificationContent : 服务器推送过来的JSON
- (void)initWithDictionary:(NSDictionary *)notificationContent;

@end
