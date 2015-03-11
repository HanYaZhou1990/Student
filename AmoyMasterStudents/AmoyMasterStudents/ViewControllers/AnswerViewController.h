//
//  AnswerViewController.h
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/2/28.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "BaseViewController.h"
#import "ExaminationCell.h"
#import "AnswerCell.h"

typedef enum {
    AnswerViewControllerSubjectTypeOne,
    AnswerViewControllerSubjectTypeThree,
}AnswerViewControllerSubjectType;

typedef enum{
    AnswerViewControllerModelsTypeCar,
    AnswerViewControllerModelsTypeTruck,
    AnswerViewControllerModelsTypeBus,
}AnswerViewControllerModelsType;

@interface AnswerViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

/*!科目类型*/
@property (nonatomic, assign) AnswerViewControllerSubjectType   subjectType;

/*!车型*/
@property (nonatomic, assign) AnswerViewControllerModelsType    modelsType;

@property (nonatomic, strong) UITableView                       *questionTableView;
@end
