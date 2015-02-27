//
//  CoachListModel.h
//  AmoyMasterStudents
//
//  Created by julong on 15/2/27.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoachListModel : NSObject

@property (nonatomic,copy) NSString *school_name; //驾校名称
@property (nonatomic,copy) NSString *master_name; //教练名称
@property (nonatomic,copy) NSString *master_id; //教练ID
@property (nonatomic,copy) NSString *price;  //价格
@property (nonatomic,copy) NSString *avg_score; //得分
@property (nonatomic,copy) NSString *school_id;  //所属驾校id
@property (nonatomic,copy) NSString *license;  //驾照类型
@property (nonatomic,copy) NSString *license_type;  //驾照类型
@property (nonatomic,copy) NSString *trainee_count;  //总的学员数
@property (nonatomic,copy) NSString *current_count;  //当前正在学习的学员数
@property (nonatomic,copy) NSString *course_count; //课程数


- (id)initWithDictionary:(NSDictionary *)userDictionary;

@end
