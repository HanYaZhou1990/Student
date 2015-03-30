//
//  ExamViewController.m
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/2/28.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "ExamViewController.h"

@interface ExamViewController ()

@end

@implementation ExamViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"模拟考试";
    
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
    
    
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.bounds = CGRectMake(0, 0, SCREEN_WIDTH - 40, 44);
    titleLable.center = CGPointMake(SCREEN_WIDTH/2, 40);
    titleLable.textColor = [UIColor blackColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = @"您现在进入了模拟笔试，请您选择考试类型";
    titleLable.font = [UIFont systemFontOfSize:18];
    titleLable.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:titleLable];

    NSArray *titleArray = @[@"小车",@"货车",@"客车"];
    
    for (int i = 0; i < 3; i ++) {
        UIButton *typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        typeButton.backgroundColor = [UIColor whiteColor];
        typeButton.bounds = CGRectMake(0, 0, SCREEN_WIDTH/3*2, 44);
        typeButton.center = CGPointMake(SCREEN_WIDTH/2, CGRectGetMaxY(titleLable.frame)+64 + i *74 );
        typeButton.tag = i;
        [typeButton setTitle:titleArray[i] forState:UIControlStateNormal];
        [typeButton setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateNormal];
        typeButton.layer.cornerRadius = 22.0;
        typeButton.clipsToBounds = YES;
        typeButton.layer.borderColor = RGBA(0, 165, 109, 1).CGColor;
        typeButton.layer.borderWidth = 1.0;
        [typeButton addTarget:self action:@selector(typeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:typeButton];
    }
}

-(void)backAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)typeButtonClicked:(UIButton *)sender{
    AnswerViewController *viewController = [[AnswerViewController alloc] init];
    switch (self.examType) {
        case 0:
        {
        switch (sender.tag) {
            case 0:
            {
            viewController.subjectType = AnswerViewControllerSubjectTypeOne;
            viewController.modelsType = AnswerViewControllerModelsTypeCar;
            }
                break;
            case 1:
            {
            viewController.subjectType = AnswerViewControllerSubjectTypeOne;
            viewController.modelsType = AnswerViewControllerModelsTypeTruck;
            }
                break;
            case 2:
            {
            viewController.subjectType = AnswerViewControllerSubjectTypeOne;
            viewController.modelsType = AnswerViewControllerModelsTypeBus;
            }
                break;
                
            default:
                break;
        }
        }
            break;
        case 1:
        {
        switch (sender.tag) {
            case 0:
            {
            viewController.subjectType = AnswerViewControllerSubjectTypeFour;
            viewController.modelsType = AnswerViewControllerModelsTypeCar;
            }
                break;
            case 1:
            {
            viewController.subjectType = AnswerViewControllerSubjectTypeFour;
            viewController.modelsType = AnswerViewControllerModelsTypeTruck;
            }
                break;
            case 2:
            {
            viewController.subjectType = AnswerViewControllerSubjectTypeFour;
            viewController.modelsType = AnswerViewControllerModelsTypeBus;
            }
                break;
                
            default:
                break;
        }
        }
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
