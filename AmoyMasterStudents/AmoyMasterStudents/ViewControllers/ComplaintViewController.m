//
//  ComplaintViewController.m
//  AmoyMasterStudents
//
//  Created by hanyazhou on 15/4/1.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "ComplaintViewController.h"

@interface ComplaintViewController ()

@end

@implementation ComplaintViewController

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
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self leftBarItem];
    
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
    
    
    CustomTextView *textView = [[CustomTextView alloc] initWithFrame:CGRectMake(-0.5, CGRectGetMaxY(titLable.frame), width+1, 160)];
    textView.contentTextView.delegate = self;
    [backView addSubview:textView];
    
    
    UILabel *rewardsLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(textView.frame)+10, 180, 20)];
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
    DLog(@"提交");
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
    DLog(@"%ld",(long)indexOfButton);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
