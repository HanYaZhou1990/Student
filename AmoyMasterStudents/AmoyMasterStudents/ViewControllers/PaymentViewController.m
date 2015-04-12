//
//  PaymentViewController.m
//  AmoyMasterStudents
//
//  Created by Apple on 15/3/26.
//  Copyright (c) 2015年 XHH. All rights reserved.
//

#import "PaymentViewController.h"
#import "NSString+StringHeight.h"



@interface PaymentViewController (){
    NSString *_coach;
    int _money;
    NSString *_coachAddress;

}

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"缴费通知";
    

    DLog(@"传过来的内容:%@", _paymentDict);
    _coach = self.paymentDict[@"m_name"]; // m_name : master_name (教练名称)
    _money = [self.paymentDict[@"money"] intValue];
    _coachAddress = self.paymentDict[@"address"];
    
    // 隐藏back按钮
    self.navigationItem.hidesBackButton = YES;
    
    [self addSubViews];
    
    [self setRightBarButtonItem];
    
}


- (void)addSubViews{
    // 图片
    UIImage *moneyImage = [UIImage imageNamed:@"icon_money"];
    UIImageView *moneyImageView = [[UIImageView alloc] initWithImage:moneyImage];
    [self.view addSubview:moneyImageView];
    moneyImageView.centerX = self.view.centerX;
    moneyImageView.y = self.view.height * 0.2;
    
    // 通知内容
    UILabel *notificationLabel = [[UILabel alloc] init];
    NSString *noticeText = [NSString stringWithFormat:@"教练%@通知您缴纳\n补考费用%d元",_coach,_money];
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
    notificationLabel.height = height;
    notificationLabel.centerX = self.view.centerX;
    notificationLabel.y = CGRectGetMaxY(moneyImageView.frame) + 25;
    

    // 提醒内容
    UILabel *remindLabel = [[UILabel alloc] init];
    NSString *remindText = [NSString stringWithFormat:@"缴费完成才可以进入补考排期\n缴费地址：%@", _coachAddress];
    
    UIFont *remindFont = [UIFont systemFontOfSize:15];
    remindLabel.lineBreakMode = NSLineBreakByWordWrapping;
    remindLabel.numberOfLines = 0;
    remindLabel.textColor = [UIColor lightGrayColor];
    // 换行
    remindLabel.text = remindText;
    remindLabel.font = remindFont;
    remindLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:remindLabel];
    
    remindLabel.width = self.view.width;
    remindLabel.height = [remindText heightForStringFont:noticeFont andWidth:notificationLabel.width];
    DLog(@"高度：%f", height);
    remindLabel.centerX = self.view.centerX;
    remindLabel.y = CGRectGetMaxY(notificationLabel.frame) + 20;

    
    // 按钮
    UIButton *knowBt = [[UIButton alloc]init];
    [knowBt setBackgroundImage:[UIImage imageNamed:@"btn_confirm"] forState:UIControlStateNormal];
    [knowBt setTitle:@"我知道了" forState:UIControlStateNormal];
    [knowBt addTarget:self action:@selector(knowBtClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:knowBt];
    CGFloat padding = 20;
    knowBt.y = CGRectGetMaxY(remindLabel.frame) + 20;
    knowBt.x = padding;
//    [knowBt sizeToFit];
    knowBt.width = self.view.width - 2*padding;
    knowBt.height = 40;

    

}

- (void)knowBtClick{
    // 跳转到根控制器
    [self tabBarControllerSelectIndex:2];
}


// 设置导航栏右边按钮(个人中心)
- (void)setRightBarButtonItem{
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_bar_person"] style:UIBarButtonItemStylePlain target:self action:@selector(menberCenterClick)];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
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
