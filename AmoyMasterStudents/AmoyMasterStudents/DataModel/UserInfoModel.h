//
//  UserInfoModel.h
//  AmoyMasterStudents
//
//  Created by mac on 15/3/24.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

//avatar: "{string}",  //学员头像连接
//nickname: "{string}",  //昵称
//account: "{string}",  //帐号
//cellphone: "{string}",  //手机号
//master_name: "{string}",  //教练姓名[无教练关联时将返回null]
//school_name: "{string}",  //驾校名称[无驾校关联时将返回null]
//verified_school: {boolean},  //加V？该字段暂时别用，需要与产品考证
//current_course_name: "{string}",  //当前课程名称
//current_course_phase: {number},  //当前课程进度
//total_courses: {number},  //课程总数
//current_exam_name: "{string}",  //当前考试名称
//current_exam_status: "{string}",  //当前考试状态[进行中；通过；未通过]
//reward_balance: {number}  //红包余额

@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *cellphone;
@property (nonatomic,copy) NSString *master_name;
@property (nonatomic,copy) NSString *school_name;
@property (nonatomic,copy) NSString *verified_school;
@property (nonatomic,copy) NSString *current_course_name;
@property (nonatomic,copy) NSString *current_course_phase;
@property (nonatomic,copy) NSString *total_courses;
@property (nonatomic,copy) NSString *current_exam_name;
@property (nonatomic,copy) NSString *current_exam_status;
@property (nonatomic,copy) NSString *reward_balance;

- (id)initWithDictionary:(NSDictionary *)userDictionary;

@end
