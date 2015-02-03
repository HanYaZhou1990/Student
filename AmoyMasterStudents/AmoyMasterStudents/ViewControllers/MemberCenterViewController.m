//
//  MemberCenterViewController.m
//  Student
//
//  Created by Han_YaZhou on 15/2/2.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import "MemberCenterViewController.h"

@interface MemberCenterViewController ()

@end

@implementation MemberCenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
        {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人中心" image:[UIImage imageNamed:@"icon_main_person.png"] selectedImage:[UIImage imageNamed:@"icon_main_person.png"]];
        }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
