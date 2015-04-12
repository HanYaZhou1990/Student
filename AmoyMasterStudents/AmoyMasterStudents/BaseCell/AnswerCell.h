//
//  AnswerCell.h
//  AmoyMasterStudents
//
//  Created by hanyazhou on 15/3/11.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    AnswerCellTypeExam,    /*考试时候的cell*/
    AnswerCellTypeSee,     /*查看错题的时候的cell*/
}AnswerCellType;

typedef enum {
    /*单选题和判断题可以使用   AnswerCellQuestionTypeMCQ */
    AnswerCellQuestionTypeMCQ,     /*考题类型是  单选题*/
    AnswerCellQuestionTypeTFQ,     /*考题类型是  判断题*/
    AnswerCellQuestionTypeMCQM,    /*考题类型是  多选题*/
}AnswerCellQuestionType;

@interface AnswerCell : UITableViewCell

/*!默认是考试的时候的cell*/
@property (nonatomic, assign) AnswerCellType            cellType;
/*!试题类型  [MCQ, MCQM, TFQ]，分别代表单选题，多选题和是非题 */
@property (nonatomic, assign) AnswerCellQuestionType    questionType;
/*!标记选中*/
@property (nonatomic, assign) BOOL                      mySelected;

@property (nonatomic,strong) NSAttributedString         *contentString;

@end
