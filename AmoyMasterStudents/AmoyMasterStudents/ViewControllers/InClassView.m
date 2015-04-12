//
//  InClassView.m
//  AmoyMasterStudents
//
//  Created by Apple on 15/3/27.
//  Copyright (c) 2015年 XHH. All rights reserved.
//

#import "InClassView.h"
#import "NSString+StringHeight.h"

@interface InClassView (){
    UIView *_lineView; // 线
    UIButton *_areInClassBt;

}
@end

@implementation InClassView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpSubViews];
        
    }
    return self;
}

- (void)setUpSubViews{
    
    self.backgroundColor = [UIColor whiteColor];
    // 设置uiview的圆角
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    // 教练名称
    UILabel *coach = [[UILabel alloc] init];
    // 设置换行
    coach.lineBreakMode = NSLineBreakByWordWrapping;
    coach.numberOfLines = 0;

    coach.font = [UIFont boldSystemFontOfSize:17];
    coach.textColor = TSFSutentColor;
    [self addSubview:coach];
    self.coach = coach;
    
    // 分割线
    UIView *lineView = [[UIView alloc] init];
    [lineView setBackgroundColor:[UIColor darkGrayColor]];
    [lineView setAlpha:0.2];
    [self addSubview:lineView];
    _lineView = lineView;
    
    
    UILabel *notificationContent = [[UILabel alloc] init];
    // 设置换行
    notificationContent.lineBreakMode = NSLineBreakByWordWrapping;
    notificationContent.numberOfLines = 0;
    notificationContent.font = [UIFont boldSystemFontOfSize:16];
    [notificationContent setTextColor:[UIColor darkGrayColor]];
    [self addSubview:notificationContent];
    self.notificationContent = notificationContent;
    
    
    
    // 开始上课/结束上课
    UIButton *areInClassBt = [[UIButton alloc]init];
    [areInClassBt setBackgroundImage:[UIImage imageNamed:@"notification_course_end"] forState:UIControlStateNormal];
    [areInClassBt setBackgroundImage:[UIImage imageNamed:@"notification_course_end_active"] forState:UIControlStateHighlighted];
    [areInClassBt addTarget:self action:@selector(inClassClick) forControlEvents:UIControlEventTouchUpInside];
    [areInClassBt sizeToFit];
    [self addSubview:areInClassBt];
    _areInClassBt = areInClassBt;
}


- (void)inClassClick{
    if ([self.delegate respondsToSelector:@selector(inClassBtClick)]) {
        [self.delegate inClassBtClick];
    }
}


-(void)layoutSubviews{
    
    // 上课内容
    CGFloat paddingX = self.width * 0.05;
    CGFloat paddingY = 15;
    self.notificationContent.x = paddingX;
    self.notificationContent.y = paddingY;
    self.notificationContent.width = self.width - 2*paddingX;
    self.notificationContent.height = [self.notificationContent.text heightForStringFont:self.notificationContent.font andWidth:self.notificationContent.width] + 20;
    
    // 教练
    _lineView.frame = CGRectMake(0, CGRectGetMaxY(_notificationContent.frame) + paddingY, self.width, 0.5);
    
    self.coach.x = _notificationContent.x;
    self.coach.y = CGRectGetMaxY(_lineView.frame) + paddingY;
    self.coach.width = _notificationContent.width;
    self.coach.height = [_coach.text heightForStringFont:self.coach.font andWidth:self.coach.width];
    
    // 确认上课结束按钮
    _areInClassBt.x = (self.width - _areInClassBt.width) * 0.5;
    _areInClassBt.y = CGRectGetMaxY(self.coach.frame) + 55;
    
    
    self.height = CGRectGetMaxY(_areInClassBt.frame) + 60;
    
}

@end
