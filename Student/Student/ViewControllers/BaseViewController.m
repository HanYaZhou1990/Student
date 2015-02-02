//
//  BaseViewController.m
//  EKitchen
//
//  Created by julong on 15/1/17.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBA(244, 244, 244, 1);
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
