//
//  SizeToLeftLabelCell.m
//  OChat
//
//  Created by julong on 15/1/14.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "SizeToLeftLabelCell.h"

@interface SizeToLeftLabelCell()
{
    UILabel         *leftLabel;
    UILabel         *rightLabel;
}
@end

@implementation SizeToLeftLabelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        leftLabel = [[UILabel alloc] init];
        leftLabel.frame = CGRectMake(0, 12, 75, 20);
        leftLabel.textAlignment = NSTextAlignmentRight;
        leftLabel.textColor = [UIColor blackColor];
        leftLabel.lineBreakMode = NSLineBreakByCharWrapping;
        leftLabel.backgroundColor = [UIColor clearColor];
        leftLabel.font = [UIFont systemFontOfSize:16];
        leftLabel.numberOfLines = 0;
        [self.contentView addSubview:leftLabel];
        
        rightLabel = [[UILabel alloc] init];
        rightLabel.textAlignment = NSTextAlignmentLeft;
        rightLabel.textColor = [UIColor blackColor];
        rightLabel.lineBreakMode = NSLineBreakByCharWrapping;
        rightLabel.backgroundColor = [UIColor clearColor];
        rightLabel.font = [UIFont systemFontOfSize:16];
        rightLabel.numberOfLines = 0;
        [self.contentView addSubview:rightLabel];
        
    }
    return self;
}

- (void)setTitleLeftLabelStr:(NSString *)leftStr andRightLabelStr:(NSString *)rightStr andReplaceStr:(NSString *)replaceStr andUseSign:(NSString *)useSign
{
    CGFloat widthUse = SCREEN_WIDTH-40-90;
    if (IOS7)
    {
        widthUse = SCREEN_WIDTH-20-90;
    }
    CGFloat heightUse = [PublicConfig height:rightStr widthOfFatherView:widthUse  textFont:[UIFont systemFontOfSize:16]];
    if (heightUse<=20)
    {
        heightUse=20;
    }
    rightLabel.frame = CGRectMake(85, 12, widthUse, heightUse);
    if (rightStr.length==0)
    {
        rightLabel.textColor = RGBA(208, 208, 208, 1);
        rightLabel.text = replaceStr;
    }
    else
    {
        rightLabel.textColor = [UIColor blackColor];
        rightLabel.text = rightStr;
    }
    
    leftLabel.text = leftStr;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
