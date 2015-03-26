//
//  TimeLineCell.m
//  AmoyMasterStudents
//
//  Created by julong on 15/2/9.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "TimeLineCell.h"

@interface TimeLineCell()
{
    UILabel         *leftLabel;
    UIImageView     *leftImageView;
    UILabel         *titleLabel;
    UILabel         *detailLabel;
    UILabel         *dateLabel;
    UILabel         *lineLabel;
}
@end


@implementation TimeLineCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        leftLabel = [[UILabel alloc] init];
        leftLabel.backgroundColor = RGBA(235, 235, 235, 1);
        [self.contentView addSubview:leftLabel];
        
        leftImageView =  [[UIImageView alloc] init];
        leftImageView.frame = CGRectMake(20, 20, 25, 25);
        [self.contentView addSubview:leftImageView];
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.frame = CGRectMake(65, 10, SCREEN_WIDTH-75, 35);
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.numberOfLines = 2;
        titleLabel.font = [UIFont boldSystemFontOfSize:14];
        titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:titleLabel];
        
        detailLabel = [[UILabel alloc]init];
        detailLabel.frame = CGRectMake(65, titleLabel.frame.size.height+titleLabel.frame.origin.y+10, SCREEN_WIDTH-75, 15);
        detailLabel.textAlignment = NSTextAlignmentLeft;
        detailLabel.textColor = RGBA(0, 165, 109, 1);
        detailLabel.font = [UIFont systemFontOfSize:13];
        detailLabel.numberOfLines = 0;
        detailLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:detailLabel];
        
        dateLabel = [[UILabel alloc]init];
        dateLabel.frame = CGRectMake(65, detailLabel.frame.size.height+detailLabel.frame.origin.y+10, SCREEN_WIDTH-75, 20);
        dateLabel.textAlignment = NSTextAlignmentLeft;
        dateLabel.textColor = [UIColor lightGrayColor];
        dateLabel.font = [UIFont systemFontOfSize:12];
        dateLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:dateLabel];
        
        lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = RGBA(235, 235, 235, 1);
        [self.contentView addSubview:lineLabel];
        
    }
    return self;
}

- (void)setTimeLineTypeStr:(NSString *)typeStr andTitleStr:(NSString *)titleStr andDetailStr:(NSString *)detailStr  andDateStr:(NSString *)dateStr
{
    if ([typeStr isEqualToString:@"1"])
    {
        leftImageView.image = [UIImage imageNamed:@"icon_flag.png"];
    }
    else if ([typeStr isEqualToString:@"2"])
        {
            leftImageView.image = [UIImage imageNamed:@"icon_star.png"];
        }
    else if ([typeStr isEqualToString:@"3"])
    {
        leftImageView.image = [UIImage imageNamed:@"icon_trip.png"];
    }
    
    titleLabel.text = titleStr;
    if (detailStr.length>0)
    {
        detailLabel.hidden = NO;
        CGFloat widthUse = SCREEN_WIDTH-65;
        CGFloat heightUse = [PublicConfig height:detailStr widthOfFatherView:widthUse  textFont:[UIFont systemFontOfSize:13]];
        if (heightUse<=15)
        {
            heightUse=15;
        }
        detailLabel.frame = CGRectMake(65, 50, widthUse, heightUse);
        detailLabel.text = detailStr;
        
        dateLabel.frame = CGRectMake(65, detailLabel.frame.size.height+detailLabel.frame.origin.y, SCREEN_WIDTH-75, 15);
    }
    else
    {
        detailLabel.frame = CGRectMake(65, 0, SCREEN_WIDTH-75, 0);
        detailLabel.hidden = YES;
        dateLabel.frame = CGRectMake(65, 50, SCREEN_WIDTH-75, 15);
    }
    
    dateLabel.text = dateStr;

    leftLabel.frame = CGRectMake(32, 0, 1, dateLabel.frame.size.height+dateLabel.frame.origin.y+10);
    lineLabel.frame = CGRectMake(0, dateLabel.frame.size.height+dateLabel.frame.origin.y+10-0.5, SCREEN_WIDTH, 0.5);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
