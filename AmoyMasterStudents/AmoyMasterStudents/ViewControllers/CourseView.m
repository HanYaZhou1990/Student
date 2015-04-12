//
//  CourseView.m
//  AmoyMasterStudents
//
//  Created by Apple on 15/3/27.
//  Copyright (c) 2015年 XHH. All rights reserved.
//

#import "CourseView.h"
#import "NSString+StringHeight.h"

@interface CourseView (){
    UIButton *_haveTimeBt; // 有时间按钮
    UIButton *_noTimeBt; // 没有时间按钮
    UIView *_lineView; // 线
    
}
@end

@implementation CourseView

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
    
    // 通知标题
    UILabel *notificationTitle = [[UILabel alloc] init];
    // 设置换行
    notificationTitle.lineBreakMode = NSLineBreakByWordWrapping;
    notificationTitle.numberOfLines = 0;
    notificationTitle.font = [UIFont boldSystemFontOfSize:17];
    //    notificationTitle.textColor = TSFSutentColor;
    [self addSubview:notificationTitle];
    self.notificationTitle = notificationTitle;
    
    // 分割线
    UIView *lineView = [[UIView alloc] init];
    [lineView setBackgroundColor:[UIColor darkGrayColor]];
    [lineView setAlpha:0.2];
    [self addSubview:lineView];
    _lineView = lineView;
    
    
    // 通知内容
    UILabel *notificationContent = [[UILabel alloc] init];
    // 设置换行
    notificationContent.lineBreakMode = NSLineBreakByWordWrapping;
    notificationContent.numberOfLines = 0;
    notificationContent.font = [UIFont boldSystemFontOfSize:16];
    [notificationContent setTextColor:[UIColor darkGrayColor]];
    [self addSubview:notificationContent];
    self.notificationContent = notificationContent;
    

    
    // 有时间
    UIButton *haveTimeBt = [[UIButton alloc]init];
    [haveTimeBt setBackgroundImage:[UIImage imageNamed:@"notification_course_btn_confirm"] forState:UIControlStateNormal];
    [haveTimeBt setBackgroundImage:[UIImage imageNamed:@"course_btn_confirm_active"] forState:UIControlStateHighlighted];
    [haveTimeBt addTarget:self action:@selector(haveTimeClick) forControlEvents:UIControlEventTouchUpInside];
    [haveTimeBt sizeToFit];
    [self addSubview:haveTimeBt];
    _haveTimeBt = haveTimeBt;
    
    // 没有时间，拒绝上课
    UIButton *noTimeBt = [[UIButton alloc]init];
    [noTimeBt setBackgroundImage:[UIImage imageNamed:@"notification_course_btn_reject"] forState:UIControlStateNormal];
    [noTimeBt setBackgroundImage:[UIImage imageNamed:@"notification_course_btn_reject_active"] forState:UIControlStateHighlighted];
    [noTimeBt addTarget:self action:@selector(noTimeClick) forControlEvents:UIControlEventTouchUpInside];
    [noTimeBt sizeToFit];
    [self addSubview:noTimeBt];
    _noTimeBt = noTimeBt;
    
}


- (void)haveTimeClick{
    if ([self.delegate respondsToSelector:@selector(haveTimeBtClick)]) {
        [self.delegate haveTimeBtClick];
    }
}


- (void)noTimeClick{
    if ([self.delegate respondsToSelector:@selector(noTimeBtClick)]) {
        [self.delegate noTimeBtClick];
    }
}


- (void)layoutSubviews{
    
    // 通知标题
    self.notificationTitle.textAlignment = NSTextAlignmentCenter;
    self.notificationTitle.x = 0;
    self.notificationTitle.y = 20;
    self.notificationTitle.width = self.width;
    self.notificationTitle.height = [self.notificationTitle.text heightForStringFont:self.notificationTitle.font andWidth:self.notificationTitle.width];

  
    // 分割线
    _lineView.frame = CGRectMake(0, CGRectGetMaxY(self.notificationTitle.frame) + 20, self.width, 0.5);

  
    // 通知内容
    self.notificationContent.width = [self.notificationTitle.text widthForStringFont:self.notificationTitle.font];
    // 15 是文本的行间距
    self.notificationContent.height = [self.notificationContent.text heightForStringFont:self.notificationContent.font andWidth:self.notificationContent.width] +15*self.textLines;
    if((self.width - self.notificationContent.width) * 0.5 < 5){
        
        self.notificationContent.x = 5;
    }else{
        self.notificationContent.x = (self.width - self.notificationContent.width) * 0.5;
    }
    self.notificationContent.y = CGRectGetMaxY(_lineView.frame) + 20;
    
    
    // 我有时间按钮
    _haveTimeBt.x = (self.width - _haveTimeBt.width) * 0.5;
    _haveTimeBt.y = CGRectGetMaxY(_notificationContent.frame) + 30;
    
    // 我没时间
    _noTimeBt.x = (self.width - _noTimeBt.width) * 0.5;
    _noTimeBt.y = CGRectGetMaxY(_haveTimeBt.frame) + 20;
    

    self.lastButtonMaxY = CGRectGetMaxY(_noTimeBt.frame);
    self.height = self.lastButtonMaxY + 60;
  
}

@end
