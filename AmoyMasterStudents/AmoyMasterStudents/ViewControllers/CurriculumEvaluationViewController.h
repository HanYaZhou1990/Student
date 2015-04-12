//
//  CurriculumEvaluationViewController.h
//  AmoyMasterStudents
//
//  Created by hanyazhou on 15/4/1.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "BaseViewController.h"
#import "CurriculumView.h"
#import "CustomTextView.h"
#import "CustomSegument.h"
#import "ComplaintViewController.h"
#import "BadReviewView.h"
#import "AFNetworking.h"

/*!评论页面*/
@interface CurriculumEvaluationViewController : BaseViewController <UITextViewDelegate,CustomSegumentDelegate,CWStarRateViewDelegate,BadReviewViewDelegate>

@property (nonatomic, strong) NSDictionary *curriculumDict;

@end
