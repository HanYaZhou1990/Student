//
//  AnswerViewController.m
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/2/28.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "AnswerViewController.h"

@interface AnswerViewController () {
    UIView           *_cellSelectedView;
    NSMutableArray   *_answerArray;/*保存答案*/
    NSString         *_examTokenString;/*这套题的examToken*/
    NSString   *aS;
}
@end

@implementation AnswerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"模拟考试";
    
    _questionsArray = [NSArray array];
    _answerArray = [NSMutableArray array];
    _currentInteger = 0;
    _examTokenString = @"";
    aS  = @"";
    
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
    
    [self getAllQuesstionWithSubjectType:NO];
    
}
- (void)next:(UIButton *)sender {
    _currentInteger ++;
    if (_currentInteger == _questionsArray.count) {
        [[[UIAlertView alloc] initWithTitle:@"" message:@"考试完毕，提交试卷" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }else {
        [_questionTableView reloadData];
        [UIView transitionWithView:_questionTableView duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            sender.userInteractionEnabled = NO;
        } completion:^(BOOL finished) {
            sender.userInteractionEnabled = YES;
        }];
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
        
        DLog(@"**********%@",[PublicConfig dictionaryToJson:responseDic]);
        
        NSString *resultCode = [responseDic valueForKey:@"code"]; //0成功 1失败
        if ([resultCode boolValue]==NO){
            NSDictionary *dataDic = [responseDic valueForKey:@"data"];
            if (dataDic){
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
    return [NSString stringWithFormat:@"第 %lu 题/共100题",(unsigned long)_currentInteger+1];
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
        return 44;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ExaminationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.questionString = _questionsArray[_currentInteger][@"content"];
        if ([_questionsArray[_currentInteger][@"images"] count] == 0) {
            
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
    [_answerArray addObject:@{@"code":_questionsArray[_currentInteger][@"code"],@"value":_questionsArray[_currentInteger][@"options"][indexPath.row-1][@"optChar"]}];
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 
#pragma mark UIAlertViewDelegate -
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
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
        
        DLog(@"**********%@",[PublicConfig dictionaryToJson:responseDic]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [SVProgressHUD showErrorWithStatus:@"提交答案请求失败"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
