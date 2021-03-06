//
//  CoachDetailModel.m
//  AmoyMasterStudents
//
//  Created by julong on 15/2/10.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "CoachDetailModel.h"

@implementation CoachDetailModel
@synthesize school_name, //驾校名称
master_name,  //教练名称
master_pic, //教练证图片
avatar,//教练头像
master_id,  //教练ID
price,  //价格
avg_score,  //得分
school_id,  //所属驾校id
license,  //驾照类型
license_type,  //驾照类型
trainee_count,  //总的学员数
current_count,  //当前正在学习的学员数
course_count,//课程数
master_desc, //教练自述
school_desc, //驾校简介
school_address, //驾校位置
course,//课程列表
cellphone; //联系方式

- (id)initWithDictionary:(NSDictionary *)userDictionary
{
    if (self = [super init])
    {
        school_name = [userDictionary objectForKey:@"school_name"];
        master_name = [userDictionary objectForKey:@"master_name"];
        master_pic = [userDictionary objectForKey:@"master_pic"];
        master_id = [userDictionary objectForKey:@"master_id"];
        cellphone = [userDictionary objectForKey:@"cellphone"];
        price = [userDictionary objectForKey:@"price"];
        avg_score = [userDictionary objectForKey:@"avg_score"];
        school_id = [userDictionary objectForKey:@"school_id"];
        license = [userDictionary objectForKey:@"license"];
        license_type = [userDictionary objectForKey:@"license_type"];
        trainee_count = [userDictionary objectForKey:@"trainee_count"];
        current_count = [userDictionary objectForKey:@"current_count"];
        course_count = [NSString stringWithFormat:@"%lld",[[userDictionary objectForKey:@"course_count"] longLongValue]];
        avatar = [userDictionary objectForKey:@"avatar"];
        master_desc = [userDictionary objectForKey:@"master_desc"];
        school_desc = [userDictionary objectForKey:@"school_desc"];
        course = [userDictionary objectForKey:@"course"];
        school_address = [userDictionary objectForKey:@"school_address"];
    }
    return self;
}

@end


@implementation CoachDetailCourseModel

@synthesize course_id,course_name,course_desc,duration_time,trainee_count;

- (id)initWithDictionary:(NSDictionary *)userDictionary
{
    if (self = [super init])
    {
        course_id = [userDictionary objectForKey:@"course_id"];
        course_name = [userDictionary objectForKey:@"course_name"];
        course_desc = [userDictionary objectForKey:@"course_desc"];
        duration_time = [userDictionary objectForKey:@"duration_time"];
        trainee_count = [userDictionary objectForKey:@"trainee_count"];
    }
    return self;
}

@end

