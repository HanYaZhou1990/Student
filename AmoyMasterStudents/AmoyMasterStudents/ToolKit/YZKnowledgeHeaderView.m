//
//  YZKnowledgeHeaderView.m
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/2/27.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "YZKnowledgeHeaderView.h"

@interface YZKnowledgeHeaderView (){
    EMBAMineMenuView *menuView;
}

@end

@implementation YZKnowledgeHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
        {
        menuView = [[EMBAMineMenuView alloc] init];
        menuView.delegate = self;
        menuView.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        menuView.btnInformationAry = @[
                                       @[@"必备知识",[UIImage imageNamed:@"icon_book.png"],[UIImage imageNamed:@"icon_book_active.png"]],
                                       @[@"驾照知识",[UIImage imageNamed:@"icon_drive.png"],[UIImage imageNamed:@"icon_drive_active.png"]],
                                       @[@"驾驶知识",[UIImage imageNamed:@"icon_license.png"],[UIImage imageNamed:@"icon_license_active.png"]],
                                       @[[NSString stringWithFormat:@"%d",0],[UIImage initWithColor:UIColorFromRGB(0xFFFFFF)]]];
        [self addSubview:menuView];
        }
    return self;
}

- (void)view:(UIView *)view didSelectIndex:(NSInteger)indexOfButton{
    if ([_delegate respondsToSelector:@selector(headerView:view:buttonSeleectIndex:)]) {
        [_delegate headerView:self view:view buttonSeleectIndex:indexOfButton];
    }
}
@end
