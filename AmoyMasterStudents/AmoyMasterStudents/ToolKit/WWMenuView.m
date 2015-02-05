//
//  WWMenuView.m
//  AmoyMasterStudents
//
//  Created by julong on 15/2/5.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "WWMenuView.h"

@interface WWMenuView()
{
    NSMutableArray       *btnArray;
}
@end


@implementation WWMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}

- (void)setBtnInformationAry:(NSMutableArray *)btnInformationAry
{
    if (!btnArray)
    {
        btnArray = [@[]mutableCopy];
    }
    for (int i = 0; i < btnInformationAry.count; i ++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.frame.size.width/btnInformationAry.count*i, 0, self.frame.size.width/btnInformationAry.count, self.frame.size.height);
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitle:btnInformationAry[i][0] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        [button setImage:btnInformationAry[i][1] forState:UIControlStateNormal];
        [button setImage:btnInformationAry[i][2] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setMultipleTouchEnabled:YES];
        
        CGFloat btnWidth  =CGRectGetWidth(button.frame);
        CGFloat btnHeight =CGRectGetHeight(button.frame);
        button.imageEdgeInsets = UIEdgeInsetsMake((btnHeight-_imageWidth-20)/2, (btnWidth-_imageWidth)/2, btnHeight-(_imageWidth+(btnHeight-_imageWidth-20)/2), (btnWidth-_imageWidth)/2);
        
//        NSString *contentString = btnInformationAry[i][0];
//        CGFloat useWidth = [PublicConfig width:contentString heightOfFatherView:20 textFont:[UIFont systemFontOfSize:13]];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleEdgeInsets = UIEdgeInsetsMake(btnHeight-20, -_imageWidth, 2, 0);
        /*初始化的时候，设置的默认选中按钮,这个地方不需要，舍弃此方法*/
        if (i == [[btnInformationAry lastObject][0] intValue])
        {
            button.selected = YES;
        }
        button.tag = i +10;
        [btnArray addObject:button];
        [self addSubview:button];
    }
}

-(void)itemClick:(UIButton *)sender
{
    if (sender.selected)
    {
        return;
    }
    else
    {
        for (int i = 0; i < btnArray.count; i ++)
        {
            UIButton *btn = (UIButton *)btnArray[i];
            if (sender.tag == btn.tag)
            {
                [btn setSelected:YES];
                if ([_delegate respondsToSelector:@selector(view:didSelectIndex:)])
                {
                    [_delegate view:self didSelectIndex:sender.tag-10];
                }
            }
            else
            {
                [btn setSelected:NO];
            }
        }
    }
}
@end
