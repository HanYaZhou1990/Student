//
//  ExaminationCell.m
//  AmoyMasterStudents
//
//  Created by hanyazhou on 15/3/11.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "ExaminationCell.h"

@interface ExaminationCell () {
    UILabel      *_numberLable;
    UILabel      *_questionLable;
    UIImageView  *_questionImageView;
}

@end

@implementation ExaminationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
        {
        
        _numberLable = [[UILabel alloc] init];
        _numberLable.font = [UIFont systemFontOfSize:16.0];
        _numberLable.textColor = UIColorFromRGB(0x666666);
        _numberLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_numberLable];
        
        _questionLable = [[UILabel alloc] init];
        _questionLable.font = [UIFont systemFontOfSize:16.0];
        _questionLable.textColor = UIColorFromRGB(0x666666);
        _questionLable.numberOfLines = 0;
        [self.contentView addSubview:_questionLable];
        
        
        _questionImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_questionImageView];
        }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _numberLable.frame = CGRectMake(10, 10, 40, 20);
    _numberLable.text = @"1 .";
    
    CGFloat leftWidth = CGRectGetMaxX(_numberLable.frame);
    
    CGFloat questionHeight = [PublicConfig height:_questionString widthOfFatherView:SCREEN_WIDTH-(leftWidth + 20) textFont:[UIFont systemFontOfSize:16.0]];
    _questionLable.frame = CGRectMake(leftWidth, 10, SCREEN_WIDTH-(leftWidth + 20), questionHeight);
    _questionLable.text = _questionString;
    
    if (_imageString) {
        _questionImageView.frame = CGRectMake(leftWidth, CGRectGetMaxY(_questionLable.frame), SCREEN_WIDTH-(leftWidth + 20), 180);
        _questionImageView.image = [UIImage imageNamed:_imageString];
    }else{
        
    }
    
}
- (void)awakeFromNib {}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
