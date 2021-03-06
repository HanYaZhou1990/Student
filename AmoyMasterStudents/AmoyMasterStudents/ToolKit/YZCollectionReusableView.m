//
//  YZCollectionReusableView.m
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/2/5.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "YZCollectionReusableView.h"

@interface YZCollectionReusableView (){
    EMBAMineMenuView *menuView;
}

@end

@implementation YZCollectionReusableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
        {
        menuView = [[EMBAMineMenuView alloc] init];
        menuView.delegate = self;
        [self addSubview:menuView];
        }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    menuView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    menuView.btnInformationAry = @[
                                   @[@"必备知识",[UIImage imageNamed:@"icon_book.png"]],
                                   @[@"驾照知识",[UIImage imageNamed:@"icon_drive.png"]],
                                   @[@"驾驶知识",[UIImage imageNamed:@"icon_license.png"]],
                                   @[[NSString stringWithFormat:@"%d",0],[UIImage initWithColor:UIColorFromRGB(0xFFFFFF)]]];
}

- (void)view:(UIView *)view didSelectIndex:(NSInteger)indexOfButton{
    if ([_delegate respondsToSelector:@selector(collectionView:view:buttonSeleectIndex:)]) {
        [_delegate collectionView:self view:view buttonSeleectIndex:indexOfButton];
    }
}

@end
