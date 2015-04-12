//
//  AnswerView.m
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/3/30.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "AnswerView.h"

@implementation AnswerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (int i=0; i<_answerArray.count; i++)
        {
            int x=(i%WIDTH_COUNT) + ITEM_Width  * (i%WIDTH_COUNT);
            int y=(i/WIDTH_COUNT) + ITEM_Height * (i/WIDTH_COUNT);
            
            UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(x, y, ITEM_Width, ITEM_Height)];
            lable.tag=(i+1);
            lable.textAlignment = NSTextAlignmentCenter;
    //        lable.text = [NSString stringWithFormat:@"%02li:%@",(long)lable.tag,_answerArray[i][@"ca"]];
            lable.text = [NSString stringWithFormat:@"%02li:%@",(long)[_answerArray[i][@"order"] integerValue],_answerArray[i][@"ca"]];
            lable.font = [UIFont systemFontOfSize:16.0];
            lable.adjustsFontSizeToFitWidth = YES;
            // 判断在模拟考中做对了还是错了
            NSString *is_correct = self.answerArray[i][@"is_correct"];

            if ([is_correct intValue] == 0) { // 错
                lable.textColor = TSFSutentColor;
            }else if([is_correct intValue] == 1){ // 对
                lable.textColor = UIColorFromRGB(0x666666);
            }
            [self addSubview:lable];
        }
}

@end
