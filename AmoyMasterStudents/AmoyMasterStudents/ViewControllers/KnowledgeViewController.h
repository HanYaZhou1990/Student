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
#import "SubjectViewController.h"
#import "SubjectCell.h"
#import "KnowledgeDetailViewController.h"
#import "MJRefresh.h"
#import "KnowledgePointCell.h"

/*
 public static String ZHISHI_KEMU1 = "C1S1";// 科目1
	public static String ZHISHI_KEMU2 = "C1S2";// 科目2
	public static String ZHISHI_KEMU3 = "C1S3";// 科目3
	public static String ZHISHI_KEMU4 = "C1S4";// 科目4
	public static String ZHISHI_JIAZHAO = "C2S1";// 驾照知识
	public static String ZHISHI_JIASHI = "C3S1";// 驾驶知识
 */

@interface KnowledgeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,KnowledgeCellDelegate,YZKnowledgeHeaderViewDelegate>

@property (nonatomic, strong) UITableView       *knowledgeTableView;

@end
