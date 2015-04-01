//
//  BadReviewView.h
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/4/1.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Custombutton.h"

#define ITEM_Width (SCREEN_WIDTH - 40)/2
#define ITEM_Height 40
#define WIDTH_COUNT 2

@interface BadReviewView : UIView

/*!标题*/
@property (nonatomic,strong) NSString       *titleString;
/*!选项*/
@property (nonatomic,strong) NSArray        *itemArray;
@end
