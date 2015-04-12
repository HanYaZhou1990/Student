//
//  NSString+Encryption.h
//  AmoyMasterStudents
//
//  Created by Apple on 15/4/3.
//  Copyright (c) 2015年 XHH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (MD5)


// 对字符串进行MD5加密
+ (NSString *)md5StringFromString:(NSString *)string;

@end
