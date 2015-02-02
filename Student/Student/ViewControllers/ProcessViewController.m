//
//  ProcessViewController.m
//  Student
//
//  Created by Han_YaZhou on 15/2/2.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import "ProcessViewController.h"

@interface ProcessViewController ()

@end

@implementation ProcessViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
        {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"学车进程" image:[UIImage imageNamed:@"icon_main_process.png"] selectedImage:[UIImage imageNamed:@"icon_main_process.png"]];
        }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"学车进程";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
