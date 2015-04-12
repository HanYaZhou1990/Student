//
//  InClassView.h
//  AmoyMasterStudents
//
//  Created by Apple on 15/3/27.
//  Copyright (c) 2015年 XHH. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 正在上课/上课结束
 */

@protocol InClassViewDelegate <NSObject>
@required
- (void)inClassBtClick;
@end

@interface InClassView : UIView
@property (nonatomic, strong) id<InClassViewDelegate> delegate;
@property (nonatomic, strong) UILabel *coach; // 教练;
@property (nonatomic, strong) UILabel *notificationContent; // 通知内容;


@end
