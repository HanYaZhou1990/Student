//
//  CurriculumView.m
//  AmoyMasterStudents
//
//  Created by hanyazhou on 15/4/1.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "CurriculumView.h"

@interface CurriculumView () {
    UILabel               *_titleLab;
}

@end

@implementation CurriculumView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = UIColorFromRGB(0x01bc8e).CGColor;
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.bounds = CGRectMake(0, 0, 80, 22);
        _titleLab.text = @"教练评分:";
        _titleLab.center = CGPointMake(50, frame.size.height/2);
        [self addSubview:_titleLab];
        
        
        _starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(100, 8, CGRectGetMaxX(frame)-CGRectGetMaxX(_titleLab.frame)-20, 28) numberOfStars:5];
        _starRateView.centerY = _titleLab.centerY;
        // 默认为0分
        _starRateView.scorePercent = 0;
        _starRateView.allowIncompleteStar = NO;
        _starRateView.hasAnimation = NO;
        _starRateView.isTap = YES;
        [self addSubview:_starRateView];
    }
    return self;
}

@end
