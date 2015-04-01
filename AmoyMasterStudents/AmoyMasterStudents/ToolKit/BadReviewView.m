//
//  BadReviewView.m
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/4/1.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "BadReviewView.h"

@interface BadReviewView () {
    UILabel              *_titleLable;
    NSMutableArray       *_btnArray;
}

@end

@implementation BadReviewView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _btnArray = [NSMutableArray array];
        
        self.backgroundColor = UIColorFromRGB(0xF0F0F0);
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = UIColorFromRGB(0x01bc8e).CGColor;
        
        _titleLable = [[UILabel alloc] init];
        _titleLable.textColor = [UIColor blackColor];
        _titleLable.font = [UIFont systemFontOfSize:16.0];
        _titleLable.numberOfLines = 2;
        [self addSubview:_titleLable];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLable.text = _titleString;
    _titleLable.frame = CGRectMake(10, 0, CGRectGetWidth(self.frame) - 20, 40);
    
    for (int i = 0; i < _itemArray.count; i ++)
        {
        
        int x=(i%WIDTH_COUNT) + ITEM_Width  * (i%WIDTH_COUNT);
        int y=(i/WIDTH_COUNT) + ITEM_Height * (i/WIDTH_COUNT);
        
        Custombutton *button = [Custombutton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+x, y+40, ITEM_Width, ITEM_Height);
        button.myLable.text = _itemArray[i];
        [button setNeedsLayout];
        [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setMultipleTouchEnabled:YES];
        button.tag = i+10;
        [_btnArray addObject:button];
        [self addSubview:button];
        }
}

-(void)itemClick:(Custombutton *)sender
{
    for (int i = 0; i < _btnArray.count; i ++)
        {
        Custombutton *btn = (Custombutton *)_btnArray[i];
        if (sender.tag == btn.tag)
            {
            [btn setSelected:YES];
            if ([_delegate respondsToSelector:@selector(selectFrom:selectedIndex:)])
                {
                [_delegate selectFrom:self selectedIndex:sender.tag-10];
                }
            }
        else
            {
            [btn setSelected:NO];
            }
        }
}

@end
