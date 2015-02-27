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
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1.0;
        
        for (int i=0; i<4; i++)
            {
            int x=(i%2+10)*2 +i%2*((SCREEN_WIDTH - 45)/2);
            int y=(i/2+10)*2 +i/2*180;
            
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame=CGRectMake(x, y, ((SCREEN_WIDTH - 45)/2), 180);
            btn.backgroundColor = [UIColor whiteColor];
            
            [btn setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
            
            
            [self.contentView addSubview:btn];
            }
        }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)awakeFromNib {}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
