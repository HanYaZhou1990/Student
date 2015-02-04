//
//  YZCollectionReusableView.h
//  AmoyMasterStudents
//
//  Created by Han_YaZhou on 15/2/5.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Color.h"
#import "EMBAMineMenuView.h"

@class YZCollectionReusableView;

@protocol YZCollectionReusableViewDelegate <NSObject>

- (void)collectionView:(YZCollectionReusableView *)collectionView view:(UIView *)view buttonSeleectIndex:(NSInteger)indexOfButton;

@end

@interface YZCollectionReusableView : UICollectionReusableView<EMBAMineMenuViewDelegate>

@property (nonatomic, assign)id <YZCollectionReusableViewDelegate> delegate;

@end
