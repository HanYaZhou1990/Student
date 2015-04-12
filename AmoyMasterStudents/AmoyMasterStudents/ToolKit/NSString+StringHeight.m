//
//  NSString+StringHeight.m
//  AmoyMasterStudents
//
//  Created by Apple on 15/3/30.
//  Copyright (c) 2015年 XHH. All rights reserved.
//

#import "NSString+StringHeight.h"

@implementation NSString (StringHeight)

- (float) heightForStringFont:(UIFont *)font andWidth:(float)width
{
    
    CGRect rectToFit = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rectToFit.size.height;
}

- (float) widthForStringFont:(UIFont *)font{
    CGRect rectToFit = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rectToFit.size.width;
}

@end
