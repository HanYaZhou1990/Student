//
//  ExamViewController.h
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/2/28.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "BaseViewController.h"

typedef enum {
    ExamViewControllerTypeOne,
    ExamViewControllerTypeThree
}ExamViewControllerType;

@interface ExamViewController : BaseViewController

/*!科目类型*/
@property (nonatomic, assign) ExamViewControllerType   examType;

@end
