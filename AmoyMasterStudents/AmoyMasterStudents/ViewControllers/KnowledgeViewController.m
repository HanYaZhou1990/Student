//
//  KnowledgeViewController.m
//  Student
//
//  Created by Han_YaZhou on 15/2/2.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import "KnowledgeViewController.h"
#import "NoticeViewController.h"
@interface KnowledgeViewController (){
    NSInteger          _selectedIndex;
    NSMutableArray     *_dataSourceArray;
    NSInteger          _pageNumber;
    NSString           *_sectionString;
}

@end

@implementation KnowledgeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
        {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"学车知识" image:[UIImage imageNamed:@"icon_main_knowledge.png"] selectedImage:[UIImage imageNamed:@"icon_main_knowledge.png"]];
        }
    return self;
}
- (void)viewDidLoad {
    self.title = @"学车知识";
    [super viewDidLoad];
    
    _selectedIndex = 0;
    _pageNumber = 1;
    _sectionString = @"";
    
    _dataSourceArray = [NSMutableArray array];
    
    [self setRightNavigationBar];
    
    YZKnowledgeHeaderView *headerView = [[YZKnowledgeHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 84)];
    headerView.delegate = self;
    [self.view addSubview:headerView];
    
    _knowledgeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 85, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-TAB_HEIGHT-85) style:UITableViewStylePlain];
    _knowledgeTableView.dataSource = self;
    _knowledgeTableView.delegate = self;
    [_knowledgeTableView registerClass:[KnowledgeCell class] forCellReuseIdentifier:@"cell"];
    [_knowledgeTableView registerClass:[SubjectCell class] forCellReuseIdentifier:@"SubjectCell"];
    _knowledgeTableView.tableFooterView = [UIView new];
    _knowledgeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _knowledgeTableView.backgroundColor = UIColorFromRGB(0xEEEEEE);
    [self.view addSubview: _knowledgeTableView];
    
    [_knowledgeTableView addHeaderWithTarget:self action:@selector(knowledgeHeaderRefreshing) dateKey:@"allDiscoverTable"];
    [_knowledgeTableView addFooterWithTarget:self action:@selector(knowledgeFooterRefreshing)];
    _knowledgeTableView.headerPullToRefreshText = @"下拉可以刷新";
    _knowledgeTableView.headerReleaseToRefreshText = @"松开马上刷新";
    _knowledgeTableView.headerRefreshingText = @"正在帮您刷新中";
    
    _knowledgeTableView.footerPullToRefreshText = @"上拉可以加载更多数据";
    _knowledgeTableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    _knowledgeTableView.footerRefreshingText = @"正在帮您加载中";
}

//设置右边的添加按键
- (void)setRightNavigationBar
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(10, 7, 80, 30);
    [rightBtn setTitle:@"通知" forState:UIControlStateNormal];
    [rightBtn setTitleColor:RGBA(0, 165, 109, 1) forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)btnClick
{
    NoticeViewController *vc = [[NoticeViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.noticeType = @"4";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 获取表格数据

- (void)knowledgeHeaderRefreshing{
    if (_selectedIndex == 0) {
        [_knowledgeTableView footerEndRefreshing];
        [_knowledgeTableView headerEndRefreshing];
        return;
    }else {
        _pageNumber = 1;
        [self refreshDate:_sectionString andFormartType:@"0"];
    }
}

- (void)knowledgeFooterRefreshing{
    if (_selectedIndex == 0) {
        [_knowledgeTableView footerEndRefreshing];
        [_knowledgeTableView headerEndRefreshing];
        return;
    }else{
        _pageNumber ++;
        [self refreshDate:_sectionString andFormartType:@"1"];
    }
}

- (void)refreshDate:(NSString *)sectionString andFormartType:(NSString *)formartType{
    [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"加载中..." animated:YES];
    
    NSString *useUrl = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL,trainee_knowledge_paginationListItems];
    
    NSDictionary *params = @{@"section":sectionString,@"page":[NSString stringWithFormat:@"%ld",(long)_pageNumber],@"amount":@"10",@"token":userToken};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:useUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [_knowledgeTableView footerEndRefreshing];
        [_knowledgeTableView headerEndRefreshing];
        
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSString *resultCode = [responseDic valueForKey:@"code"]; //0成功 1失败
        if ([resultCode boolValue]==NO){
            id something = [responseDic valueForKey:@"data"];
            if ([something isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dataDic = [responseDic valueForKey:@"data"];
                if (dataDic)
                    {
                    if (![formartType isEqualToString:@"1"])
                        {
                        [_dataSourceArray removeAllObjects];
                    }
                    for (NSString *keyString in [dataDic allKeys])
                        {
                        [_dataSourceArray addObject:dataDic[keyString]];
                        [_knowledgeTableView reloadData];
                        }
                }
            }else {
                [SVProgressHUD showErrorWithStatus:@"没有新文章"];
                [_dataSourceArray removeAllObjects];
                [_knowledgeTableView reloadData];
                _pageNumber = 1;
            }
        }else{
            NSString *msgStr = [responseDic valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:[PublicConfig isSpaceString:msgStr andReplace:@"获取文章列表失败"]];
            [_dataSourceArray removeAllObjects];
            [_knowledgeTableView reloadData];
            _pageNumber = 1;
            
        }
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error){
              [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
              [_knowledgeTableView footerEndRefreshing];
              [_knowledgeTableView headerEndRefreshing];
              [SVProgressHUD showErrorWithStatus:@"获取文章列表请求失败"];
              [_dataSourceArray removeAllObjects];
              [_knowledgeTableView reloadData];
          }];
}

#pragma mark -
#pragma mark UITableViewDataSource -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectedIndex == 0) {
        return ((SCREEN_WIDTH - 45)/2)*1.3*2+45;
    }else {
        return 64;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_selectedIndex == 0) {
        return 1;
    }else {
        return _dataSourceArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectedIndex == 0) {
        KnowledgeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.cellDelegate = self;
        return cell;
    }else {
        SubjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubjectCell" forIndexPath:indexPath];
        cell.textLabel.text = _dataSourceArray[indexPath.row][@"title"];
        cell.detailTextLabel.text = _dataSourceArray[indexPath.row][@"description"];
        return cell;
    }
}
#pragma mark -
#pragma mark UITableViewDelegate-

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_selectedIndex == 0) {return;}
    KnowledgeDetailViewController *detailViewController = [[KnowledgeDetailViewController alloc] init];
    detailViewController.titleString = _dataSourceArray[indexPath.row][@"title"];
    detailViewController.codeString = _dataSourceArray[indexPath.row][@"code"];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark -
#pragma mark KnowledgeCellDelegate -
- (void)clickFromCell:(KnowledgeCell *)cell button:(UIButton *)button buttonClicked:(UIButton *)testButton{
    ExamViewController *viewController = [[ExamViewController alloc] init];
    switch (button.tag) {
        case 0:
        {
        viewController.examType = ExamViewControllerTypeOne;
        }
            break;
        case 3:
        {
        viewController.examType = ExamViewControllerTypeThree;
        }
            break;
            
        default:
            break;
    }
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)clickFromCell:(KnowledgeCell *)cell clickItem:(KnoledgeCollectionViewCell *)button{
    SubjectViewController *subjectVC = [[SubjectViewController alloc] init];
    switch (button.tag) {
        case 0:
        {
        subjectVC.titleString = @"科目一";
        }
            break;
        case 1:
        {
        subjectVC.titleString = @"科目二";
        }
            break;
        case 2:
        {
        subjectVC.titleString = @"科目三";
        }
            break;
        case 3:
        {
        subjectVC.titleString = @"科目四";
        }
            break;
            
        default:
            break;
    }
    subjectVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:subjectVC animated:YES];
}

#pragma mark -
#pragma mark YZKnowledgeHeaderViewDelegate -
- (void)headerView:(YZKnowledgeHeaderView *)headerView view:(UIView *)view buttonSeleectIndex:(NSInteger)indexOfButton{
    _selectedIndex = indexOfButton;
    if (indexOfButton == 0) {
        _knowledgeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_knowledgeTableView reloadData];
    }else if (indexOfButton == 1) {
        _knowledgeTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _sectionString = @"C2S1";
        [self refreshDate:_sectionString andFormartType:@"0"];
    }else {
        _knowledgeTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _sectionString = @"C3S1";
        [self refreshDate:_sectionString andFormartType:@"0"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
