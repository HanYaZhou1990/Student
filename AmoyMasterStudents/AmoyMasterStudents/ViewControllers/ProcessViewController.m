//
//  ProcessViewController.m
//  Student
//
//  Created by Han_YaZhou on 15/2/2.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import "ProcessViewController.h"
#import "TimeLineCell.h"
#import "TimeLineModel.h"

@interface ProcessViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataSource;
    UITableView *myTableView;
}
@end

@implementation ProcessViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"学车进程" image:[UIImage imageNamed:@"icon_main_process.png"] selectedImage:[UIImage imageNamed:@"icon_main_process.png"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"学车进程";
    
    [self setTheTableView];
    
    dataSource = [[NSMutableArray alloc]init];
    
    [self getData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshProcessData) name:refreshProcessVCNotification object:nil];
}

//设置tableview属性
- (void)setTheTableView
{
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-TAB_HEIGHT) style:UITableViewStylePlain];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.showsVerticalScrollIndicator = NO;//隐藏垂直滚动条
    myTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:myTableView];
}



#pragma mark -
#pragma mark - 数据相关
-(void)refreshProcessData
{
    //刷新数据
    
}

-(void)getData
{
    TimeLineModel *timeLine1 = [[TimeLineModel alloc]init];
    timeLine1.type = @"1";
    timeLine1.titleContent = @"您获得驾照,学习结束您获得驾照";
    timeLine1.detailContent = @"";
    timeLine1.dateContent = @"2014/5/12 17:10";
    [dataSource addObject:timeLine1];
    
    TimeLineModel *timeLine2 = [[TimeLineModel alloc]init];
    timeLine2.type = @"2";
    timeLine2.titleContent = @"您完成了第一节课您获得驾照,学习结束您获得驾照,学习结束";
    timeLine2.detailContent = @"对教练为评价5分,打赏10元您获得驾照,学习结束您获得驾照,学习结束您获得驾照,学习结束您获得驾照,学习结束您获得驾照,学习结束您获得驾照,学习结束";
    timeLine2.dateContent = @"2014/5/12 17:10";
    [dataSource addObject:timeLine2];
    
    TimeLineModel *timeLine3 = [[TimeLineModel alloc]init];
    timeLine3.type = @"3";
    timeLine3.titleContent = @"您进入长训,协助教练韩教练";
    timeLine3.detailContent = @"";
    timeLine3.dateContent = @"2014/5/12 17:10";
    [dataSource addObject:timeLine3];
    
    [dataSource addObject:timeLine1];
    [dataSource addObject:timeLine2];
    [dataSource addObject:timeLine3];
    
    [dataSource addObject:timeLine1];
    [dataSource addObject:timeLine2];
    [dataSource addObject:timeLine3];
    
    [myTableView reloadData];
}


#pragma mark -
#pragma mark - 数据相关
-(void)refreshMemberData
{
    //刷新数据
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
}
@end
