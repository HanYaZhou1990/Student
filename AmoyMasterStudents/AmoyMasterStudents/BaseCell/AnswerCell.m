//
//  AnswerCell.m
//  AmoyMasterStudents
//
//  Created by hanyazhou on 15/3/11.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "AnswerCell.h"

@interface AnswerCell () {
    UIImageView     *_pointImageView;
    UILabel         *_contentlable;
}

@end

@implementation AnswerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
        {
        _pointImageView = [[UIImageView alloc] init];
        _pointImageView.image = [UIImage imageNamed:@"radio_default_checked.png"];
        _pointImageView.frame = CGRectMake(30, 10, 24, 24);
        [self.contentView addSubview:_pointImageView];
        
        _contentlable = [[UILabel alloc] init];
        _contentlable.font = [UIFont systemFontOfSize:16.0];
        _contentlable.textColor = UIColorFromRGB(0x666666);
        _contentlable.numberOfLines = 0;
        [self.contentView addSubview:_contentlable];
        
        }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.selected) {
        _pointImageView.image = [UIImage imageNamed:@"radio_default_checked.png"];
    }else{
        _pointImageView.image = [UIImage imageNamed:@"radio_default.png"];
    }
    
    _contentlable.frame = CGRectMake(CGRectGetMaxX(_pointImageView.frame)+10, 0, SCREEN_WIDTH - (CGRectGetMaxX(_pointImageView.frame)+10) -10 , 44);
    _contentlable.text = @"A.你选错了";
}

- (void)awakeFromNib {}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
