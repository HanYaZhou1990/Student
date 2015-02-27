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
    return SCREEN_WIDTH*1.2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KnowledgeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}
#pragma mark -
#pragma mark UITableViewDelegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
- (void)viewDidLoad {
    self.title = @"学车知识";
    [super viewDidLoad];
    
    itemCellArray = @[@{@"title":@"科目一",@"icon":@"icon_traffic.png",@"content":@"交规 知识及技巧",@"button":@YES},
                      @{@"title":@"科目二",@"icon":@"icon_roadblock.png",@"content":@"桩考/小路 知识及技巧",@"button":@NO},
                      @{@"title":@"科目三",@"icon":@"icon_road.png",@"content":@"大路 知识及技巧",@"button":@NO},
                      @{@"title":@"科目四",@"icon":@"icon_police.png.png",@"content":@"安全文明知识及技巧",@"button":@YES}];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    flowLayout.itemSize=CGSizeMake((SCREEN_WIDTH-45)/2,180);
    flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 84);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = UIColorFromRGB(0xEEEEEE);
    [_collectionView registerClass:[KnoledgeCollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
    [_collectionView registerClass:[YZCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    self.view = _collectionView;
}

#pragma mark - UICollectionViewDataSource

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    YZCollectionReusableView *view;
    if([kind isEqual:UICollectionElementKindSectionHeader])
        {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        view.delegate = self;
        }
    return view;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return itemCellArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KnoledgeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    cell.informationDic = itemCellArray[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - YZCollectionReusableViewDelagete
- (void)collectionView:(YZCollectionReusableView *)collectionView view:(UIView *)view buttonSeleectIndex:(NSInteger)indexOfButton {
    DLog(@"%ld",(long)indexOfButton);
}
 */
@end
