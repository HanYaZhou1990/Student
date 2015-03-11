//
//  AnswerViewController.m
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/2/28.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "AnswerViewController.h"

@interface AnswerViewController () {
    UIView    *_cellSelectedView;
}
@end

@implementation AnswerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"模拟考试";
    
    [self leftBarItem];
    
    _cellSelectedView = [[UIView alloc] init];
    _cellSelectedView.backgroundColor = [UIColor whiteColor];
}

- (void)leftBarItem
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"icon_return.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"icon_return.png"] forState:UIControlStateHighlighted];
    backButton.frame = CGRectMake(0, 0, 21.5, 13.5);    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    _questionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT) style:UITableViewStylePlain];
    _questionTableView.dataSource = self;
    _questionTableView.delegate = self;
    _questionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_questionTableView registerClass:[ExaminationCell class] forCellReuseIdentifier:@"cell"];
    [_questionTableView registerClass:[AnswerCell class] forCellReuseIdentifier:@"answerCell"];
    _questionTableView.tableFooterView = [UIView new];
    [self.view addSubview:_questionTableView];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"下一题" forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    button.frame = CGRectMake(SCREEN_WIDTH - 100, SCREEN_HEIGHT -NAV_HEIGHT - 100, 80, 40);
    [button addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
- (void)next:(UIButton *)sender {
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:1.5];
    self.view.userInteractionEnabled = NO;
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:_questionTableView cache:YES];
    [UIView commitAnimations];
    self.view.userInteractionEnabled = YES;
}
#pragma mark -
#pragma mark UITableViewDataSource -

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"第一题/共100题";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 44;
    }
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        CGFloat questionHeight = [PublicConfig height:@"你过来，看看这个题选哪个，选错了打死你" widthOfFatherView:SCREEN_WIDTH-60 textFont:[UIFont systemFontOfSize:16.0]];
        return questionHeight + 20 + 180;
    }else{
        return 44;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ExaminationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.questionString = @"你过来，看看这个题选哪个，选错了打死你";
        cell.imageString = @"png.png";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        AnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"answerCell" forIndexPath:indexPath];
        cell.selectedBackgroundView = _cellSelectedView;
        return cell;
    }
}

#pragma mark -
#pragma mark UITableViewDelegate-

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
