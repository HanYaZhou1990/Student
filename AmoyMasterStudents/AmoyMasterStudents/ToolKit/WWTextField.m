//
//  WWTextField.m
//  AmoyMasterStudents
//
//  Created by julong on 15/2/9.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "WWTextField.h"

@implementation WWTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, frame.size.height)];
        leftView.backgroundColor = [UIColor clearColor];
        self.leftView =  leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds=YES;
        self.layer.cornerRadius=4;
    }
    return self;
}

- (id)initWithLeftFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, frame.size.height)];
        leftView.backgroundColor = [UIColor whiteColor];
        
        UILabel *leftLabel = [[UILabel alloc]init];
        leftLabel.frame = CGRectMake(0, 0, 60, frame.size.height);
        leftLabel.backgroundColor = RGBA(0, 165, 109, 1);
        leftLabel.textColor = [UIColor whiteColor];
        leftLabel.font = [UIFont boldSystemFontOfSize:18];
        leftLabel.textAlignment = NSTextAlignmentCenter;
        leftLabel.text = @"+86";
        [leftView addSubview:leftLabel];
        
        self.leftView =  leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds=YES;
        self.layer.cornerRadius=4;
        
    }
    return self;
}

@end
