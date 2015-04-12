//
//  ComplaintViewController.m
//  AmoyMasterStudents
//
//  Created by hanyazhou on 15/4/1.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "ComplaintViewController.h"

@interface ComplaintViewController () {
    CustomTextView          *_textView;
    NSString                *_complainType;
}

@end

@implementation ComplaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self leftBarItem];
    
    _complainType = @"0";
    
    UIScrollView *backgroundScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT)];
    backgroundScrollView.backgroundColor = UIColorFromRGB(0x01bc8e);
    backgroundScrollView.showsVerticalScrollIndicator = NO;//隐藏垂直滚动条
    backgroundScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 460);
    [self.view addSubview:backgroundScrollView];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH-20, 360)];
    backView.backgroundColor = UIColorFromRGB(0xF0F0F0);
    backView.layer.cornerRadius = 5.0;
    backView.clipsToBounds = YES;
    [backgroundScrollView addSubview:backView];
    
    CGFloat width = CGRectGetWidth(backView.frame);
    
    UILabel *titLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 44)];
    titLable.text = @"被投诉人:";
    titLable.textColor = [UIColor blackColor];
    titLable.font = [UIFont systemFontOfSize:16.0];
    [backView addSubview:titLable];
    
    UILabel *teachName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titLable.frame), 0, width - CGRectGetMaxX(titLable.frame), 44)];
    teachName.text = @"投诉人";
    teachName.textColor = UIColorFromRGB(0x01bc8e);
    teachName.font = [UIFont systemFontOfSize:16.0];
    [backView addSubview:teachName];
    
    
    _textView = [[CustomTextView alloc] initWithFrame:CGRectMake(-0.5, CGRectGetMaxY(titLable.frame), width+1, 160)];
    _textView.contentTextView.delegate = self;
    [backView addSubview:_textView];
    
    
    UILabel *rewardsLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_textView.frame)+10, 180, 20)];
    rewardsLab.text = @"期望处理结果:";
    rewardsLab.textColor = [UIColor blackColor];
    rewardsLab.font = [UIFont systemFontOfSize:16.0];
    [backView addSubview:rewardsLab];
    
    CustomSegument *moneySegument = [[CustomSegument alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(rewardsLab.frame), width, 44)];
    moneySegument.delegate = self;
    moneySegument.titleArray = @[@"重上本节",@"更换教练",@"其它要求"];
    [backView addSubview:moneySegument];
    
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(40, CGRectGetMaxY(moneySegument.frame)+6, width-80, 44);
    [submitButton setBackgroundImage:[UIImage imageNamed:@"evaluation_btn_complete.png"] forState:UIControlStateNormal];
    [submitButton setBackgroundImage:[UIImage imageNamed:@"evaluation_btn_complete_active.png"] forState:UIControlStateHighlighted];
    [submitButton addTarget:self action:@selector(submitButtonCliecked:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:submitButton];
}

- (void)submitButtonCliecked:(UIButton *)sender {
    [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"加载中..." animated:YES];
    
    NSString *useUrl = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL,trainee_course_complain];
    
    NSDictionary *params = @{@"class_id":@(self.class_id),@"comment":_textView.contentTextView.text,@"complain_type":_complainType,@"token":[PublicConfig valueForKey:userToken]};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:useUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSString *resultCode = [responseDic valueForKey:@"code"]; //0成功 1失败
        if ([resultCode boolValue]==NO){
            /*这里处理评论成功的代码*/
            [SVProgressHUD showSuccessWithStatus:@"投诉已提交，感谢您的建议"];
            [self tabBarControllerSelectIndex:2];
            
        }else {
            NSString *msgStr = [responseDic valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:[PublicConfig isSpaceString:msgStr andReplace:@"投诉失败"]];
        }
        DLog(@"responseDic = %@",[PublicConfig dictionaryToJson:responseDic]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [SVProgressHUD showErrorWithStatus:@"投诉请求失败"];
    }];
}

#pragma mark -
#pragma mark UITextViewDelegate -
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark CustomSegumentDelegate -
- (void)fromView:(UIView *)view didSelectIndex:(NSInteger)indexOfButton {
    _complainType = [NSString stringWithFormat:@"%ld",(long)indexOfButton + 1];
}


#pragma 返回按钮
- (void)leftBarItem
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"icon_return.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"icon_return.png"] forState:UIControlStateHighlighted];
    backButton.frame = CGRectMake(0, 0, 21.5, 13.5);    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}
-(void)backAction {
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
