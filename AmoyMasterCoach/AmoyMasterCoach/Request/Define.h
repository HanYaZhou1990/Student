//
//  Define.h
//  OChat
//
//  Created by julong on 14/12/24.
//  Copyright (c) 2014年 renbing. All rights reserved.
//

//颜色和透明度设置
#define RGBA(r,g,b,a)    [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]
//16进制
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//屏幕尺寸
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width) //屏幕宽度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height) //屏幕高度

#define NAV_HEIGHT  ((IOS7)?64:44) //nav的高度
#define TAB_HEIGHT 49 //tab的高度
//判断是否为4寸屏
#define is4Inch                     ([UIScreen instancesRespondToSelector:@selector(currentMode)] && [[UIScreen mainScreen] currentMode].size.height == 1136)

//软件版本号
#define SOFTWARE_VERSION ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"])
//判断系统版本是ios7以上
#define IOS7   ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)

//判断系统版本是ios8以上
#define IOS8   ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending)

//打印函数
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"[FileName:%s]\n" "[FunctionName:%s]\n" "[LineNumber:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__); //打印函数
#define DLOGDATA(data)             LSLOG(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding])  //数据打印函数
#else
#define DLog(...);
#define DLOGDATA(...);
#endif





