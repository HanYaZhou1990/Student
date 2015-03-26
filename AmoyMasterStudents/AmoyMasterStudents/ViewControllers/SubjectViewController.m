//
//  SubjectViewController.m
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/3/17.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "SubjectViewController.h"

@interface SubjectViewController () <UITableViewDataSource,UITableViewDelegate> {
    NSMutableArray      *_dataSourceArray;
    UITableView         *_subjectTableView;
    NSInteger          _pageNumber;
}

@end

@implementation SubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _titleString;
    
    _pageNumber = 0;
    
    [self leftBarItem];
    
    _dataSourceArray  = [NSMutableArray array];
    
    _subjectTableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT) style:UITableViewStylePlain];
    _subjectTableView.dataSource = self;
    _subjectTableView.delegate = self;
    [_subjectTableView registerClass:[SubjectCell class] forCellReuseIdentifier:@"cell"];
    _subjectTableView.tableFooterView = [UIView new];
    [self.view addSubview:_subjectTableView];
    
    [_subjectTableView addHeaderWithTarget:self action:@selector(subjectHeaderRefreshing) dateKey:@"allDiscoverTable"];
    [_subjectTableView addFooterWithTarget:self action:@selector(subjectFooterRefreshing)];
    _subjectTableView.headerPullToRefreshText = @"下拉可以刷新";
    _subjectTableView.headerReleaseToRefreshText = @"松开马上刷新";
    _subjectTableView.headerRefreshingText = @"正在帮您刷新中";
    
    _subjectTableView.footerPullToRefreshText = @"上拉可以加载更多数据";
    _subjectTableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    _subjectTableView.footerRefreshingText = @"正在帮您加载中";
    
    [self subjectType:_titleString andFormartType:@"0"];
}

- (void)subjectType:(NSString *)subject andFormartType:(NSString *)formartType{
    if ([subject isEqualToString:@"科目一"]) {
        [self refreshDataWithSection:@"C1S1" andFormartType:formartType];
    }else if ([subject isEqualToString:@"科目二"]) {
        [self refreshDataWithSection:@"C1S2" andFormartType:formartType];
    }else if ([subject isEqualToString:@"科目三"]) {
        [self refreshDataWithSection:@"C1S3" andFormartType:formartType];
    }else {
        [self refreshDataWithSection:@"C1S4" andFormartType:formartType];
    }
}

#pragma mark 获取表格数据

- (void)subjectHeaderRefreshing
{
    _pageNumber = 0;
    [self subjectType:_titleString andFormartType:@"0"];
}

- (void)subjectFooterRefreshing
{
    _pageNumber ++;
    [self subjectType:_titleString andFormartType:@"1"];
}

- (void)refreshDataWithSection:(NSString *)sectionString andFormartType:(NSString *)formartType{
    [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"加载中..." animated:YES];
    
    NSString *useUrl = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL,trainee_knowledge_paginationListItems];
    
    NSDictionary *params = @{@"section":sectionString,@"page":[NSString stringWithFormat:@"%ld",(long)_pageNumber],@"amount":@"2",@"token":userToken};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:useUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [_subjectTableView footerEndRefreshing];
        [_subjectTableView headerEndRefreshing];
        
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSString *resultCode = [responseDic valueForKey:@"code"]; //0成功 1失败
        if ([resultCode boolValue]==NO){
            NSDictionary *dataDic = [responseDic valueForKey:@"data"];
            if (dataDic){
                if ([formartType isEqualToString:@"0"]) {
                    [_dataSourceArray removeAllObjects];
                }
                [_dataSourceArray addObjectsFromArray:dataDic[@"list"]];
                [_subjectTableView reloadData];
            }
        }else{
            NSString *msgStr = [responseDic valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:[PublicConfig isSpaceString:msgStr andReplace:@"获取文章列表失败"]];
            [_dataSourceArray removeAllObjects];
            [_subjectTableView reloadData];
            _pageNumber = 0;
        }
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error){
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [_subjectTableView footerEndRefreshing];
            [_subjectTableView headerEndRefreshing];
            [SVProgressHUD showErrorWithStatus:@"获取文章列表请求失败"];
            [_dataSourceArray removeAllObjects];
            [_subjectTableView reloadData];
    }];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SubjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _dataSourceArray[indexPath.row][@"title"];
    cell.detailTextLabel.text = _dataSourceArray[indexPath.row][@"description"];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate-

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KnowledgeDetailViewController *detailViewController = [[KnowledgeDetailViewController alloc] init];
    detailViewController.titleString = _dataSourceArray[indexPath.row][@"title"];
    detailViewController.detailUrlString = _dataSourceArray[indexPath.row][@"detailUrl"];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
