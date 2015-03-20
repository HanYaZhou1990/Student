//
//  TimeLineModel.m
//  AmoyMasterStudents
//
//  Created by julong on 15/2/9.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "TimeLineModel.h"

@implementation TimeLineModel

@synthesize type,titleContent,detailContent,dateContent;

- (id)initWithDictionary:(NSDictionary *)userDictionary
{
    if (self = [super init])
        {
        type = @"1";
        titleContent = userDictionary[@"content"];
        detailContent = @"";
        dateContent = userDictionary[@"create_time"];
        }
    return self;
}

@end
