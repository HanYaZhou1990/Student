//
//  NSString+StringHeight.h
//  AmoyMasterStudents
//
//  Created by Apple on 15/3/30.
//  Copyright (c) 2015年 XHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringHeight)

// 根据文字计算文字的高度
- (float) heightForStringFont:(UIFont *)font andWidth:(float)width;

// 根据文字计算文字的宽度
- (float) widthForStringFont:(UIFont *)font;

@end
