//
//  YZKnowledgeHeaderView.h
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/2/27.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Color.h"
#import "EMBAMineMenuView.h"

@class YZKnowledgeHeaderView;

@protocol YZKnowledgeHeaderViewDelegate <NSObject>

- (void)headerView:(YZKnowledgeHeaderView *)headerView view:(UIView *)view buttonSeleectIndex:(NSInteger)indexOfButton;

@end

@interface YZKnowledgeHeaderView : UIView <EMBAMineMenuViewDelegate>

@property (nonatomic, assign)id <YZKnowledgeHeaderViewDelegate> delegate;

@end
