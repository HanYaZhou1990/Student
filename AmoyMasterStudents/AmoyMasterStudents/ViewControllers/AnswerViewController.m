//
//  AnswerViewController.m
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/2/28.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "AnswerViewController.h"


/*!如果考试时间到了，结束考试
 如果最后一题做完了，，结束考试
 做一半的时候，放弃考试*/
@interface AnswerViewController () {
    UIView           *_cellSelectedView;
    NSMutableArray   *_answerArray;/*保存答案*/
    NSString         *_examTokenString;/*这套题的examToken*/
    
    YYLable          *_lable;
    long long        _tiemDate;
}
@end

@implementation AnswerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"模拟考试";
    
    /*进入页面倒计时监测时间*/
    [self monitorTheTime];
    
    _tiemDate = 9999999999;
    
    _questionsArray = [NSArray array];
    _answerArray = [NSMutableArray array];
    _currentInteger = 0;
    _examTokenString = @"";
    
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
    
    _questionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-44) style:UITableViewStylePlain];
    _questionTableView.dataSource = self;
    _questionTableView.delegate = self;
    _questionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_questionTableView registerClass:[ExaminationCell class] forCellReuseIdentifier:@"cell"];
    [_questionTableView registerClass:[AnswerCell class] forCellReuseIdentifier:@"answerCell"];
    _questionTableView.tableFooterView = [UIView new];
    [self.view addSubview:_questionTableView];
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    _lable = [[YYLable alloc] initWithFrame:CGRectMake(0, 0, rect.size.width/3*2, 36) outTime:0];
    _lable.center = CGPointMake(rect.size.width/2, 22);
    [self.view addSubview:_lable ];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"下一题" forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    button.frame = CGRectMake(SCREEN_WIDTH - 100, SCREEN_HEIGHT -NAV_HEIGHT - 100, 100, 64);
    [button addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [self getAllQuesstionWithSubjectType:NO];
    
}

- (void)next:(UIButton *)sender {
    _currentInteger ++;
    if (_currentInteger >= _questionsArray.count-1) {
        [sender setTitle:@"提交" forState:UIControlStateNormal];
        if (!(_answerArray.count < _currentInteger)) {
            if (_currentInteger >= _questionsArray.count) {
                _currentInteger = _currentInteger -1;
                [self showAlertViewWithMessage:@"答题完毕，提交试卷"];
                return;
            }
        }else {
            _currentInteger = _currentInteger -1;
            [SVProgressHUD showErrorWithStatus:@"请选择一个合适答案"];
        }
    }
    /*必须把展示的这一题做完，不做的话，不切换到下一题*/
    if (!(_answerArray.count < _currentInteger)) {
        if (_currentInteger >= _questionsArray.count) {
            _currentInteger = _currentInteger -1;
            [self showAlertViewWithMessage:@"答题完毕，提交试卷"];
            return;
        }else {
            [_questionTableView reloadData];
            [UIView transitionWithView:_questionTableView duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
                sender.userInteractionEnabled = NO;
            } completion:^(BOOL finished) {
                sender.userInteractionEnabled = YES;
            }];
        }
    }else {
        _currentInteger = _currentInteger -1;
        [SVProgressHUD showErrorWithStatus:@"请选择一个合适答案"];
    }
}

/*获取考题列表，NO：科目一  YES：科目四*/
- (void)getAllQuesstionWithSubjectType:(BOOL)subjectType {
    [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"加载中..." animated:YES];
    
    NSString *useUrl = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL,trainee_mockExam_init];
    /*car   truce  bus*/
    NSDictionary *params = @{@"type":@"car",@"preloadAmount":@"100",@"token":userToken};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:useUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        
        DLog(@"%@",[PublicConfig dictionaryToJson:responseDic]);
        
        NSString *resultCode = [responseDic valueForKey:@"code"]; //0成功 1失败
        if ([resultCode boolValue]==NO){
            NSDictionary *dataDic = [responseDic valueForKey:@"data"];
            if (dataDic){
                _tiemDate = [dataDic[@"expireTime"] longLongValue];
                _lable.outTime = _tiemDate - [[NSDate date] timeIntervalSince1970];
                _questionsArray = dataDic[@"questions"];
                _examTokenString = dataDic[@"examToken"];
                [_questionTableView reloadData];
            }
        }else{
            NSString *msgStr = [responseDic valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:[PublicConfig isSpaceString:msgStr andReplace:@"获取考题列表失败"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [SVProgressHUD showErrorWithStatus:@"获取考题列表请求失败"];
    }];
}

#pragma mark -
#pragma mark UITableViewDataSource -

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"第 %lu 题/共%lu题",(unsigned long)_currentInteger+1,(long)_questionsArray.count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 44;
    }
    return 0.1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    /*_questionsArray 储存所有的考题，通过全局的，通过_currentInteger来取现在展示的是第几题，通过第几题里边的options里边的元素个数＋1得到这个tableView的行数*/
    if (_questionsArray.count == 0) {
        return 0;
    }else{
        return [_questionsArray[_currentInteger][@"options"] count]+1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if ([_questionsArray[_currentInteger][@"images"] count] == 0) {
            CGFloat questionHeight = [PublicConfig height:_questionsArray[_currentInteger][@"content"] widthOfFatherView:SCREEN_WIDTH-60 textFont:[UIFont systemFontOfSize:16.0]];
            return questionHeight + 20;
        }else {
            CGFloat questionHeight = [PublicConfig height:_questionsArray[_currentInteger][@"content"] widthOfFatherView:SCREEN_WIDTH-60 textFont:[UIFont systemFontOfSize:16.0]];
            return questionHeight + 20 + 180;
        }
    }else{
        return 64;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ExaminationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.numberString = [NSString stringWithFormat:@"%02li.",_currentInteger+1];
        cell.questionString = _questionsArray[_currentInteger][@"content"];
        if ([_questionsArray[_currentInteger][@"images"] count] == 0) {
            cell.imageString = nil;
        }else {
            cell.imageString = _questionsArray[_currentInteger][@"images"][0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        AnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"answerCell" forIndexPath:indexPath];
        cell.selectedBackgroundView = _cellSelectedView;
        cell.contentString =[NSString stringWithFormat:@"%@.%@",_questionsArray[_currentInteger][@"options"][indexPath.row-1][@"optChar"],_questionsArray[_currentInteger][@"options"][indexPath.row-1][@"content"]];
        return cell;
    }
}

#pragma mark -
#pragma mark UITableViewDelegate-

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return;
    }
    /*解决同一题，选择了两次，数组中就插入了两个答案的bug*/
    if ([_answerArray.lastObject[@"code"] isEqualToString:_questionsArray[_currentInteger][@"code"]]) {
        [_answerArray replaceObjectAtIndex:_answerArray.count-1 withObject:@{@"code":_questionsArray[_currentInteger][@"code"],@"value":_questionsArray[_currentInteger][@"options"][indexPath.row-1][@"optChar"]}];
    }else {
        [_answerArray addObject:@{@"code":_questionsArray[_currentInteger][@"code"],@"value":_questionsArray[_currentInteger][@"options"][indexPath.row-1][@"optChar"]}];
    }
}

-(void)backAction
{
    /*点击返回按钮的时候，如果已经做完就提交试卷，如果没做完，就放弃考试*/
    if (_currentInteger == _questionsArray.count) {
        [self showAlertViewWithMessage:@"答题完毕，提交试卷"];
    }else {
        [self showAlertViewWithMessage:@"放弃考试，提交试卷"];
    }
}

#pragma mark - 
#pragma mark UIAlertViewDelegate -
- (void)showAlertViewWithMessage:(NSString *)messageString {
    [[[UIAlertView alloc] initWithTitle:@"" message:messageString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    /*!提交试卷*/
    if ([alertView.message isEqualToString:@"放弃考试，提交试卷"]) {
        [self giveUpExamination];
    }else {
        [self examinationOver];
    }
}

#pragma mark -
#pragma mark 放弃考试/考试结束 -
- (void)giveUpExamination {
    [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"加载中..." animated:YES];
    
    NSString *useUrl = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL,trainee_mockExam_end];
    
    NSDictionary *params = @{@"examToken":_examTokenString,@"token":[PublicConfig valueForKey:userToken]};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:useUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSString *resultCode = [responseDic valueForKey:@"code"]; //0成功 1失败
        if ([resultCode boolValue]==NO){
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            NSString *msgStr = [responseDic valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:[PublicConfig isSpaceString:msgStr andReplace:@"提交试卷失败"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [SVProgressHUD showErrorWithStatus:@"获取文章列表请求失败"];
    }];
}

- (void)examinationOver {
    [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"加载中..." animated:YES];
    
    NSString *useUrl = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL,trainee_mockExam_submit];
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:_answerArray options:kNilOptions error:&error];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    string = [string stringByReplacingOccurrencesOfString:@"[" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"]" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"},{" withString:@"};{"];
    NSDictionary *params = @{@"examToken":_examTokenString,@"answerSheet":string,@"token":[PublicConfig valueForKey:userToken]};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:useUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        
        DLog(@"%@",[PublicConfig dictionaryToJson:responseDic]);
        
        NSString *resultCode = [responseDic valueForKey:@"code"]; //0成功 1失败
        if ([resultCode boolValue]==NO){
            NSDictionary *dataDic = [responseDic valueForKey:@"data"];
            if (dataDic){
                ExamResultViewController *resultViewController = [[ExamResultViewController alloc] init];
                resultViewController.dataDictionary = dataDic;
                resultViewController.questionArray = _questionsArray;
                if (self.subjectType == AnswerViewControllerSubjectTypeOne) {
                    resultViewController.subjectType = ExamResultViewControllerSubjectTypeOne;
                }else {
                    resultViewController.subjectType = ExamResultViewControllerSubjectTypeFour;
                }
                [self.navigationController pushViewController:resultViewController animated:YES];
            }
        }else{
            NSString *msgStr = [responseDic valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:[PublicConfig isSpaceString:msgStr andReplace:@"提交试卷失败"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [SVProgressHUD showErrorWithStatus:@"提交试卷请求失败"];
    }];
}

#pragma mark -
#pragma mark 监测时间 -
- (void)monitorTheTime {
    __block int timeout=6000; /*倒计时时间*/
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); /*每秒执行*/
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){
            /*倒计时结束，关闭*/
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                /*考试结束时间到*/
                [self showAlertViewWithMessage:@"考试结束，提交试卷"];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                /*设置界面的按钮显示 根据自己需求设置*/
                if (_tiemDate <= [[NSDate date] timeIntervalSince1970]) {
                    /*考试结束时间到*/
                    [self showAlertViewWithMessage:@"考试结束，提交试卷"];
                }
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
