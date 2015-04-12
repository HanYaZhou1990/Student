//
//  SuccessCoachAppointmentController.m
//  AmoyMasterStudents
//
//  Created by Apple on 15/3/26.
//  Copyright (c) 2015年 XHH. All rights reserved.
//

#import "CoachAppointmentController.h"
#import "MemberCenterViewController.h"
#import "NSString+StringHeight.h"


@interface CoachAppointmentController ()

@property (nonatomic, strong) UIImageView *smileImageView;
@property (nonatomic, strong) UILabel *congratulationLabel;
@property (nonatomic, strong) UILabel *suggestionLable;

@end

@implementation CoachAppointmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"预约成功";
    
    // 添加子控件
    [self addSubViews];
    [self setRightBarButtonItem];
    [self leftBarItem];
    
    DLog(@"传过来的内容:%@", _coachAppointmentDict);
}

// "我知道了"按钮
- (void)butclick{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

// 设置导航栏右边按钮
- (void)setRightBarButtonItem{
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_bar_person"] style:UIBarButtonItemStylePlain target:self action:@selector(menberCenterClick)];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}


- (void) addSubViews{
    // 图片
    UIImage *successImage = [UIImage imageNamed:@"icon_success"];
    UIImageView *successImageView = [[UIImageView alloc] initWithImage:successImage];
    [self.view addSubview:successImageView];
    [successImageView sizeToFit];
    // 设置水平中点位置
    successImageView.centerX = self.view.centerX;
    successImageView.y = self.view.height * 0.2;
    
    // 通知内容
    UILabel *notificationLabel = [[UILabel alloc] init];
    NSString *noticeText = @"恭喜您预约成功";
    UIFont *noticeFont = [UIFont boldSystemFontOfSize:22];

    // 设置换行
    notificationLabel.lineBreakMode = NSLineBreakByWordWrapping;
    notificationLabel.numberOfLines = 0;
    notificationLabel.textColor = TSFSutentColor;
    notificationLabel.text = noticeText;
    notificationLabel.font = noticeFont;
    notificationLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:notificationLabel];
    
    notificationLabel.width = self.view.width;
    CGFloat height = [noticeText heightForStringFont:noticeFont andWidth:notificationLabel.width];
    DLog(@"高度：%f", height);
    notificationLabel.height = height;
    notificationLabel.centerX = self.view.centerX;
    notificationLabel.y = CGRectGetMaxY(successImageView.frame) + 25;
    
    
    // 提醒内容
    UILabel *remindLabel = [[UILabel alloc] init];
    NSString *remindText = @"您可以等待教练联系您\n也可以致电教练进行沟通";
    UIFont *remindFont = [UIFont systemFontOfSize:15];
    // 换行
    remindLabel.lineBreakMode = NSLineBreakByWordWrapping;
    remindLabel.numberOfLines = 0;
    // 居中
    remindLabel.textAlignment = NSTextAlignmentCenter;
    // 颜色
    remindLabel.textColor = [UIColor lightGrayColor];
    remindLabel.text = remindText;
    remindLabel.font = remindFont;
    [self.view addSubview:remindLabel];
    
    remindLabel.width = self.view.width;
    remindLabel.height = [remindText heightForStringFont:remindFont andWidth:remindLabel.width];
    remindLabel.centerX = self.view.centerX;
    remindLabel.y = CGRectGetMaxY(notificationLabel.frame) + 20;

}

// 设置返回按钮
- (void)leftBarItem
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"icon_return.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"icon_return.png"] forState:UIControlStateHighlighted];
    backButton.frame = CGRectMake(0, 0, 21.5, 13.5);    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)backAction{
    [self tabBarControllerSelectIndex:2];
}


// 个人中心
- (void)menberCenterClick{
    [self tabBarControllerSelectIndex:3];
}


- (void)tabBarControllerSelectIndex:(int)selectIndex{
    UINavigationController *viewC = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    NSArray *childVcs = viewC.childViewControllers;
    for (int index = 0; index < childVcs.count; index++) {
        if ([childVcs[index] isMemberOfClass:[RootTabBarController class]]) {
            RootTabBarController *rootVc = childVcs[index];
            DLog(@"%@ rootviewcontroller --- ", rootVc);
            rootVc.navigationController.navigationBarHidden = YES;
            rootVc.navigationItem.hidesBackButton = YES;
            rootVc.selectedIndex = selectIndex;
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}


@end
