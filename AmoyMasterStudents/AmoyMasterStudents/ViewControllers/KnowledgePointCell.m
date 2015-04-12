//
//  KnowledgePointCell.m
//  AmoyMasterStudents
//
//  Created by Apple on 15/4/8.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "KnowledgePointCell.h"

@implementation KnowledgePointCell

+ (instancetype)cellWithTableView:(UITableView *)tabelView reuseIdentifier:(NSString *)identifier{
    
    KnowledgePointCell *cell = [tabelView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KnowledgePointCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIImageView *pointImageView = [[UIImageView alloc] init];
        [pointImageView setImage:[UIImage imageNamed:@"icon_point"]];
        [pointImageView sizeToFit];
        [self addSubview:pointImageView];
        self.pointImageView = pointImageView;
        
        UILabel *knowledgeTextLabel = [[UILabel alloc] init];
        knowledgeTextLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:knowledgeTextLabel];
        self.knowledgeTextLabel = knowledgeTextLabel;

        UILabel *knowledgeDetailTextLabel = [[UILabel alloc]init];
        knowledgeDetailTextLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:knowledgeDetailTextLabel];
        self.knowledgeDetailTextLabel = knowledgeDetailTextLabel;
        
    }
    return self;
}

- (void)layoutSubviews{
    CGFloat padding = 10;
    
    self.pointImageView.x = padding;
    self.pointImageView.y = 20;
    
    self.knowledgeTextLabel.x = CGRectGetMaxX(self.pointImageView.frame) + 5;
    self.knowledgeTextLabel.centerY = self.pointImageView.centerY;
    self.knowledgeTextLabel.width = SCREEN_WIDTH - self.knowledgeTextLabel.x;
    self.knowledgeTextLabel.height = self.height * 0.7;
    
    self.knowledgeDetailTextLabel.x = self.knowledgeTextLabel.x;
    self.knowledgeDetailTextLabel.y = CGRectGetMaxY(self.knowledgeTextLabel.frame) + 2;
    self.knowledgeDetailTextLabel.width = self.knowledgeTextLabel.width;
    self.knowledgeDetailTextLabel.height = self.height * 0.3 - 2;
    
}


@end
