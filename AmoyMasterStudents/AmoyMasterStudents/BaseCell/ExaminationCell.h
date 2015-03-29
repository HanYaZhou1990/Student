//
//  ExaminationCell.h
//  AmoyMasterStudents
//
//  Created by hanyazhou on 15/3/11.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicConfig.h"
#import "UIImageView+WebCache.h"

@interface ExaminationCell : UITableViewCell
/*!题号，现在做的是第几题*/
@property (nonatomic, strong) NSString   *numberString;
/*!问题内容*/
@property (nonatomic, strong) NSString   *questionString;
/*!如果问题有图片，用来展示图片*/
@property (nonatomic, strong) NSString   *imageString;

@end
