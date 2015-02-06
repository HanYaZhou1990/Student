//
//  WWMenuView.h
//  AmoyMasterStudents
//
//  Created by julong on 15/2/5.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WWMenuViewDelegate  <NSObject>

@required
- (void)view:(UIView *)view didSelectIndex:(NSInteger)indexOfButton;

@end

@interface WWMenuView : UIView
/*!
 按钮的图片，和title
 */
@property (nonatomic, strong) NSArray                            *btnInformationAry;

@property (nonatomic, assign) CGFloat                            imageWidth;

/*!
 代理
 */
@property (nonatomic, assign) id <WWMenuViewDelegate>      delegate;
@end
