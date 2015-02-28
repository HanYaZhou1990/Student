//
//  KnowledgeCell.m
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/2/27.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "KnowledgeCell.h"

@implementation KnowledgeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
        {
        self.backgroundColor = UIColorFromRGB(0xEEEEEE);
        
        NSArray *itemCellArray = @[@{@"title":@"科目一",@"icon":@"icon_traffic.png",@"content":@"交规 知识及技巧",@"button":@YES},
                          @{@"title":@"科目二",@"icon":@"icon_roadblock.png",@"content":@"桩考/小路 知识及技巧",@"button":@NO},
                          @{@"title":@"科目三",@"icon":@"icon_road.png",@"content":@"大路 知识及技巧",@"button":@NO},
                          @{@"title":@"科目四",@"icon":@"icon_police.png.png",@"content":@"安全文明知识及技巧",@"button":@YES}];
        
        for (int i=0; i<4; i++)
            {
            int x=i%2*((SCREEN_WIDTH - 45)/2) +i%2*15+15;
            int y=i/2*((SCREEN_WIDTH - 45)/2)*1.3 +i/2*15+15;
            
            KnoledgeCollectionViewCell *btn=[KnoledgeCollectionViewCell buttonWithType:UIButtonTypeRoundedRect];
            btn.frame=CGRectMake(x, y, ((SCREEN_WIDTH - 45)/2), ((SCREEN_WIDTH - 45)/2)*1.3);
            btn.backgroundColor = [UIColor whiteColor];
            btn.informationDic = itemCellArray[i];
            btn.delegate = self;
            btn.tag = i;
            [btn addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.layer.cornerRadius = 5.0;
            btn.clipsToBounds = YES;
            
            [self.contentView addSubview:btn];
            }
        }
    return self;
}

- (void)awakeFromNib {}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)itemClick:(KnoledgeCollectionViewCell *)sender{
    if ([_cellDelegate respondsToSelector:@selector(clickFromCell:clickItem:)]) {
        [_cellDelegate clickFromCell:self clickItem:sender];
    }
}

#pragma mark -
#pragma mark KnowledgeItemDelegate -
- (void)button:(UIButton *)button buttonClicked:(UIButton *)testButton{
    if ([_cellDelegate respondsToSelector:@selector(clickFromCell:button:buttonClicked:)]) {
        [_cellDelegate clickFromCell:self button:button buttonClicked:testButton];
    }
}
@end
