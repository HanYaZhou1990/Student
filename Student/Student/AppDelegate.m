//
//  AppDelegate.m
//  Student
//
//  Created by Han_YaZhou on 15/1/22.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarHidden:YES]; //偏移
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xF0F0F0)];//设置导航栏背景颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    if (IOS7)
        {
            //标题颜色
        
        [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:166.0/255.0 green:166.0/255.0 blue:166.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                               nil, NSShadowAttributeName,
                                                               [UIFont systemFontOfSize:10], NSFontAttributeName, nil]];
        }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    RootBarViewController *rootViewController = [[RootBarViewController alloc] init];
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    controller.navigationBarHidden = YES;
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
