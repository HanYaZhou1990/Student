//
//  Custombutton.m
//  AmoyMasterStudents
//
//  Created by hanyazhou on 15/4/1.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "Custombutton.h"

@interface Custombutton () {
    UIImageView    *_headerImageView;
}

@end

@implementation Custombutton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /*radio_default_checked.png    radio_default.png*/
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.image = [UIImage imageNamed:@"radio_default.png"];
        [self addSubview:_headerImageView];
        
        _myLable = [[UILabel alloc] init];
        _myLable.font = [UIFont systemFontOfSize:12.0];
        _myLable.userInteractionEnabled = NO;
        _myLable.adjustsFontSizeToFitWidth = YES;
        _myLable.textColor = UIColorFromRGB(0x01be8e);
        [self addSubview:_myLable];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _headerImageView.bounds = CGRectMake(0, 0, 16, 16);
    _headerImageView.center = CGPointMake(14, self.frame.size.height/2);
    
    _myLable.bounds = CGRectMake(0, 0, self.frame.size.width-28, 22);
    _myLable.center = CGPointMake((self.frame.size.width -28)/2+28, self.frame.size.height/2);
    if (self.selected) {
        _headerImageView.image = [UIImage imageNamed:@"radio_default_checked.png"];
    }else {
        _headerImageView.image = [UIImage imageNamed:@"radio_default.png"];
    }
}

@end
