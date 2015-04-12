//
//  KnowledgePointCell.h
//  AmoyMasterStudents
//
//  Created by Apple on 15/4/8.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KnowledgePointCell : UITableViewCell
@property (nonatomic, strong) UIImageView *pointImageView; // 点
@property (nonatomic, strong) UILabel *knowledgeTextLabel; // 标题
@property (nonatomic, strong) UILabel *knowledgeDetailTextLabel; //子标题

+ (instancetype)cellWithTableView:(UITableView *)tabelView reuseIdentifier:(NSString *)identifier;

@end
