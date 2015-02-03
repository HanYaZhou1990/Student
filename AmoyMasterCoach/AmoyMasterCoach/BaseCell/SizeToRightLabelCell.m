//
//  SizeToRightLabelCell.m
//  OChat
//
//  Created by julong on 15/1/13.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "SizeToRightLabelCell.h"

@interface SizeToRightLabelCell()
{
    UILabel         *leftLabel;
    UILabel         *rightLabel;
}
@end

@implementation SizeToRightLabelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        leftLabel = [[UILabel alloc] init];
        leftLabel.textAlignment = NSTextAlignmentLeft;
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
        rightLabel.font = [UIFont systemFontOfSize:14];
        rightLabel.numberOfLines = 0;
        [self.contentView addSubview:rightLabel];
        
    }
    return self;
}


- (void)setTitleLeftLabelStr:(NSString *)leftStr andRightLabelStr:(NSString *)rightStr andUseSign:(NSString *)useSign
{
    leftLabel.frame = CGRectMake(15, 12, 80, 20);
    
    CGFloat widthUse = SCREEN_WIDTH-40-105;
    if (IOS7)
    {
        widthUse = SCREEN_WIDTH-20-105;
    }
    CGFloat heightUse = [PublicConfig height:rightStr widthOfFatherView:widthUse  textFont:[UIFont systemFontOfSize:14]];
    if (heightUse<=20)
    {
        heightUse=20;
    }
    if (heightUse>20)
    {
        rightLabel.textAlignment = NSTextAlignmentLeft;
    }
    else
    {
        rightLabel.textAlignment = NSTextAlignmentRight;
    }
    
    rightLabel.frame = CGRectMake(95, 12, widthUse, heightUse);
    if ([useSign isEqualToString:@"1"])
    {
        rightLabel.textColor = [UIColor grayColor];
    }
    
    leftLabel.text = leftStr;
    rightLabel.text = rightStr;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
