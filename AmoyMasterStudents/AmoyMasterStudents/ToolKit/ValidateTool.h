//
//  ValidateTool.h
//  OChat
//
//  Created by julong on 15/1/12.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

//验证类

#import <Foundation/Foundation.h>

@interface ValidateTool : NSObject

//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile;

//账号验证 字母数字下划线 不以下划线开始和结尾
+ (BOOL)validateUserAccount:(NSString *)account;

//判断QQ号码
+(BOOL)jugeMentQQNumber:(NSString *)qqNumStr;

//年龄
+ (BOOL)validateAge:(NSString *)age;

// 验证身份证号
+ (BOOL)validateIdentityCard: (NSString *)identityCard;

// 验证邮箱
+ (BOOL)validateEmail:(NSString *)email;

// 验证护照
+ (BOOL)validatePassport:(NSString *)passport;

@end
