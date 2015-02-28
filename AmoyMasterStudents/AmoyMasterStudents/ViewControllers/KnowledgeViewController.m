//
//  KnowledgeViewController.m
//  Student
//
//  Created by Han_YaZhou on 15/2/2.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import "KnowledgeViewController.h"

@interface KnowledgeViewController (){
    NSArray      *itemCellArray;
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
    
    _knowledgeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-TAB_HEIGHT) style:UITableViewStylePlain];
    _knowledgeTableView.dataSource = self;
    _knowledgeTableView.delegate = self;
    [_knowledgeTableView registerClass:[YZKnowledgeHeaderView class] forHeaderFooterViewReuseIdentifier:@"headerView"];
    [_knowledgeTableView registerClass:[KnowledgeCell class] forCellReuseIdentifier:@"cell"];
    _knowledgeTableView.tableFooterView = [UIView new];
    _knowledgeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _knowledgeTableView.backgroundColor = UIColorFromRGB(0xEEEEEE);
    self.view = _knowledgeTableView;
}

#pragma mark -
#pragma mark UITableViewDataSource -

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YZKnowledgeHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 84;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ((SCREEN_WIDTH - 45)/2)*1.2*2+45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KnowledgeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.cellDelegate = self;
    return cell;
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
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)clickFromCell:(KnowledgeCell *)cell clickItem:(KnoledgeCollectionViewCell *)button{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
