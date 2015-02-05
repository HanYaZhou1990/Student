//
//  EMBAMineMenuView.h
//  Sunflower
//
//  Created by Han_YaZhou on 14/12/16.
//  Copyright (c) 2014年 韩亚周. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Color.h"

@class YYButton;

@protocol EMBAMineMenuViewDelegate  <NSObject>

@required
- (void)view:(UIView *)view didSelectIndex:(NSInteger)indexOfButton;

@end

@interface EMBAMineMenuView : UIView
/*!
 按钮的图片，和title
 */
@property (nonatomic, strong) NSArray                            *btnInformationAry;
/*!
 代理
 */
@property (nonatomic, assign) id <EMBAMineMenuViewDelegate>      delegate;
@end



@interface YYButton  : UIButton

/*!
 图片
*/
@property (nonatomic, strong,readonly) UIImageView *iconImageView;
/*!
 图片
 */
@property (nonatomic, strong) UIImage     *iconImage;
/*!
 标题
 */
@property (nonatomic, strong,readonly) UILabel     *titleLab;
/*!
 标题
 */
@property (nonatomic, strong) NSString     *titleString;

@end
