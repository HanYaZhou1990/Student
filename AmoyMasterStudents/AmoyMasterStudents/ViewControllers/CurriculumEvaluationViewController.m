//
//  CurriculumEvaluationViewController.m
//  AmoyMasterStudents
//
//  Created by hanyazhou on 15/4/1.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "CurriculumEvaluationViewController.h"

@interface CurriculumEvaluationViewController () {
    UIScrollView                *_backgroundScrollView;
    UIView                      *_backView;
    CustomTextView              *_textView;
    CurriculumView              *_starView;
    BadReviewView               *_badReviewV;
    BadReviewView               *_badReviewV1;
    UILabel                     *_rewardsLab;
    UIButton                    *_overButton;
    CustomSegument              *_moneySegument;
    UIButton                    *_complaintButton;
}

@end

@implementation CurriculumEvaluationViewController

- (void)doNothing {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"课程评价";
    
    self.navigationController.navigationBarHidden = NO;
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(doNothing)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    
    _backgroundScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT)];
    _backgroundScrollView.backgroundColor = UIColorFromRGB(0x01bc8e);
    _backgroundScrollView.showsVerticalScrollIndicator = NO;//隐藏垂直滚动条
    _backgroundScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 540);
    [self.view addSubview:_backgroundScrollView];
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH-20, 420)];
    _backView.backgroundColor = UIColorFromRGB(0xF0F0F0);
    _backView.layer.cornerRadius = 5.0;
    _backView.clipsToBounds = YES;
    [_backgroundScrollView addSubview:_backView];
    
    _complaintButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _complaintButton.bounds = CGRectMake(0, 0, SCREEN_WIDTH/2, 44);
    _complaintButton.center = CGPointMake(SCREEN_WIDTH/2, CGRectGetMaxY(_backView.frame)+24);
    [_complaintButton setTitle:@"去投诉" forState:UIControlStateNormal];
    [_complaintButton setTitleColor:UIColorFromRGB(0xF0F0F0) forState:UIControlStateNormal];
    [_complaintButton addTarget:self action:@selector(complaint:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundScrollView addSubview:_complaintButton];
    
    CGFloat width = CGRectGetWidth(_backView.frame);
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, width, 40)];
    titleLable.text = @"恭喜您完成课程一的学习";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textColor = UIColorFromRGB(0x01bc8e);
    titleLable.font = [UIFont systemFontOfSize:22.0];
    [_backView addSubview:titleLable];
    
    UILabel *detailLable = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLable.frame), width, 20)];
    detailLable.text = @"完成课程评价将再获得五元红包";
    detailLable.textAlignment = NSTextAlignmentCenter;
    detailLable.textColor = UIColorFromRGB(0x01bc8e);
    detailLable.font = [UIFont systemFontOfSize:16.0];
    [_backView addSubview:detailLable];
    
    
    _starView = [[CurriculumView alloc] initWithFrame:CGRectMake(-0.5, CGRectGetMaxY(detailLable.frame)+10, width+1, 44)];
    _starView.starRateView.delegate = self;
    [_backView addSubview:_starView];
    
    
    _textView= [[CustomTextView alloc] initWithFrame:CGRectMake(-0.5, CGRectGetMaxY(_starView.frame), width+1, 160)];
    _textView.contentTextView.delegate = self;
    [_backView addSubview:_textView];

    _badReviewV = [[BadReviewView alloc] initWithFrame:CGRectMake(-0.5, CGRectGetMaxY(_textView.frame), width+1, 120)];
    _badReviewV.titleString = @"因为您选择了2分,请您选择理由,我们会对教练加强培训:";
    _badReviewV.itemArray = @[@"骚扰",@"教学态度恶劣",@"技术太差",@"其他"];
    _badReviewV.hidden = YES;
    [_backView addSubview:_badReviewV];
    
    _badReviewV1 = [[BadReviewView alloc] initWithFrame:CGRectMake(-0.5, CGRectGetMaxY(_badReviewV.frame), width+1, 120)];
    _badReviewV1.titleString = @"您是否对教练不满,是否需要更换教练?";
    _badReviewV1.itemArray = @[@"更换教练",@"重上本节",@"其他要求"];
    _badReviewV1.hidden = YES;
    [_backView addSubview:_badReviewV1];
    
    _rewardsLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_textView.frame)+10, 80, 20)];
    _rewardsLab.text = @"打赏:";
    _rewardsLab.textColor = [UIColor blackColor];
    _rewardsLab.font = [UIFont systemFontOfSize:16.0];
    _rewardsLab.hidden = NO;
    [_backView addSubview:_rewardsLab];
    
    _moneySegument = [[CustomSegument alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_rewardsLab.frame), width, 44)];
    _moneySegument.delegate = self;
    _moneySegument.hidden = NO;
    _moneySegument.titleArray = @[@"不给",@"5",@"10",@"20",@"50"];
    [_backView addSubview:_moneySegument];
    
    _overButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _overButton.frame = CGRectMake(40, CGRectGetMaxY(_moneySegument.frame)+10, width-80, 44);
    [_overButton setBackgroundImage:[UIImage imageNamed:@"evaluation_btn_complete.png"] forState:UIControlStateNormal];
    [_overButton setBackgroundImage:[UIImage imageNamed:@"evaluation_btn_complete_active.png"] forState:UIControlStateHighlighted];
    [_overButton addTarget:self action:@selector(overButtonCliecked:) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_overButton];
}
- (void)googReview {
    _backgroundScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 540);
    _backView.frame = CGRectMake(10, 40, SCREEN_WIDTH-20, 420);
    
    _complaintButton.bounds = CGRectMake(0, 0, SCREEN_WIDTH/2, 44);
    _complaintButton.center = CGPointMake(SCREEN_WIDTH/2, CGRectGetMaxY(_backView.frame)+24);
    
    CGFloat width = CGRectGetWidth(_backView.frame);
    
    _textView.frame = CGRectMake(-0.5, CGRectGetMaxY(_starView.frame), width+1, 160);
    _badReviewV.hidden = YES;
    _badReviewV1.hidden = YES;
    _rewardsLab.hidden = NO;
    _rewardsLab.frame = CGRectMake(10, CGRectGetMaxY(_textView.frame)+10, 80, 20);
    _moneySegument.hidden = NO;
    _moneySegument.frame = CGRectMake(0, CGRectGetMaxY(_rewardsLab.frame), width, 44);
    _overButton.frame = CGRectMake(40, CGRectGetMaxY(_moneySegument.frame)+10, width-80, 44);
}

- (void)badReview {
    _backgroundScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 640);
    _backView.frame = CGRectMake(10, 40, SCREEN_WIDTH-20, 520);
    
    _complaintButton.bounds = CGRectMake(0, 0, SCREEN_WIDTH/2, 44);
    _complaintButton.center = CGPointMake(SCREEN_WIDTH/2, CGRectGetMaxY(_backView.frame)+24);
    
    CGFloat width = CGRectGetWidth(_backView.frame);
    
    _textView.frame = CGRectMake(-0.5, CGRectGetMaxY(_starView.frame), width+1, 80);
    _badReviewV.hidden = NO;
    _badReviewV.frame = CGRectMake(-0.5, CGRectGetMaxY(_textView.frame), width+1, 120);
    _badReviewV1.hidden = NO;
    _badReviewV1.frame = CGRectMake(-0.5, CGRectGetMaxY(_badReviewV.frame), width+1, 120);
    _rewardsLab.hidden = YES;
    _moneySegument.hidden = YES;
    _overButton.frame = CGRectMake(40, CGRectGetMaxY(_badReviewV1.frame)+10, width-80, 44);
}
- (void)overButtonCliecked:(UIButton *)sender {
    DLog(@"完成");
}

#pragma mark -
#pragma mark 前往投诉页 -
- (void)complaint:(UIButton *)sender {
    ComplaintViewController *viewController = [[ComplaintViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
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
#pragma mark CWStarRateViewDelegate -

- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent {
    if (newScorePercent >0.2) {
        [self googReview];
    }else {
        DLog(@"***********%f",newScorePercent);
        [self badReview];
    }
}

#pragma mark -
#pragma mark CustomSegumentDelegate -
- (void)fromView:(UIView *)view didSelectIndex:(NSInteger)indexOfButton {
    DLog(@"%ld",(long)indexOfButton);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end