//
//  ExamResultViewController.m
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/3/30.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "ExamResultViewController.h"

@interface ExamResultViewController ()

@end

@implementation ExamResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"模拟考试";
    
    UIScrollView  *answerScrollView = [[UIScrollView alloc] init];
    answerScrollView.backgroundColor = [UIColor whiteColor];
    answerScrollView.showsVerticalScrollIndicator = NO;
    answerScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*1.2);
    self.view = answerScrollView;

    UILabel *scoreLable = [[UILabel alloc]init];
    scoreLable.bounds = CGRectMake(0, 0, 80, 40);
    scoreLable.center = CGPointMake(SCREEN_WIDTH/2, 40);
    scoreLable.text = [NSString stringWithFormat:@"%@",_dataDictionary[@"score"]];
    scoreLable.font = [UIFont systemFontOfSize:44.0];
    scoreLable.textColor = UIColorFromRGB(0x666666);
    scoreLable.adjustsFontSizeToFitWidth = YES;
    scoreLable.textAlignment = NSTextAlignmentCenter;
    [answerScrollView addSubview:scoreLable];
    
    UILabel *wakeLable = [[UILabel alloc]init];
    wakeLable.frame = CGRectMake(40, CGRectGetMaxY(scoreLable.frame)+10, SCREEN_WIDTH-80, 60);
    if ([_dataDictionary[@"isPassed"] boolValue]) {
        if (_subjectType == ExamResultViewControllerSubjectTypeOne) {
            wakeLable.text = @"恭喜您,通过科目一模拟考试\n保持状态,拼搏吧";
        }else {
            wakeLable.text = @"恭喜您,通过科目四模拟考试\n保持状态,拼搏吧";
        }
    }else {
        if (_subjectType == ExamResultViewControllerSubjectTypeOne) {
            wakeLable.text = @"很遗憾,未通过科目一模拟考试\n继续努力";
        }else {
            wakeLable.text = @"很遗憾,未通过科目四模拟考试\n继续努力";
        }
    }
    wakeLable.font = [UIFont systemFontOfSize:20.0];
    wakeLable.textColor = UIColorFromRGB(0x3D3D3D);
    wakeLable.adjustsFontSizeToFitWidth = YES;
    wakeLable.textAlignment = NSTextAlignmentCenter;
    wakeLable.numberOfLines = 2;
    [answerScrollView addSubview:wakeLable];
    
    
    UILabel *titleLable = [[UILabel alloc]init];
    titleLable.frame = CGRectMake(15, CGRectGetMaxY(wakeLable.frame)+10, 200, 20);
    titleLable.text = @"题目答案如下:";
    titleLable.font = [UIFont systemFontOfSize:16.0];
    titleLable.textColor = UIColorFromRGB(0x666666);
    [answerScrollView addSubview:titleLable];
    
    NSArray *array = [[NSArray alloc] initWithArray:_dataDictionary[@"questions"]];
    NSInteger count = array.count;
    
    CGFloat height = ((count%WIDTH_COUNT==0)?(count/WIDTH_COUNT):(count/WIDTH_COUNT+1))*ITEM_Height;
    AnswerView *allAnswersView = [[AnswerView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(titleLable.frame)+10, SCREEN_WIDTH-30, height+count/6)];
    allAnswersView.answerArray = array;
    [answerScrollView addSubview:allAnswersView];
    
    UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkButton setTitle:@"查看出错题目" forState:UIControlStateNormal];
    [checkButton setTitleColor:UIColorFromRGB(0xF0F0F0) forState:UIControlStateNormal];
    checkButton.frame = CGRectMake(15, CGRectGetMaxY(allAnswersView.frame)+20, SCREEN_WIDTH - 30, 44);
    [checkButton setBackgroundColor:UIColorFromRGB(0x666666)];
    [checkButton addTarget:self action:@selector(goToWrongViewController:) forControlEvents:UIControlEventTouchUpInside];
    [answerScrollView addSubview:checkButton];
    
    answerScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(checkButton.frame)+40);
    
    [self leftBarItem];
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

#pragma mark -
#pragma mark 前往错题展示页 -
- (void)goToWrongViewController:(UIButton *)sender {
    WrongViewController *errorViewController = [[WrongViewController alloc] init];
    [self.navigationController pushViewController:errorViewController animated:YES];
}

-(void)backAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
