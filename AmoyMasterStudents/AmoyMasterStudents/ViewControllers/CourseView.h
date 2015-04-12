//
//  CourseView.h
//  AmoyMasterStudents
//
//  Created by Apple on 15/3/27.
//  Copyright (c) 2015年 XHH. All rights reserved.
//

#import <UIKit/UIKit.h>

// 排课view

@protocol CourseViewDelegate <NSObject>

@required
- (void)haveTimeBtClick;
@required
- (void)noTimeBtClick;

@end

@interface CourseView : UIView

@property (nonatomic, strong) id<CourseViewDelegate> delegate;
@property (nonatomic, strong) UILabel *notificationTitle; // 通知标题
@property (nonatomic, strong) UILabel *notificationContent; // 通知内容
@property (nonatomic, assign) int textLines;

// view的最后一个按钮的最大y值
@property (nonatomic, assign) CGFloat lastButtonMaxY;

@end
