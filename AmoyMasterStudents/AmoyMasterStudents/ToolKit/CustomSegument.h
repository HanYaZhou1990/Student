//
//  CustomSegument.h
//  AmoyMasterStudents
//
//  Created by hanyazhou on 15/4/1.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Custombutton.h"

@protocol CustomSegumentDelegate <NSObject>

- (void)fromView:(UIView *)view didSelectIndex:(NSInteger)indexOfButton;

@end

@interface CustomSegument : UIView

@property (nonatomic, assign) id <CustomSegumentDelegate>   delegate;

@property (nonatomic, strong) NSArray                       *titleArray;

@end
