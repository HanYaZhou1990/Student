//
//  KnoledgeCollectionViewCell.h
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/2/8.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KnowledgeItemDelegate <NSObject>

- (void)button:(UIButton *)button buttonClicked:(UIButton *)testButton;

@end

@interface KnoledgeCollectionViewCell : UIButton

/*!每个cell上边的内容*/
@property (nonatomic, strong) NSDictionary       *informationDic;

/*!设置代理*/

@property (nonatomic, assign) id <KnowledgeItemDelegate> delegate;

@end
