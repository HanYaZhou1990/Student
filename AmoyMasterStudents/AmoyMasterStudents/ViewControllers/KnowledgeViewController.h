//
//  KnowledgeViewController.h
//  Student
//
//  Created by Han_YaZhou on 15/2/2.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import "BaseViewController.h"
#import "YZCollectionReusableView.h"
#import "KnoledgeCollectionViewCell.h"
#import "YZKnowledgeHeaderView.h"
#import "KnowledgeCell.h"
#import "ExamViewController.h"

@interface KnowledgeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,KnowledgeCellDelegate>

@property (nonatomic, strong) UITableView       *knowledgeTableView;

@end
