//
//  MessageSave.h
//  xuexin
//
//  Created by julong on 14-6-5.
//  Copyright (c) 2014年 mx. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MessageSave <NSObject> @end

@interface MessageSave : NSObject

@property (nonatomic,strong) NSString *saveMessage;
@property (nonatomic,strong) NSString *saveMessageTwo;
@property (nonatomic,strong) NSString *titleString;
@property (nonatomic,assign) NSInteger indexPathRow;

@end
