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

@interface CoachViewController ()<WWMenuViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    
    NSInteger _pageNumber;
    
    NSString *totalNumber;
    
    NSMutableArray *dataSource;
    
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
    self.title = @"教练广场";
    
    [self setTopBtnView];
    [self setTheTableView];
    
    dataSource = [[NSMutableArray alloc]init];
    
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
        }
            break;
        case 1:
        {
            //最便宜
        }
            break;
        case 2:
        {
            //评价最好
        }
            break;
        case 3:
        {
            //学员最多
        }
            break;
        case 4:
        {
            //驾照类型
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark 获取表格数据

- (void)coachListHeaderRefreshing
{
    [self getTableDataByType:@"" andPageIndex:1 andIsSearch:NO];
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
    [self getTableDataByType:@"" andPageIndex:_pageNumber andIsSearch:NO];
}

//获取教练列表接口
-(void)getTableDataByType:(NSString *)typeStr andPageIndex:(NSInteger)pageIndex andIsSearch:(BOOL)isSearch
{
    [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"加载中..." animated:YES];
    
    NSString *useUrl = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL,trainee_master_list];
    
    NSString *pageIndexStr = [NSString stringWithFormat:@"%ld",(long)pageIndex];
    
    NSDictionary *params = @{@"cur_page":pageIndexStr,@"page_size":@"10",@"license":@"3",@"comment":@"1"};
    
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
                      }
                      else
                      {
                          NSString *msgStr = [responseDic valueForKey:@"msg"];
                          [SVProgressHUD showErrorWithStatus:[PublicConfig isSpaceString:msgStr andReplace:@"获取教练列表失败"]];
                      }
                      if (isSearch)
                      {
                          //[_searchTableView reloadData];
                      }
                      else
                      {
                          [myTableView reloadData];
                          [myTableView footerEndRefreshing];
                          [myTableView headerEndRefreshing];
                      }
                  }
                       failure:^(AFHTTPRequestOperation *operation, NSError *error)
                  {
                      [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                      [SVProgressHUD showErrorWithStatus:@"获取教练列表请求失败"];
                      
                      if (isSearch)
                      {
                          //[_searchTableView reloadData];
                      }
                      else
                      {
                          [myTableView reloadData];
                          [myTableView footerEndRefreshing];
                          [myTableView headerEndRefreshing];
                      }
                      
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
        NSString *feesStr =[NSString stringWithFormat:@"%@元 / %@节",coachListModel.price,coachListModel.course_count]; ;
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
    CoachDetailViewController *vc = [[CoachDetailViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 93;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
