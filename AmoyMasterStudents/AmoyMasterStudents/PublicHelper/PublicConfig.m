//
//  PublicConfig.m
//  OChat
//
//  Created by julong on 14/12/24.
//  Copyright (c) 2014年 renbing. All rights reserved.
//

#import "PublicConfig.h"
#import <Foundation/Foundation.h>
#import "AppDelegate.h"

bool dataDebug = true;
@implementation PublicConfig
//为特定key指定value
+ (void)setValue:(id)value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//从特定key取得value
+ (id)valueForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

//判断用户是否登录
+(BOOL)isLogin
{
    return YES;
}

//提示框
+ (void)waringInfo:(NSString *)msgInfo
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                  message:msgInfo
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil,nil];
    [alert show];
}

//去掉ios7下被导航栏遮挡UIView得问题
+ (void)removerCoverView:(UIViewController*)viewController
{
    if (IOS7)
    {
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
        viewController.extendedLayoutIncludesOpaqueBars = NO;
        viewController.modalPresentationCapturesStatusBarAppearance = NO;
    }
}

//判断字符串为空 插入替代字符串
+ (NSString *)isSpaceString:(NSString *)firstStr andReplace:(NSString *)replaceStr
{
    if ((NSNull *)firstStr==[NSNull null])
    {
        return replaceStr;
    }
    else
    {
        firstStr = [firstStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
        
        if (firstStr.length == 0 || firstStr == nil || [firstStr isEqualToString:@""])
        {
            return replaceStr;
        }
        else
            return firstStr;
    }
    
    
}

//字典转化为字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    if (dic!=nil)
    {
        NSError *parseError = nil;
        NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return @"";
    
}

//字符串转化为字典
+ (NSDictionary *)jsonToDictionary:(NSString *)str
{
    if (str!=nil)
    {
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (error)
        {
            DLog(@"json解析失败：%@", error);
            return nil;
        }
        return dic;
    }
    return nil;
}

//设置返回键左边距
+(UIBarButtonItem *)setLeftBarBtnSpaceWidth
{
    UIBarButtonItem *leftBarBtnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    if (IOS7)
    {
        leftBarBtnSpace.width = -10;
    }
    else
        leftBarBtnSpace.width = 5;
    return leftBarBtnSpace;
}

//计算字符串宽度；
+ (CGFloat)width:(NSString *)contentString heightOfFatherView:(CGFloat)height textFont:(UIFont *)font{
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    CGSize size = [contentString sizeWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)];
    return size.width ;
#else
    NSDictionary *attributesDic = @{NSFontAttributeName:font};
    CGSize size = [contentString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDic context:nil].size;
    return size.width;
#endif
}
//计算字符串高度
+ (CGFloat)height:(NSString *)contentString widthOfFatherView:(CGFloat)width textFont:(UIFont *)font{
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    CGSize size = [contentString sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)];
    return size.height;
#else
    NSDictionary *attributesDic = @{NSFontAttributeName:font};
    CGSize size = [contentString boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDic context:nil].size;
    return size.height;
#endif
}

//计算左边返回按钮的宽度 传入标题值 跟最大宽度
+(CGFloat)leftBtnWidth:(NSString *)contentString maxOfWidth:(CGFloat)maxWidth
{
    if (maxWidth>SCREEN_WIDTH-20)
    {
        maxWidth=SCREEN_WIDTH-20;
    }
    CGFloat widthUse = [self width:contentString heightOfFatherView:30 textFont:[UIFont systemFontOfSize:18]];
    if (widthUse>maxWidth)
    {
        widthUse = maxWidth;
    }
    return widthUse;
}

//字典转化为get请求字符串
+ (NSString *)serializeToUrlByDicString:(NSDictionary *)dic
{
    NSString *result = @"";
    if (dic == nil || dic.count == 0)
    {
        return result;
    }
    
    for (id key in dic)
    {
        result = [NSString stringWithFormat:@"%@%@%@%@%@",result,key,@"=",dic[key],@"&"];
    }
    if (result.length > 0)
    {
        result = [result substringToIndex:result.length - 1];
    }
    return result;
}

//去空格
+(NSString *)getUseStr:(NSString *)test
{
    NSString *textStr=@"";
    if (test.length>0)
    {
        textStr = [test stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    return textStr;
}

@end
