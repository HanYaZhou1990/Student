//
//  WrongViewController.h
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/3/31.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "BaseViewController.h"
#import "ExaminationCell.h"
#import "AnswerCell.h"

/*用于展示用户的错题*/
@interface WrongViewController : BaseViewController

/*! 所有题(根据错题里的order取题) */
@property (nonatomic, strong) NSArray    *questionArray;
/*! 所有的错题 */
@property (nonatomic, strong) NSArray    *wrongArray;

@end
