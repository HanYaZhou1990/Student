//
//  CoachViewController.m
//  Student
//
//  Created by Han_YaZhou on 15/2/2.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import "CoachViewController.h"
#import "WWMenuView.h"
#import "CoachCell.h"
#import "CoachDetailViewController.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "CoachListModel.h"

@interface CoachViewController ()<WWMenuViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *myTableView;
    
    NSInteger _pageNumber;
    NSInteger _currentPageNumber;
    
    NSString *totalNumber;
    
    NSMutableArray *dataSource;
    
    NSString *requestType;//请求类型标示
    NSString *currentRequestType;//当前请求字符串
    
    UITextField *searchTextField;
    NSString *searchStr;//上次参数字符串
    NSString *currentSearchStr;//搜索字符串
    
}
@end

@implementation CoachViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
        {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"教练广场" image:[UIImage imageNamed:@"icon_main_square.png"] selectedImage:[UIImage imageNamed:@"icon_main_square.png"]];
        }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self leftBarItem];
    
    searchStr=@"-1";
    
    [self setTopBtnView];
    [self setTheTableView];
    
    dataSource = [[NSMutableArray alloc]init];
    
    requestType = @"1";//附近
    
    [self coachListHeaderRefreshing];
}

- (void)leftBarItem
{
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
    searchView.backgroundColor = [UIColor clearColor];
    
    searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 7, searchView.frame.size.width-30, 30)];
    searchTextField.font = [UIFont systemFontOfSize:14];
    searchTextField.textColor = [UIColor blackColor];
    searchTextField.delegate =self;
    searchTextField.returnKeyType = UIReturnKeySearch;
    searchTextField.keyboardType = UIKeyboardTypeDefault;
    searchTextField.placeholder = @"寻找师傅";
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, searchTextField.frame.size.height)];
    leftView.backgroundColor = [UIColor clearColor];
    searchTextField.leftView =  leftView;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 28, 30)];
    rightView.backgroundColor = [UIColor clearColor];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"icon_search.png"] forState:UIControlStateNormal];
    rightButton.frame = CGRectMake(0, 6, 18, 17.5);    [rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:rightButton];
    searchTextField.rightView =  rightView;
    searchTextField.rightViewMode = UITextFieldViewModeAlways;
    
    searchTextField.backgroundColor = [UIColor whiteColor];
    searchTextField.tintColor = [UIColor blueColor];
    searchTextField.layer.masksToBounds=YES;
    searchTextField.layer.cornerRadius=2;
    searchTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    searchTextField.layer.borderWidth=0.5;
    searchTextField.clearButtonMode = UITextFieldViewModeNever;
    [searchView addSubview:searchTextField];
    
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:searchView];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

-(void)rightButtonAction
{
    [searchTextField resignFirstResponder];
    
    NSString *seacrhUseStr = [searchTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    currentSearchStr = seacrhUseStr;
    
    [self coachListHeaderRefreshing];
}

-(void)setTopBtnView
{
    WWMenuView *menuView = [[WWMenuView alloc]init];
    menuView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    menuView.delegate = self;
    menuView.imageWidth = 30.0f;
    menuView.btnInformationAry = @[
                                   @[@"附近",[UIImage imageNamed:@"icon_location.png"],[UIImage imageNamed:@"icon_location_active.png"]],
                                   @[@"最便宜",[UIImage imageNamed:@"icon_cheap.png"],[UIImage imageNamed:@"icon_cheap_active.png"]],
                                   @[@"评价最好",[UIImage imageNamed:@"icon_evaluation.png"],[UIImage imageNamed:@"icon_evaluation_active.png"]],
                                   @[@"学员最多",[UIImage imageNamed:@"icon_trainee.png"],[UIImage imageNamed:@"icon_trainee_active.png"]],
                                   @[@"驾照类型",[UIImage imageNamed:@"icon_knowledge.png"],[UIImage imageNamed:@"icon_knowledge_active.png"]]];
    [self.view addSubview:menuView];
    
}

- (void)setTheTableView
{
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-TAB_HEIGHT-60) style:UITableViewStylePlain];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.showsVerticalScrollIndicator = NO;//隐藏垂直滚动条
    myTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:myTableView];
    
    [myTableView addHeaderWithTarget:self action:@selector(coachListHeaderRefreshing) dateKey:@"allDiscoverTable"];
    [myTableView addFooterWithTarget:self action:@selector(coachListFooterRefreshing)];
    myTableView.headerPullToRefreshText = @"下拉可以刷新";
    myTableView.headerReleaseToRefreshText = @"松开马上刷新";
    myTableView.headerRefreshingText = @"正在帮您刷新中";
    
    myTableView.footerPullToRefreshText = @"上拉可以加载更多数据";
    myTableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    myTableView.footerRefreshingText = @"正在帮您加载中";
    
}

#pragma mark WWMenuViewDelegate

- (void)view:(UIView *)view didSelectIndex:(NSInteger)indexOfButton
{
    switch (indexOfButton)
    {
        case 0:
        {
            //附近
            requestType = @"1";
        }
            break;
        case 1:
        {
            //最便宜
            if ([requestType isEqualToString:@"2"])
            {
                requestType = @"3";
            }
            else if ([requestType isEqualToString:@"3"])
            {
                requestType = @"2";
            }
            else
            {
                requestType = @"2";
            }
        }
            break;
        case 2:
        {
            //评价最好
            if ([requestType isEqualToString:@"4"])
            {
                requestType = @"5";
            }
            else if ([requestType isEqualToString:@"5"])
            {
                requestType = @"4";
            }
            else
            {
                requestType = @"4";
            }
        }
            break;
        case 3:
        {
            //学员最多
            if ([requestType isEqualToString:@"6"])
            {
                requestType = @"7";
            }
            else if ([requestType isEqualToString:@"7"])
            {
                requestType = @"6";
            }
            else
            {
                requestType = @"6";
            }
        }
            break;
        case 4:
        {
            //驾照类型
            if ([requestType isEqualToString:@"8"])
            {
                requestType = @"9";
            }
            else if ([requestType isEqualToString:@"9"])
            {
                requestType = @"8";
            }
            else
            {
                requestType = @"8";
            }
        }
            break;
            
        default:
            break;
    }
    
    //请求数据
    [self coachListHeaderRefreshing];
}

#pragma mark 获取表格数据

- (void)coachListHeaderRefreshing
{
    [self getTableDataByType:requestType andPageIndex:1 andIsSearch:NO];
}

- (void)coachListFooterRefreshing
{
    if (dataSource.count < [totalNumber integerValue])
    {
        _pageNumber ++;
    }
    else
    {
        _pageNumber = 1;
    }
    [self getTableDataByType:requestType andPageIndex:_pageNumber andIsSearch:NO];
}

//获取教练列表接口
-(void)getTableDataByType:(NSString *)typeStr andPageIndex:(NSInteger)pageIndex andIsSearch:(BOOL)isSearch
{
    if ([currentSearchStr isEqualToString:searchStr]&&[currentRequestType isEqualToString:requestType]&&(_currentPageNumber==_pageNumber))
    {
        [myTableView footerEndRefreshing];
        [myTableView headerEndRefreshing];
        return;
    }
    
    [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"加载中..." animated:YES];
    
    NSString *useUrl;
    if (currentSearchStr.length>0)
    {
        //搜索字符串不为空 搜索
         useUrl= [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL,trainee_master_search];
    }
    else
    {
        //为空 普通列表
         useUrl= [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL,trainee_master_list];
    }
    
    NSString *pageIndexStr = [NSString stringWithFormat:@"%ld",(long)pageIndex];
    NSString *pageSizeStr = @"10";
    
    NSDictionary *params; //去掉组合排列
    if ([requestType isEqualToString:@"1"])
    {
        //点击附近 离我最近 评分最高
         params= @{@"cur_page":pageIndexStr,@"page_size":pageSizeStr,@"position":@"1"};
    }
    else if ([requestType isEqualToString:@"2"])
    {
        //点击最便宜 价格最便宜 评分最高
        params= @{@"cur_page":pageIndexStr,@"page_size":pageSizeStr,@"price":@"1"};
    }
    else if ([requestType isEqualToString:@"3"])
    {
        //点击最便宜 价格贵 评分最高
        params= @{@"cur_page":pageIndexStr,@"page_size":pageSizeStr,@"price":@"-1"};
    }
    else if ([requestType isEqualToString:@"4"])
    {
        //点击最评价最好  评分最高 离我最近
        params= @{@"cur_page":pageIndexStr,@"page_size":pageSizeStr,@"comment":@"-1"};
        
    }
    else if ([requestType isEqualToString:@"5"])
    {
        //点击最评价最好  评分最低 离我最近
         params= @{@"cur_page":pageIndexStr,@"page_size":pageSizeStr,@"comment":@"1"};
    }
    else if ([requestType isEqualToString:@"6"])
    {
        //点击学员最多  正在学习人数最多 评分最高
         params= @{@"cur_page":pageIndexStr,@"page_size":pageSizeStr,@"trainee":@"-1"};
    }
    else if ([requestType isEqualToString:@"7"])
    {
        //点击学员最多  正在学习人数最少 评分最高
        params= @{@"cur_page":pageIndexStr,@"page_size":pageSizeStr,@"trainee":@"1"};
    }
    else if ([requestType isEqualToString:@"8"])
    {
        //点击驾校类型  C2照 评分最高
        params= @{@"cur_page":pageIndexStr,@"page_size":pageSizeStr,@"license":@"4"};
    }
    else if ([requestType isEqualToString:@"9"])
    {
        //点击学员最多  C1照 评分最高
        params= @{@"cur_page":pageIndexStr,@"page_size":pageSizeStr,@"license":@"3"};
    }
    
    if (currentSearchStr.length>0)
    {
        NSMutableDictionary *seacrhDic = [[NSMutableDictionary alloc]init];
        [seacrhDic addEntriesFromDictionary:params];
        [seacrhDic setValue:currentSearchStr forKey:@"query"];
        params = seacrhDic;
        searchStr = currentSearchStr;
    }
    else
    {
        searchStr = @"";
    }
    
    currentRequestType = requestType;
    _currentPageNumber = _pageNumber;
    
    DLog(@"搜索字符串的值为 %@ 类型为%@",searchStr,currentRequestType);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:useUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
                  {
                      [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                      
                      NSDictionary *responseDic = (NSDictionary *)responseObject;
                      NSString *resultCode = [responseDic valueForKey:@"code"]; //0成功 1失败
                      if ([resultCode boolValue]==NO)
                      {
                          NSDictionary *dataDic = [responseDic valueForKey:@"data"];
                           NSString *totalItme = [dataDic valueForKey:@"totalItme"];
                          totalNumber=totalItme;
                          
                          NSArray *dataArr = [dataDic valueForKey:@"list"];
                          if (pageIndex == 1)
                          {
                              [dataSource removeAllObjects];
                          }
                          for (NSInteger i = 0; i < dataArr.count; i ++)
                          {
                              NSDictionary *useDic = [dataArr objectAtIndex:i];
                              CoachListModel *coachListModel = [[CoachListModel alloc] initWithDictionary:useDic];
                              [dataSource addObject:coachListModel];
                          }
                          [myTableView reloadData];
                      }
                      else
                      {
                          NSString *msgStr = [responseDic valueForKey:@"msg"];
                          [SVProgressHUD showErrorWithStatus:[PublicConfig isSpaceString:msgStr andReplace:@"获取教练列表失败"]];
                      }
                      
                      [myTableView footerEndRefreshing];
                      [myTableView headerEndRefreshing];
                  }
                       failure:^(AFHTTPRequestOperation *operation, NSError *error)
                  {
                      [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                      [SVProgressHUD showErrorWithStatus:@"获取教练列表请求失败"];
                      
                          [myTableView reloadData];
                          [myTableView footerEndRefreshing];
                          [myTableView headerEndRefreshing];
                      
                  }];
}


#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    CoachCell *cell = (CoachCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[CoachCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    if (dataSource.count>0)
    {
        CoachListModel *coachListModel = [dataSource objectAtIndex:indexPath.row];
        
        NSString *heasImageStr = @"http://img4.duitang.com/uploads/item/201404/15/20140415233353_WwtCY.thumb.700_0.jpeg";
        NSString *userNameStr = [PublicConfig isSpaceString:coachListModel.master_name andReplace:@"匿名教练"];
        NSString *drivingSchoolStr = [NSString stringWithFormat:@"%@ %@照",coachListModel.school_name,coachListModel.license];
        NSString *scoreStr = [NSString stringWithFormat:@"%@分",coachListModel.avg_score];
        
         NSString *feesStr =[NSString stringWithFormat:@"%@元 / %@节",coachListModel.price,coachListModel.course_count];
        if ([coachListModel.course_count isEqualToString:@"0"])
        {
            feesStr =[NSString stringWithFormat:@"%@元",coachListModel.price];
        }
       
        NSString *goNumberStr = [NSString stringWithFormat:@"%@人上过",coachListModel.trainee_count];
        NSString *studyNumberStr = [NSString stringWithFormat:@"%@人正在学习",coachListModel.current_count];
        [cell setHeadImageStr:heasImageStr andNameStr:userNameStr andDrivingSchoolStr:drivingSchoolStr andScoreStr:scoreStr andFeesStr:feesStr andGoNumberStr:goNumberStr andStudyNumberStr:studyNumberStr];
    }
  
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = nil;
    
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CoachListModel *coachListModel = [dataSource objectAtIndex:indexPath.row];
    
    CoachDetailViewController *vc = [[CoachDetailViewController alloc]init];
    vc.masterId = coachListModel.master_id;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 93;
}
#pragma mark -
#pragma mark 屏幕点击事件

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [searchTextField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeySearch)
    {
        [self rightButtonAction];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    textField.text = @"";
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
