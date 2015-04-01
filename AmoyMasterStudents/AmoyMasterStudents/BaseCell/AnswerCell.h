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
    AnswerCellTypeSee,    /*查看错题的时候的cell*/
}AnswerCellType;

@interface AnswerCell : UITableViewCell

/*!默认是考试的时候的cell*/
@property (nonatomic, assign) AnswerCellType    cellType;

@property (nonatomic,strong) NSString           *contentString;

@end
