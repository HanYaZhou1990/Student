//
//  SubjectCell.m
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/3/17.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "SubjectCell.h"

@implementation SubjectCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self)
        {
        self.detailTextLabel.numberOfLines = 0;
        }
    return self;
}

- (void)awakeFromNib {}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
