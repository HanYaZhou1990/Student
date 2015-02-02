//
//  CoachViewController.m
//  Student
//
//  Created by Han_YaZhou on 15/2/2.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import "CoachViewController.h"

@interface CoachViewController ()

@end

@implementation CoachViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
        {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"教练广场" image:[UIImage imageNamed:@"icon_main_square.png"] selectedImage:[UIImage imageNamed:@"icon_main_square.png"]];
        }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"教练广场";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
