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
    
    if (_imageString && _imageString.length > 0) {
        _questionImageView.hidden = NO;
        _questionImageView.frame = CGRectMake(leftWidth, CGRectGetMaxY(_questionLable.frame), SCREEN_WIDTH-(leftWidth + 20), 180);
        NSString *__imageUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)_imageString, nil, nil, kCFStringEncodingUTF8));
        [_questionImageView sd_setImageWithURL:[NSURL URLWithString:__imageUrl] placeholderImage:[UIImage imageNamed:@"account_default_avatar.png"] completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL){}];
    }else{
        _questionImageView.frame = CGRectZero;
        _questionImageView.hidden = YES;
    }
    
}
- (void)awakeFromNib {}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
