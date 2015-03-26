//
//  SizeToLabelCell.m
//  OChat
//
//  Created by julong on 15/1/8.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "SizeToLabelCell.h"

@interface SizeToLabelCell()
{
    UILabel         *titleLabel;
}
@end

@implementation SizeToLabelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.numberOfLines = 0;
        [self.contentView addSubview:titleLabel];
        
    }
    return self;
}
//设置label值和frame
- (void)setTitleLabelStr:(NSString *)str andUseSign:(NSString *)useSign
{
    CGFloat widthUse = SCREEN_WIDTH-40;
    if (IOS7)
    {
        widthUse = SCREEN_WIDTH-20;
    }
    CGFloat heightUse = [PublicConfig height:str widthOfFatherView:widthUse  textFont:[UIFont systemFontOfSize:16]];
    if (heightUse<=20)
    {
        heightUse=20;
    }
    titleLabel.frame = CGRectMake(10, 12, widthUse, heightUse);
    if ([useSign isEqualToString:@"1"])
    {
        titleLabel.textColor = UIColorFromRGB(0x00a56d);
    }
    else
    {
        titleLabel.textColor = [UIColor blackColor];
    }
    
    titleLabel.text = str;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
