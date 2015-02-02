//
//  KnowledgeViewController.m
//  Student
//
//  Created by Han_YaZhou on 15/2/2.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import "KnowledgeViewController.h"

@interface KnowledgeViewController ()

@end

@implementation KnowledgeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
        {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"学车知识" image:[UIImage imageNamed:@"icon_main_knowledge.png"] selectedImage:[UIImage imageNamed:@"icon_main_knowledge.png"]];
        }
    return self;
}

- (void)viewDidLoad {
    self.title = @"学车知识";
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
