//
//  CoachCell.m
//  AmoyMasterStudents
//
//  Created by julong on 15/2/6.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "CoachCell.h"
#import "UIImageView+WebCache.h"


@interface CoachCell()
{
    UIImageView     *headImageView;
    UILabel         *userNameLabel;
    UILabel         *drivingSchoolLabel;
    UILabel         *scoreLabel;
    
    UILabel         *feesLabel;
    UILabel         *goNumberLabel;
    UILabel         *studyNumberLabel;
}
@end

@implementation CoachCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = [UIColor clearColor];
        bgView.frame = CGRectMake(10, 8, SCREEN_WIDTH-20, 85);
        [self.contentView addSubview:bgView];
        
        UIImageView *bgImageView =  [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 85)];
        bgImageView.image = [UIImage imageNamed:@"square_item_bg.png"];
        [bgView addSubview:bgImageView];
        
        
        headImageView =  [[UIImageView alloc] initWithFrame:CGRectMake(5, 15, 60, 60)];
        headImageView.layer.masksToBounds=YES;
        headImageView.layer.cornerRadius=30;
        headImageView.contentMode = UIViewContentModeScaleAspectFill;
        [bgView addSubview:headImageView];
        
        userNameLabel = [[UILabel alloc]init];
        userNameLabel.frame = CGRectMake(75, 14, 60, 15);
        userNameLabel.textAlignment = NSTextAlignmentLeft;
        userNameLabel.textColor = [UIColor blackColor];
        userNameLabel.font = [UIFont systemFontOfSize:13];
        userNameLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:userNameLabel];
        
        drivingSchoolLabel = [[UILabel alloc]init];
        drivingSchoolLabel.frame = CGRectMake(140, 14, SCREEN_WIDTH-220, 15);
        drivingSchoolLabel.textAlignment = NSTextAlignmentLeft;
        drivingSchoolLabel.textColor = [UIColor grayColor];
        drivingSchoolLabel.font = [UIFont systemFontOfSize:12];
        drivingSchoolLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:drivingSchoolLabel];
        
        scoreLabel = [[UILabel alloc]init];
        scoreLabel.frame = CGRectMake(SCREEN_WIDTH-20-62, 5, 60, 15);
        scoreLabel.textAlignment = NSTextAlignmentRight;
        scoreLabel.textColor = [UIColor whiteColor];
        scoreLabel.font = [UIFont systemFontOfSize:13];
        scoreLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:scoreLabel];
        
        feesLabel = [[UILabel alloc]init];
        feesLabel.frame = CGRectMake(75, 37, SCREEN_WIDTH-20-75, 20);
        feesLabel.textAlignment = NSTextAlignmentLeft;
        feesLabel.textColor = RGBA(0, 165, 109, 1);
        feesLabel.font = [UIFont systemFontOfSize:16];
        feesLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:feesLabel];
        
        goNumberLabel = [[UILabel alloc]init];
        goNumberLabel.frame = CGRectMake(75, 60, 115, 15);
        goNumberLabel.textAlignment = NSTextAlignmentLeft;
        goNumberLabel.textColor = [UIColor grayColor];
        goNumberLabel.font = [UIFont systemFontOfSize:10];
        goNumberLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:goNumberLabel];
        
        studyNumberLabel = [[UILabel alloc]init];
        studyNumberLabel.frame = CGRectMake(SCREEN_WIDTH-30-(SCREEN_WIDTH-190), 60, SCREEN_WIDTH-190, 15);
        studyNumberLabel.textAlignment = NSTextAlignmentRight;
        studyNumberLabel.textColor = [UIColor grayColor];
        studyNumberLabel.font = [UIFont systemFontOfSize:10];
        studyNumberLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:studyNumberLabel];
        
    }
    return self;
}

- (void)setHeadImageStr:(NSString *)imageStr andNameStr:(NSString *)nameStr andDrivingSchoolStr:(NSString *)drivingSchoolStr andScoreStr:(NSString *)scoreStr andFeesStr:(NSString *)feesStr andGoNumberStr:(NSString *)goNumStr  andStudyNumberStr:(NSString *)studyNumStr
{
    if (imageStr==nil||[imageStr isEqualToString:@""])
    {
        headImageView.image = [UIImage imageNamed:@"memberBg.png"];
    }
    else
    {
        NSString *__imageUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)imageStr, nil, nil, kCFStringEncodingUTF8));
        UIImage *image = [UIImage imageNamed:@"memberBg.png"];
        [headImageView sd_setImageWithURL:[NSURL URLWithString:__imageUrl] placeholderImage:image completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL)
         {
         }];
    }   
    userNameLabel.text = nameStr;
    drivingSchoolLabel.text = drivingSchoolStr;
    scoreLabel.text = scoreStr;
    feesLabel.text = feesStr;
    goNumberLabel.text = goNumStr;
    studyNumberLabel.text = studyNumStr;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
