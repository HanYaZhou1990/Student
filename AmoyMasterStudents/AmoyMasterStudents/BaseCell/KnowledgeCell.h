//
//  KnowledgeCell.h
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/2/27.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KnoledgeCollectionViewCell.h"

@class KnowledgeCell;

@protocol KnowledgeCellDelegate <NSObject>

- (void)clickFromCell:(KnowledgeCell *)cell button:(UIButton *)button buttonClicked:(UIButton *)testButton;
- (void)clickFromCell:(KnowledgeCell *)cell clickItem:(KnoledgeCollectionViewCell *)button;

@end

@interface KnowledgeCell : UITableViewCell<KnowledgeItemDelegate>

@property (nonatomic, assign) id <KnowledgeCellDelegate> cellDelegate;

@end
