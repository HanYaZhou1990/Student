//
//  EMBAMineMenuView.m
//  Sunflower
//
//  Created by Han_YaZhou on 14/12/16.
//  Copyright (c) 2014年 韩亚周. All rights reserved.
//

#import "EMBAMineMenuView.h"

@implementation EMBAMineMenuView{
    NSMutableArray       *btnArray;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setBtnInformationAry:(NSMutableArray *)btnInformationAry{
    if (!btnArray) {
        btnArray = [@[]mutableCopy];
    }
    for (int i = 0; i < btnInformationAry.count - 1; i ++) {
        YYButton *button = [YYButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.frame.size.width/(btnInformationAry.count - 1)*i, 0, self.frame.size.width/(btnInformationAry.count - 1), self.frame.size.height);
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setIconImage:btnInformationAry[i][1]];
        [button setTitleString:btnInformationAry[i][0]];
        [button setBackgroundImage:[btnInformationAry lastObject][1] forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage initWithColor:[UIColor orangeColor]] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setMultipleTouchEnabled:YES];
        /*初始化的时候，设置的默认选中按钮,这个地方不需要，舍弃此方法*/
        if (i == [[btnInformationAry lastObject][0] intValue]) {button.selected = YES;}
        button.tag = i +10;
        [btnArray addObject:button];
        [self addSubview:button];
    }
}

-(void)itemClick:(UIButton *)sender{
    if (sender.selected) {
        return;
    }else{
        for (int i = 0; i < btnArray.count; i ++) {
            UIButton *btn = (UIButton *)btnArray[i];
            if (sender.tag == btn.tag) {
                [btn setSelected:YES];
                if ([_delegate respondsToSelector:@selector(view:didSelectIndex:)]) {
                    [_delegate view:self didSelectIndex:sender.tag-10];
                }
            }else{
                [btn setSelected:NO];
            }
        }
    }
}

@end

@implementation YYButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_iconImageView];
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = [UIColor blackColor];
        [self addSubview:_titleLab];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _iconImageView.frame = CGRectMake((CGRectGetWidth(self.frame)-40)/2, 10, 40, 40);
    _iconImageView.image = _iconImage;
    _titleLab.frame = CGRectMake(10, 52, CGRectGetWidth(self.frame) - 20, 20);
    _titleLab.text = _titleString;
    if (self.selected == YES) {
        _titleLab.textColor = [UIColor orangeColor];
    }else{
        _titleLab.textColor = [UIColor blackColor];
    }
}

@end

