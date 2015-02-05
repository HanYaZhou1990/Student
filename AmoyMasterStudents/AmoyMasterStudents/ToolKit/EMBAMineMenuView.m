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
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.frame.size.width/(btnInformationAry.count - 1)*i, 0, self.frame.size.width/(btnInformationAry.count - 1), self.frame.size.height);
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitle:btnInformationAry[i][0] forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [button setImage:btnInformationAry[i][1] forState:UIControlStateNormal];
        [button setBackgroundImage:[btnInformationAry lastObject][1] forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage initWithColor:[UIColor orangeColor]] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setMultipleTouchEnabled:YES];
        button.imageEdgeInsets = UIEdgeInsetsMake(10.f, (CGRectGetWidth(button.frame)-40.f)/2.f, 34.f, (CGRectGetWidth(button.frame)-40.f)/2.f);
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        CGSize titleSize = [btnInformationAry[i][0] sizeWithFont:button.titleLabel.font];
        button.titleEdgeInsets = UIEdgeInsetsMake(52.f, -titleSize.width+10.f, 2.f, (CGRectGetWidth(button.frame)-titleSize.width)/2.f-10.f);
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
