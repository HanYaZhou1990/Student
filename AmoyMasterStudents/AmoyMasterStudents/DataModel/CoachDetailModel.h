//
//  CoachDetailModel.h
//  AmoyMasterStudents
//
//  Created by julong on 15/2/10.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoachDetailModel : NSObject

@property (nonatomic,strong) NSString *headImage;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *drivingSchool;
@property (nonatomic,strong) NSString *score;
@property (nonatomic,strong) NSString *fees;
@property (nonatomic,strong) NSString *goNumber;
@property (nonatomic,strong) NSString *studyNumber;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSArray  *curriculumArray;//课程表
@property (nonatomic,strong) NSString *userInfo; //我的自述
@property (nonatomic,strong) NSString *schoolInfo;//驾校信息
@property (nonatomic,strong) NSString *paperImage;//证件照
@property (nonatomic,strong) NSArray  *timeArray;//时间表
@property (nonatomic,strong) NSString *userAddress;//教练地址

@end
