//
//  OrderCoachViewController.m
//  AmoyMasterStudents
//
//  Created by julong on 15/2/11.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "OrderCoachViewController.h"

@interface OrderCoachViewController ()

@end

@implementation OrderCoachViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"预约结果";
    
    [self leftBarItem];
    
    [self setView];

}

- (void)leftBarItem
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"icon_return.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"icon_return.png"] forState:UIControlStateHighlighted];
    backButton.frame = CGRectMake(0, 0, 21.5, 13.5);    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}
-(void)backAction
{
    [self tabBarControllerSelectIndex:2];
}


//初始化界面
-(void)setView
{
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.frame = CGRectMake((SCREEN_WIDTH-59)/2, 60, 59, 59);
    [self.view addSubview:imgView];
    
    UILabel *scoreLabel= [[UILabel alloc]init];
    scoreLabel.frame = CGRectMake(10, imgView.frame.origin.y+imgView.frame.size.height+10, SCREEN_WIDTH-20, 50);
    scoreLabel.backgroundColor=[UIColor clearColor];
    scoreLabel.textAlignment=NSTextAlignmentCenter;
    scoreLabel.font = [UIFont boldSystemFontOfSize:24];
    scoreLabel.textColor = TSFSutentColor;
    [self.view addSubview:scoreLabel];
    
    UILabel *promptOneLabel= [[UILabel alloc]init];
    promptOneLabel.frame = CGRectMake(10, scoreLabel.frame.origin.y+scoreLabel.frame.size.height+10, SCREEN_WIDTH-20, 40);
    promptOneLabel.font = [UIFont systemFontOfSize:16];
    promptOneLabel.textColor = [UIColor grayColor];
    promptOneLabel.backgroundColor=[UIColor clearColor];
    promptOneLabel.textAlignment=NSTextAlignmentCenter;
    // 设置换行
    promptOneLabel.lineBreakMode = NSLineBreakByWordWrapping;
    promptOneLabel.numberOfLines = 0;
    [self.view addSubview:promptOneLabel];
    
    // 教练电话
    UILabel *coachCellPhoneLabel = [[UILabel alloc]init];
    coachCellPhoneLabel.frame = CGRectMake(0, CGRectGetMaxY(promptOneLabel.frame) + 10, self.view.width, 40);
    coachCellPhoneLabel.font = [UIFont systemFontOfSize:16];
    coachCellPhoneLabel.textColor = [UIColor grayColor];
    coachCellPhoneLabel.textAlignment=NSTextAlignmentCenter;
    // 设置换行
    coachCellPhoneLabel.lineBreakMode = NSLineBreakByWordWrapping;
    coachCellPhoneLabel.numberOfLines = 0;
    [self.view addSubview:coachCellPhoneLabel];
    coachCellPhoneLabel.opaque = NO;
    
//    提醒取消预约
    UILabel *remindLabel = [[UILabel alloc]init];
    remindLabel.frame = CGRectMake(0, CGRectGetMaxY(coachCellPhoneLabel.frame) + 30, self.view.width, 40);
    remindLabel.font = [UIFont systemFontOfSize:16];
    remindLabel.textColor = TSFSutentColor;
    remindLabel.textAlignment = NSTextAlignmentCenter;
    // 设置换行
    remindLabel.lineBreakMode = NSLineBreakByWordWrapping;
    remindLabel.numberOfLines = 0;
    [self.view addSubview:remindLabel];
    remindLabel.opaque = NO;
    
    
    // 取消预约按钮
    UIButton *cancelOrder = [[UIButton alloc] init];
    [cancelOrder setImage:[UIImage imageNamed:@"notification_order_btn_cancel"] forState:UIControlStateNormal];
    [cancelOrder setImage:[UIImage imageNamed:@"notification_order_btn_cancel_active"] forState:UIControlStateHighlighted];
    cancelOrder.hidden = YES;
    [cancelOrder sizeToFit];
    cancelOrder.y = CGRectGetMaxY(remindLabel.frame) + 15;
    cancelOrder.centerX = self.view.centerX;
    [self.view addSubview:cancelOrder];
    
    if ([self.orderType isEqualToString:@"1"])
    {
        //通过
        imgView.image = [UIImage imageNamed:@"icon_success.png"];
        scoreLabel.text = [NSString stringWithFormat:@"您已成功预约教练%@",self.coachDict[@"master_name"]];
        promptOneLabel.text = @"请等待教练响应，您也可以主动联系教练";
        coachCellPhoneLabel.opaque = YES;
        coachCellPhoneLabel.text = [NSString stringWithFormat:@"教练电话：%@",self.coachDict[@"cellphone"]];
        remindLabel.opaque = YES;
        remindLabel.text = @"如果您想预约其他教练，请取消预约";
        
        cancelOrder.hidden = NO;
        [cancelOrder addTarget:self action:@selector(cancelOrderClick) forControlEvents:UIControlEventTouchUpInside];
    }
   else
   {
        //未通过
       imgView.image = [UIImage imageNamed:@"test_ico_suc.png"];
       scoreLabel.text = @"预约失败!";
       promptOneLabel.text = @"您已预约过其他教练，如必须更换教练，请拨打客服电话0755 - 86935803";
    }
}

- (void)cancelOrderClick{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"%@%@", BASE_PLAN_URL, trainee_course_cancelOrder];
    [manager POST:url parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            [SVProgressHUD showSuccessWithStatus:@"取消预约成功"];
            // 取消预约成功
            [self tabBarControllerSelectIndex:1];
        }else{
            [SVProgressHUD showErrorWithStatus:@"取消预约失败，请稍后再试"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"取消预约请求失败"];
    }];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
