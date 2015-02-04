//
//  MemberCenterViewController.m
//  Student
//
//  Created by Han_YaZhou on 15/2/2.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import "MemberCenterViewController.h"

@interface MemberCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    NSArray *sectionOneLArray;
    NSArray *sectionTwoLArray;
}
@end

@implementation MemberCenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
        {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人中心" image:[UIImage imageNamed:@"icon_main_person.png"] selectedImage:[UIImage imageNamed:@"icon_main_person.png"]];
        }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"个人中心";
    
    sectionOneLArray = @[@"昵称",@"当前账号",@"联系方式"];
    sectionTwoLArray = @[@"当前教练",@"我的时间线",@"当前学习进度",@"当前考试进度",@"身份证名称",@"身份证照片"];
    
    [self setTheTableView];
    
}

//设置tableview属性
- (void)setTheTableView
{
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -220, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-TAB_HEIGHT+220) style:UITableViewStyleGrouped];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.showsVerticalScrollIndicator = NO;//隐藏垂直滚动条
    [self.view addSubview:myTableView];
}

#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    else if (section==1)
    {
        return sectionOneLArray.count;
    }
    else if (section==2)
    {
        return sectionTwoLArray.count;
    }
    else if (section==3)
    {
        return 1;
    }
    else if (section==4)
    {
        return 1;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    //    if (cell==nil)
    //    {
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    //    }
    
    if (indexPath.section==0)
    {
        UIImageView *bgView = [[UIImageView alloc]init];
        bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 320);
        bgView.image = [UIImage imageNamed:@"memberBg.png"];
        [cell.contentView addSubview:bgView];
        
            //头像 头像可点击编辑  名字
            UIImageView *headImageView =  [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-60)/2, 230, 60, 60)];
            headImageView.image = [UIImage imageNamed:@"account_default_avatar.png"];
            headImageView.layer.masksToBounds=YES;
            headImageView.layer.cornerRadius=30;
            headImageView.layer.borderWidth=2.0;
            headImageView.layer.borderColor=[UIColor whiteColor].CGColor;
            headImageView.contentMode = UIViewContentModeScaleAspectFill;
            [cell.contentView addSubview:headImageView];
    }
    else
    {
        cell.textLabel.textColor = RGBA(1, 188, 142, 1);
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor whiteColor];
        
        if (indexPath.section==1)
        {
            cell.textLabel.text = [sectionOneLArray objectAtIndex:indexPath.row];
            if (indexPath.row==0)
            {
                cell.detailTextLabel.text = @"韩亚周";
            }
            else if (indexPath.row==2)
            {
                cell.detailTextLabel.text = @"hanyz";
            }
            else if (indexPath.row==3)
            {
                cell.detailTextLabel.text = @"15093387753";
            }
        }
        if (indexPath.section==2)
        {
            cell.textLabel.text = [sectionTwoLArray objectAtIndex:indexPath.row];
            if (indexPath.row==0)
            {
                cell.detailTextLabel.text = @"友谊驾校/孙璋";
            }
            else if (indexPath.row==2)
            {
                cell.detailTextLabel.text = @"1.倒库(1/20)";
            }
            else if (indexPath.row==3)
            {
                cell.detailTextLabel.text = @"笔试-通过(模拟考80分)";
            }
            else if (indexPath.row==4)
            {
                cell.detailTextLabel.text = @"韩亚周";
            }
        }
        if (indexPath.section==3)
        {
            cell.textLabel.text = @"红包金额";
            cell.detailTextLabel.text = @"50元";
        }
        if (indexPath.section==4)
        {
            cell.textLabel.text = @"退出登录";
        }
    }
   
    cell.backgroundView = nil;
    
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 320;
    }
    return 44;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
