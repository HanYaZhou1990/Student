//
//  CustomSegument.m
//  AmoyMasterStudents
//
//  Created by hanyazhou on 15/4/1.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "CustomSegument.h"

@interface CustomSegument () {
    NSMutableArray       *btnArray;
}

@end

@implementation CustomSegument

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        btnArray = [NSMutableArray array];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (int i = 0; i < _titleArray.count; i ++)
        {
        Custombutton *button = [Custombutton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.frame.size.width/_titleArray.count*i, 0, self.frame.size.width/_titleArray.count, self.frame.size.height);
        button.myLable.text = _titleArray[i];
        [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setMultipleTouchEnabled:YES];
        button.tag = i+10;
        [btnArray addObject:button];
        [self addSubview:button];
        }
}

-(void)itemClick:(Custombutton *)sender
{
    for (int i = 0; i < btnArray.count; i ++)
        {
        Custombutton *btn = (Custombutton *)btnArray[i];
        if (sender.tag == btn.tag)
            {
            [btn setSelected:YES];
            if ([_delegate respondsToSelector:@selector(fromView:didSelectIndex:)])
                {
                [_delegate fromView:self didSelectIndex:sender.tag-10];
                }
            }
        else
            {
            [btn setSelected:NO];
            }
        }
}

@end
