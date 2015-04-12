//
//  RejectViewController.m
//  AmoyMasterStudents
//
//  Created by Apple on 15/3/27.
//  Copyright (c) 2015年 XHH. All rights reserved.
//

#import "ResultTimeTableController.h"
#import "RegisterViewController.h"
#import "ResultView.h"

@interface ResultTimeTableController (){
    NSString *_iconName;
    NSString *_resultText;
    NSString *_noticeText;
}

@end

@implementation ResultTimeTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TSFSutentColor;
    
    [self setRightBarButtonItem];
    [self leftBarItem];
    [self addSubViews];
}


- (void)addSubViews{
    ResultView *resultView = [[ResultView alloc] init];
    
    if (self.flag == 1) { // 点击我有时间按钮
        _iconName = @"icon_course_confirm";
        _resultText = [NSString stringWithFormat:@"您已成功参与课程%@", self.class_desc];
        _noticeText = @"请您按时上课";
        self.title = @"确认上课";
    }else if(self.flag == 2){ // 点击我没时间按钮
        _iconName = @"icon_reject";
        _resultText = @"您已经拒绝本次课程";
        _noticeText = @"请耐心等待下次上课通知";
        self.title = @"拒绝上课";
    }

    
    resultView.iconImageView.image = [UIImage imageNamed:_iconName];
    resultView.resultLabel.text = _resultText;
    resultView.noticeLabel.text = _noticeText;
    [self.view addSubview:resultView];

    CGFloat padding = 17;
    resultView.x = padding;
    resultView.y = self.view.height * 0.17;
    resultView.width = self.view.width - 2*padding;
//    resultView.frame = CGRectMake(padding, self.view.height * 0.17, self.view.width - 2*padding, 270);
    
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
// 返回
- (void)backAction{
    [self tabBarControllerSelectIndex:2];
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
