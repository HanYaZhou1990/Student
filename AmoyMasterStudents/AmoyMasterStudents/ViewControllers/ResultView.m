//
//  RejectView.m
//  AmoyMasterStudents
//
//  Created by Apple on 15/3/27.
//  Copyright (c) 2015年 XHH. All rights reserved.
//

#import "ResultView.h"
#import "NSString+StringHeight.h"

@interface ResultView (){

}
@end

@implementation ResultView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_course_confirm"]];
    [iconImageView sizeToFit];
    [self addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    
    
    UILabel *resultLabel = [[UILabel alloc] init];
    // 设置换行
    resultLabel.lineBreakMode = NSLineBreakByWordWrapping;
    resultLabel.numberOfLines = 0;
    resultLabel.font = [UIFont boldSystemFontOfSize:21];
    resultLabel.textColor = TSFSutentColor;
    [self addSubview:resultLabel];
    self.resultLabel = resultLabel;
    
    
    UILabel *noticeLabel = [[UILabel alloc] init];
    // 设置换行
    noticeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    noticeLabel.numberOfLines = 0;
    noticeLabel.font = [UIFont boldSystemFontOfSize:17];
    [self addSubview:noticeLabel];
    self.noticeLabel = noticeLabel;
    
}

- (void)layoutSubviews{
    self.backgroundColor = [UIColor whiteColor];
    // 设置uiview的圆角
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    

    self.iconImageView.x = (self.width - self.iconImageView.width) * 0.5;
    self.iconImageView.y = 40;

    self.resultLabel.textAlignment = NSTextAlignmentCenter;
    self.resultLabel.y = CGRectGetMaxY(_iconImageView.frame) + 40;
    self.resultLabel.width = self.width;
    self.resultLabel.height = [self.resultLabel.text heightForStringFont:self.resultLabel.font andWidth:self.resultLabel.width];
    
    
    self.noticeLabel.textAlignment = NSTextAlignmentCenter;
    self.noticeLabel.y = CGRectGetMaxY(_resultLabel.frame) + 20;
    self.noticeLabel.width = self.width;
    self.noticeLabel.height = [self.noticeLabel.text heightForStringFont:self.noticeLabel.font andWidth:self.noticeLabel.width];

    
    self.height = CGRectGetMaxY(self.noticeLabel.frame) + 60;
}

@end
