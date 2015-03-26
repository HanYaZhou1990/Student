//
//  SizeToLeftLabelCell.h
//  OChat
//
//  Created by julong on 15/1/14.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SizeToLeftLabelCell : UITableViewCell

//自适应cell 宽度屏幕宽度 userSign 特殊要求字符（如修改左右对齐方式 字体颜色等）
- (void)setTitleLeftLabelStr:(NSString *)leftStr andRightLabelStr:(NSString *)rightStr andReplaceStr:(NSString *)replaceStr andUseSign:(NSString *)useSign;

@end
