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

@interface CoachViewController ()<WWMenuViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
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
-(void)getTableDataByType:(NSString *)typeStr
{
    
}

#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    CoachCell *cell = (CoachCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[CoachCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    NSString *heasImageStr = @"http://img4.duitang.com/uploads/item/201404/15/20140415233353_WwtCY.thumb.700_0.jpeg";
    NSString *userNameStr = @"韩亚周";
    NSString *drivingSchoolStr = @"友谊驾校 C照";
    NSString *scoreStr = @"4.8分";
    NSString *feesStr = @"3000元 / 12节";
    NSString *goNumberStr = @"128人上过";
    NSString *studyNumberStr = @"1280人正在学习";
    [cell setHeadImageStr:heasImageStr andNameStr:userNameStr andDrivingSchoolStr:drivingSchoolStr andScoreStr:scoreStr andFeesStr:feesStr andGoNumberStr:goNumberStr andStudyNumberStr:studyNumberStr];
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
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 93;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
