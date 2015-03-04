//
//  CoachDetailModel.h
//  AmoyMasterStudents
//
//  Created by julong on 15/2/10.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoachDetailModel : NSObject

@property (nonatomic,copy) NSString *master_id; //教练ID
@property (nonatomic,copy) NSString *school_id;  //所属驾校id
@property (nonatomic,copy) NSString *school_name; //驾校名称
@property (nonatomic,copy) NSString *master_name; //教练名称
@property (nonatomic,copy) NSString *master_pic; //教练证图片
@property (nonatomic,copy) NSString *avatar; //教练头像
@property (nonatomic,copy) NSString *cellphone; //教练手机号码

@property (nonatomic,copy) NSString *price;  //价格
@property (nonatomic,copy) NSString *avg_score; //得分

@property (nonatomic,copy) NSString *license;  //驾照类型
@property (nonatomic,copy) NSString *license_type;  //驾照类型
@property (nonatomic,copy) NSString *trainee_count;  //总的学员数
@property (nonatomic,copy) NSString *current_count;  //当前正在学习的学员数
@property (nonatomic,copy) NSString *course_count; //课程数

@property (nonatomic,copy) NSString *master_desc; //教练自述
@property (nonatomic,copy) NSString *school_desc; //驾校简介
@property (nonatomic,copy) NSString *school_address; //驾校位置
@property (nonatomic,strong) NSArray *course; //课程列表
@property (nonatomic,strong) NSArray *timeArray;

- (id)initWithDictionary:(NSDictionary *)userDictionary;

@end


@interface CoachDetailCourseModel : NSObject

@property (nonatomic,strong) NSString *course_id; //课程id
@property (nonatomic,strong) NSString *course_name; //课程名称
@property (nonatomic,strong) NSString *course_desc;//课程描述
@property (nonatomic,strong) NSString *duration_time; //课程时长 （单位分钟）
@property (nonatomic,strong) NSString *trainee_count;//同车人数

- (id)initWithDictionary:(NSDictionary *)userDictionary;

@end
