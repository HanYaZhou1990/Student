//
//  YYLable.m
//  Timer
//
//  Created by hanyazhou on 15/3/27.
//  Copyright (c) 2015年 HYZ. All rights reserved.
//

#import "YYLable.h"

@implementation YYLable

- (id)initWithFrame:(CGRect)frame outTime:(int)timeOut
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:20];
        self.textAlignment = NSTextAlignmentCenter;
        self.layer.cornerRadius = 18;
        self.clipsToBounds = YES;
        self.backgroundColor = RGBA(244, 244, 244, 1);
        self.textColor = UIColorFromRGB(0x666666);
        [self timerWithOutTime:timeOut];
    }
    return self;
}

- (void)setOutTime:(int)outTime {
    [self setTime:outTime];
}

- (void)timerWithOutTime:(int)timeOut {
    [self setTime:timeOut];
}

- (void)setTime:(int)timeOut {
    __block int timeout=timeOut; /*倒计时时间*/
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); /*每秒执行*/
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){
            /*倒计时结束，关闭*/
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                /*设置界面的按钮显示 根据自己需求设置*/
                self.text = @"00:00";
            });
        }else{
            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"剩余时间  %d分%.2d秒",minutes, seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                /*设置界面的按钮显示 根据自己需求设置*/
                self.text = strTime;
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}

@end
