//
//  AnswerViewController.h
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/2/28.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "BaseViewController.h"

typedef enum {
    AnswerViewControllerSubjectTypeOne,
    AnswerViewControllerSubjectTypeThree,
}AnswerViewControllerSubjectType;

typedef enum{
    AnswerViewControllerModelsTypeCar,
    AnswerViewControllerModelsTypeTruck,
    AnswerViewControllerModelsTypeBus,
}AnswerViewControllerModelsType;

@interface AnswerViewController : BaseViewController

/*!科目类型*/
@property (nonatomic, assign) AnswerViewControllerSubjectType   subjectType;

/*!车型*/
@property (nonatomic, assign) AnswerViewControllerModelsType    modelsType;
@end
