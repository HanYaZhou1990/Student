//
//  WrongViewController.m
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/3/31.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "WrongViewController.h"

@interface WrongViewController () <UITableViewDataSource,UITableViewDelegate> {
    UITableView               *_wrongQuestionTableView;
}

@end

@implementation WrongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看错题";
    
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ExaminationCell *questionCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        questionCell.numberString = [NSString stringWithFormat:@"02."];
        questionCell.questionString = @"This is the question,please answer it now !";
        questionCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return questionCell;
    }else {
        AnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"answerCell" forIndexPath:indexPath];
        cell.contentString = @"A:This is the answer !";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
