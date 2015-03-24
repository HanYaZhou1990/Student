//
//  UserInfoModel.m
//  AmoyMasterStudents
//
//  Created by mac on 15/3/24.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

- (id)initWithDictionary:(NSDictionary *)userDictionary
{
    if (self = [super init])
    {
        _avatar = [userDictionary objectForKey:@"avatar"];
        _nickname = [userDictionary objectForKey:@"nickname"];
        _account = [userDictionary objectForKey:@"account"];
        _cellphone = [userDictionary objectForKey:@"cellphone"];
        _master_name = [userDictionary objectForKey:@"master_name"];
        _school_name = [userDictionary objectForKey:@"school_name"];
        _verified_school = [userDictionary objectForKey:@"verified_school"];
        _current_course_name = [userDictionary objectForKey:@"current_course_name"];
        _current_course_phase = [userDictionary objectForKey:@"current_course_phase"];
        _total_courses = [userDictionary objectForKey:@"total_courses"];
        _current_exam_name = [userDictionary objectForKey:@"current_exam_name"];
        _current_exam_status = [userDictionary objectForKey:@"current_exam_status"];
        _reward_balance = [userDictionary objectForKey:@"reward_balance"];
    }
    return self;
}

@end
