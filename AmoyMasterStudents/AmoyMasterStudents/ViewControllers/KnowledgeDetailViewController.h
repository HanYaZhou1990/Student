//
//  KnowledgeDetailViewController.h
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/3/17.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "BaseViewController.h"
#import "AFNetworking.h"

@interface KnowledgeDetailViewController : BaseViewController

/*!导航的标题*/
@property (nonatomic, strong) NSString      *titleString;
/*!code*/
@property (nonatomic, strong) NSString      *detailUrlString;
@end
