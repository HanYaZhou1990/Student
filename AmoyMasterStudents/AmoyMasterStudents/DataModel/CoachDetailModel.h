//
//  CoachDetailModel.h
//  AmoyMasterStudents
//
//  Created by julong on 15/2/10.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoachDetailModel : NSObject

@property (nonatomic,copy) NSString *school_id;  //所属驾校id
@property (nonatomic,copy) NSString *school_name; //驾校名称

@property (nonatomic,copy) NSString *master_name; //教练名称
@property (nonatomic,copy) NSString *master_id; //教练ID
@property (nonatomic,copy) NSString *master_pic; //教练头像

@property (nonatomic,copy) NSString *price;  //价格
@property (nonatomic,copy) NSString *avg_score; //得分

@property (nonatomic,copy) NSString *license;  //驾照类型
@property (nonatomic,copy) NSString *license_type;  //驾照类型
@property (nonatomic,copy) NSString *trainee_count;  //总的学员数
@property (nonatomic,copy) NSString *current_count;  //当前正在学习的学员数
@property (nonatomic,copy) NSString *course_count; //课程数

@property (nonatomic,copy) NSString *cellphone; //教练联系方式


@property (nonatomic,copy) NSString *userInfo;
@property (nonatomic,copy) NSString *schoolInfo;
@property (nonatomic,copy) NSString *paperImage;
@property (nonatomic,copy) NSString *userAddress;
@property (nonatomic,strong) NSArray *curriculumArray;
@property (nonatomic,strong) NSArray *timeArray;

- (id)initWithDictionary:(NSDictionary *)userDictionary;

@end


@interface CoachDetailCourseModel : NSObject

@property (nonatomic,strong) NSString *course_id;
@property (nonatomic,strong) NSString *school_id;
@property (nonatomic,strong) NSString *course_name;
@property (nonatomic,strong) NSString *course_desc;
@property (nonatomic,strong) NSString *duration_time;
@property (nonatomic,strong) NSString *enable_flag;
@property (nonatomic,strong) NSString *create_time;
@property (nonatomic,strong) NSString *update_time;

- (id)initWithDictionary:(NSDictionary *)userDictionary;

@end
