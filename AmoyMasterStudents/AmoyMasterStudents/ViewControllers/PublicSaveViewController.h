//
//  PublicSaveViewController.h
//  KH_MobileShop
//
//  Created by yons on 13-10-16.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
//定义协议名称及方法
@protocol PublicSaveViewControllerDelegate
-(void)publicSaveMessage:(id)sender;
@end


@interface PublicSaveViewController : BaseViewController<UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) NSString *titleStr;
@property (nonatomic,strong) NSString *textFieldStr; //默认进入显示内容
@property (nonatomic,strong) NSString *isSaveVerification; // 0不验证可空 1验证不为空
@property (nonatomic,strong) NSString *isUsedStr;
@property (nonatomic,assign) int  maxLenth;

@property (nonatomic,strong) NSString *isValidateStr; //验证内容


@property UITextView *uiTextView;
@property UITextField *textField;

//声明代理名称
@property (nonatomic,assign) id<PublicSaveViewControllerDelegate> publicSaveVCdelegate;



@end
