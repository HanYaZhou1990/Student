//
//  KnoledgeCollectionViewCell.m
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/2/8.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "KnoledgeCollectionViewCell.h"

@interface KnoledgeCollectionViewCell (){
    UILabel            *titleLab;
    UIImageView        *iconImageView;
    UILabel            *contentLab;
    /*modelTest_btn_test*/
    UIImageView        *testImageView;
}

@end

@implementation KnoledgeCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
        {
        titleLab = [[UILabel alloc] init];
        titleLab.backgroundColor = UIColorFromRGB(0x01BC8F);
        titleLab.textColor = [UIColor whiteColor];
        titleLab.font = [UIFont systemFontOfSize:16.0];
        titleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLab];
        
        
        iconImageView = [[UIImageView alloc] init];
        [self addSubview:iconImageView];
        
        
        contentLab = [[UILabel alloc] init];
        contentLab.backgroundColor = [UIColor whiteColor];
        contentLab.textColor = [UIColor blackColor];
        contentLab.textAlignment = NSTextAlignmentCenter;
        contentLab.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:contentLab];
        
        
        testImageView = [[UIImageView alloc] init];
        [self addSubview:testImageView];
        }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    titleLab.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 24);
    titleLab.text = _informationDic[@"title"];
    
    UIImage *image = [UIImage imageNamed:_informationDic[@"icon"]];
    iconImageView.image = image;
    iconImageView.bounds = CGRectMake(0, 0, image.size.width/2, image.size.height/2);
    iconImageView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetMaxY(titleLab.frame)+40);
    
    contentLab.frame = CGRectMake(10, 100, CGRectGetWidth(self.frame)-20, 38);
    contentLab.numberOfLines = 2;
    contentLab.text = _informationDic[@"content"];
    
    if ([_informationDic[@"button"] intValue] == YES) {
        UIImage *modelImage = [UIImage imageNamed:@"modelTest_btn_test.png"];
        testImageView.image = modelImage;
        testImageView.bounds = CGRectMake(0, 0, modelImage.size.width/2,modelImage.size.height/2);
        testImageView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)- modelImage.size.height/2);
    }
}

@end
