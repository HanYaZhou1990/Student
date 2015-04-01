//
//  CustomTextView.m
//  AmoyMasterStudents
//
//  Created by hanyazhou on 15/4/1.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "CustomTextView.h"

@interface CustomTextView () {
    UILabel               *_titleLab;
}

@end

@implementation CustomTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xF0F0F0);
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = UIColorFromRGB(0x01bc8e).CGColor;
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.bounds = CGRectMake(0, 0, 80, 22);
        _titleLab.text = @"教练评分:";
        _titleLab.userInteractionEnabled = NO;
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.center = CGPointMake(50, 11);
        [self addSubview:_titleLab];

        
        _contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(82, 0, CGRectGetWidth(frame)-82, 160)];
        _contentTextView.font = [UIFont systemFontOfSize:16.0];
        _contentTextView.backgroundColor = UIColorFromRGB(0xF0F0F0);
        _contentTextView.returnKeyType = UIReturnKeyDone;
        [self addSubview:_contentTextView];
        
    }
    return self;
}

@end
