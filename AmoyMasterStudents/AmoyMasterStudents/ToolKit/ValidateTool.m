//
//  ValidateTool.m
//  OChat
//
//  Created by julong on 15/1/12.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "ValidateTool.h"

@implementation ValidateTool

//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//账号验证 字母数字下划线 不以下划线开始和结尾
+ (BOOL)validateUserAccount:(NSString *)account
{
    NSString *userAccountRegex = @"^(?!_)(?!.*?_$)[a-zA-Z0-9_]+$";
    NSPredicate *userAccountPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userAccountRegex];
    BOOL B = [userAccountPredicate evaluateWithObject:account];
    return B;
}

//判断QQ号码
+(BOOL)jugeMentQQNumber:(NSString *)qqNumStr
{
    NSString *phoneRegex = @"^[1-9][0-9]{4,11}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:qqNumStr];
    
}

//年龄
+ (BOOL)validateAge:(NSString *)age
{
    NSString *userNameRegex = @"^([1-9][0-9]{0,1})|(100)$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:age];
    return B;
}

// 验证身份证号
+ (BOOL)validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0)
    {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

// 验证邮箱
+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

// 验证护照
+ (BOOL)validatePassport:(NSString *)passport
{
    NSString *passportRegex = @"^(P\\d{7})|G\\d{8}|S\\d{7,8}|D\\d+|1[4,5]\\d{7})$";
    NSPredicate *passportTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passportRegex];
    return [passportTest evaluateWithObject:passport];
}



@end
