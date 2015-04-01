//
//  CurriculumView.h
//  AmoyMasterStudents
//
//  Created by hanyazhou on 15/4/1.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"

/*!前边是文字，后边是评论的星级*/
@interface CurriculumView : UIView

/*!标题，备用项*/
@property (nonatomic, strong) NSString            *titleString;
/*!星级*/
@property (nonatomic, strong) CWStarRateView      *starRateView;

@end
