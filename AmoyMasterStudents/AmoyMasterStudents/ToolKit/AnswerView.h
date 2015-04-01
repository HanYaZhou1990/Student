//
//  AnswerView.h
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/3/30.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ITEM_Width (SCREEN_WIDTH - 30)/6
#define ITEM_Height 20
#define WIDTH_COUNT 6

@interface AnswerView : UIView

/*每道题的正确答案*/
@property (nonatomic, strong) NSArray   *answerArray;

@end
