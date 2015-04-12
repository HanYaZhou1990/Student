//
//  NSString+Encryption.m
//  AmoyMasterStudents
//
//  Created by Apple on 15/4/3.
//  Copyright (c) 2015年 XHH. All rights reserved.
//

#import "NSString+MD5.h"

@implementation NSString (Encryption)

+ (NSString *)md5StringFromString:(NSString *)string {
    if(string == nil || [string length] == 0)
       return nil;
    const char *value = [string UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];}
    return outputString;
}

@end
