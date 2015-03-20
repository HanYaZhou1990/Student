//
//  TimeLineViewController.m
//  AmoyMasterStudents
//
//  Created by julong on 15/2/9.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "TimeLineViewController.h"
#import "TimeLineCell.h"
#import "TimeLineModel.h"

@interface TimeLineViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataSource;
    UITableView *myTableView;
}


@end

@implementation TimeLineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"时间线";
    
    [self leftBarItem];
    
    [self setTheTableView];
    
    dataSource = [[NSMutableArray alloc]init];
    
    [self refreshMemberData];

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
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

//设置tableview属性
- (void)setTheTableView
{
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT) style:UITableViewStylePlain];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.showsVerticalScrollIndicator = NO;//隐藏垂直滚动条
    myTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:myTableView];
}

#pragma mark -
#pragma mark - 数据相关
-(void)refreshMemberData
{
    //刷新数据
    [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"加载中..." animated:YES];
    
    NSString *useUrl = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL,trainee_timeLine_list];
    NSDictionary *params = @{@"token":userToken};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:useUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSString *resultCode = [responseDic valueForKey:@"code"]; //0成功 1失败
        if ([resultCode boolValue] == NO) {
            NSDictionary *dataDic = [responseDic valueForKey:@"data"];
            if ([dataDic[@"list"] isKindOfClass:[NSArray class]]) {
                [dataSource removeAllObjects];
                NSArray *listArray = dataDic[@"list"];
                for (int i = 0; i < listArray.count ; i ++) {
                    TimeLineModel *timeLine1 = [[TimeLineModel alloc]initWithDictionary:listArray[i]];
                    [dataSource addObject:timeLine1];
                }
                [myTableView reloadData];
            }else {
                [myTableView reloadData];
            }
        }else {
            NSString *msgStr = [responseDic valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:[PublicConfig isSpaceString:msgStr andReplace:@"没有时间线"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [SVProgressHUD showErrorWithStatus:@"获取时间线请求失败"];
        [dataSource removeAllObjects];
        [myTableView reloadData];
    }];
}


#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    TimeLineCell *cell = (TimeLineCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[TimeLineCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    TimeLineModel *timeLine = [dataSource objectAtIndex:indexPath.row];
    [cell setTimeLineTypeStr:timeLine.type andTitleStr:timeLine.titleContent andDetailStr:timeLine.detailContent andDateStr:timeLine.dateContent];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.backgroundView = nil;
    
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimeLineModel *timeLine = [dataSource objectAtIndex:indexPath.row];
    NSString *detailStr = timeLine.detailContent;
    CGFloat heightUse = 0.0f;
    if (detailStr.length>0)
    {
        CGFloat widthUse = SCREEN_WIDTH-65;
        heightUse = [PublicConfig height:detailStr widthOfFatherView:widthUse  textFont:[UIFont systemFontOfSize:13]];
        if (heightUse<=15)
        {
            heightUse=15;
        }
        return heightUse+75;
    }
    return 75;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
