//
//  WrongViewController.m
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/3/31.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "WrongViewController.h"

@interface WrongViewController () <UITableViewDataSource,UITableViewDelegate> {
    UIView                    *_cellSelectedView;
    UITableView               *_wrongQuestionTableView;
}

@end

@implementation WrongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看错题";
    
    _cellSelectedView = [[UIView alloc] init];
    _cellSelectedView.backgroundColor = [UIColor whiteColor];
    
    [self leftBarItem];
    
    _wrongQuestionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT) style:UITableViewStylePlain];
    _wrongQuestionTableView.dataSource = self;
    _wrongQuestionTableView.delegate = self;
    _wrongQuestionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_wrongQuestionTableView registerClass:[ExaminationCell class] forCellReuseIdentifier:@"cell"];
    [_wrongQuestionTableView registerClass:[AnswerCell class] forCellReuseIdentifier:@"answerCell"];
    _wrongQuestionTableView.tableFooterView = [UIView new];
    [self.view addSubview:_wrongQuestionTableView];
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

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 
#pragma mark UITableViewDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _wrongArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger questionIndex = [[NSString stringWithFormat:@"%ld",[_wrongArray[section][@"order"] integerValue]] integerValue];
    return [_questionArray[questionIndex-1][@"options"] count]+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NSInteger questionIndex = [[NSString stringWithFormat:@"%ld",[_wrongArray[indexPath.section][@"order"] integerValue]] integerValue];

        if ([_questionArray[questionIndex-1][@"images"] count] == 0) {
            CGFloat questionHeight = [PublicConfig height:_questionArray[questionIndex-1][@"content"] widthOfFatherView:SCREEN_WIDTH-60 textFont:[UIFont systemFontOfSize:16.0]];
            return questionHeight + 20;
        }else {
            CGFloat questionHeight = [PublicConfig height:_questionArray[questionIndex-1][@"content"] widthOfFatherView:SCREEN_WIDTH-60 textFont:[UIFont systemFontOfSize:16.0]];
            return questionHeight + 20 + 180;
        }
    }else {
        return 64;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger questionIndex = [[NSString stringWithFormat:@"%ld",[_wrongArray[indexPath.section][@"order"] integerValue]] integerValue];

    if (indexPath.row == 0) {
        ExaminationCell *questionCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        questionCell.numberString = [NSString stringWithFormat:@"%02li.",[_wrongArray[indexPath.section][@"order"] integerValue]];
        questionCell.questionString = _questionArray[questionIndex-1][@"content"];
        if ([_questionArray[questionIndex-1][@"images"] count] == 0) {
            questionCell.imageString = nil;
        }else {
            questionCell.imageString = _questionArray[questionIndex-1][@"images"][0];
        }
        questionCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return questionCell;
    }else {
        AnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"answerCell" forIndexPath:indexPath];
        cell.selectedBackgroundView = _cellSelectedView;
        cell.userInteractionEnabled = NO;
        NSString *userAnserString = [NSString stringWithFormat:@"%@",_wrongArray[indexPath.section][@"sa"]];
        if ([userAnserString isEqualToString:@"A"] && indexPath.row == 1) {
            cell.cellType = AnswerCellTypeSee;
        }else if ([userAnserString isEqualToString:@"B"] && indexPath.row == 2) {
            cell.cellType = AnswerCellTypeSee;
        }else if ([userAnserString isEqualToString:@"C"] && indexPath.row == 3) {
            cell.cellType = AnswerCellTypeSee;
        }else if ([userAnserString isEqualToString:@"D"] && indexPath.row == 4) {
            cell.cellType = AnswerCellTypeSee;
        }else{
            cell.cellType = AnswerCellTypeExam;
        }
        NSString *answerString = [NSString stringWithFormat:@"%@",_wrongArray[indexPath.section][@"ca"]];
        if ([answerString isEqualToString:@"A"] && indexPath.row == 1) {
            cell.contentString =[NSString stringWithFormat:@"%@.%@%@",_questionArray[questionIndex-1][@"options"][indexPath.row-1][@"optChar"],_questionArray[questionIndex-1][@"options"][indexPath.row-1][@"content"],@" (正确答案)"];
        }else if ([answerString isEqualToString:@"B"] && indexPath.row == 2) {
            cell.contentString =[NSString stringWithFormat:@"%@.%@%@",_questionArray[questionIndex-1][@"options"][indexPath.row-1][@"optChar"],_questionArray[questionIndex-1][@"options"][indexPath.row-1][@"content"],@" (正确答案)"];
        }else if ([answerString isEqualToString:@"C"] && indexPath.row == 3) {
            cell.contentString =[NSString stringWithFormat:@"%@.%@%@",_questionArray[questionIndex-1][@"options"][indexPath.row-1][@"optChar"],_questionArray[questionIndex-1][@"options"][indexPath.row-1][@"content"],@" (正确答案)"];
        }else if ([answerString isEqualToString:@"D"] && indexPath.row == 4) {
            cell.contentString =[NSString stringWithFormat:@"%@.%@%@",_questionArray[questionIndex-1][@"options"][indexPath.row-1][@"optChar"],_questionArray[questionIndex-1][@"options"][indexPath.row-1][@"content"],@" (正确答案)"];
        }else{
            cell.contentString =[NSString stringWithFormat:@"%@.%@",_questionArray[questionIndex-1][@"options"][indexPath.row-1][@"optChar"],_questionArray[questionIndex-1][@"options"][indexPath.row-1][@"content"]];
        }
        return cell;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
