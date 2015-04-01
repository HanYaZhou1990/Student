//
//  ExamResultViewController.h
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/3/30.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "BaseViewController.h"
#import "AnswerView.h"
#import "WrongViewController.h"

typedef enum {
    ExamResultViewControllerSubjectTypeOne,/*科目一*/
    ExamResultViewControllerSubjectTypeFour,/*科目四*/
}ExamResultViewControllerSubjectType;

@interface ExamResultViewController : BaseViewController

/*!科目类型*/
@property (nonatomic, assign) ExamResultViewControllerSubjectType   subjectType;
/*!从上个页面传过来的提交试卷以后返回的数据中的Data*/
@property (nonatomic, strong) NSDictionary    *dataDictionary;
/*!传过来所有的问题，在错题展示的时候使用*/
@property (nonatomic, strong) NSArray         *questionArray;
@end
