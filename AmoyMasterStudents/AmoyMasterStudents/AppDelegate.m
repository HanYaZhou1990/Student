//
//  AppDelegate.m
//  AmoyMasterStudents
//
//  Created by julong on 15/2/3.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "AppDelegate.h"
#import "NotificationTool.h"


@interface AppDelegate ()
@property (nonatomic, strong) RootTabBarController *rootViewController;
@end

@implementation AppDelegate

- (void)registerPushForIOS8{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    
        //Types
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        //Actions
    UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
    acceptAction.identifier = @"ACCEPT_IDENTIFIER";
    acceptAction.title = @"Accept";
    acceptAction.activationMode = UIUserNotificationActivationModeForeground;
    acceptAction.destructive = NO;
    acceptAction.authenticationRequired = NO;
        //Categories
    UIMutableUserNotificationCategory *inviteCategory = [[UIMutableUserNotificationCategory alloc] init];
    inviteCategory.identifier = @"INVITE_CATEGORY";
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextDefault];
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextMinimal];
    NSSet *categories = [NSSet setWithObjects:inviteCategory, nil];
    
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
}

- (void)registerPush{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
}

- (void)pushWithOptions:(NSDictionary *)launchOptions {
    //初始化app
    [XGPush startApp:2200086882 appKey:@"IWLCQU31451D"];
    
    //注销之后需要再次注册前的准备
    void (^successCallback)(void) = ^(void){
        //如果变成需要注册状态
        if(![XGPush isUnRegisterStatus])
            {
//iOS8注册push方法
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
            
            float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
            if(sysVer < 8){
                [self registerPush];
            }
            else{
                [self registerPushForIOS8];
            }
#else
            //iOS8之前注册push方法
            //注册Push服务，注册后才能收到推送
            [self registerPush];
#endif
            }
    };
    /*如果注销过信鸽，需要再次注册push服务前的准备*/
    [XGPush initForReregister:successCallback];
    
    
        //推送反馈回调版本示例
    void (^successBlock)(void) = ^(void){
        //成功之后的处理
        NSLog(@"[XGPush]handleLaunching's successBlock");
    };
    
    void (^errorBlock)(void) = ^(void){
        //失败之后的处理
        NSLog(@"[XGPush]handleLaunching's errorBlock");
    };
    
    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    //清除所有通知(包含本地通知)
    //[[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    [XGPush handleLaunching:launchOptions successCallback:successBlock errorCallback:errorBlock];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self pushWithOptions:launchOptions];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarHidden:YES]; //偏移
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xF0F0F0)];//设置导航栏背景颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    if (IOS7)
    {
        //标题颜色
        [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                               nil, NSShadowAttributeName,
                                                               [UIFont systemFontOfSize:10], NSFontAttributeName, nil]];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    RootTabBarController *rootViewController = [[RootTabBarController alloc] init];
    self.rootViewController = rootViewController;
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    controller.navigationBarHidden = YES;
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    
    
    // 添加友盟数据统计
    [self umengTrack];
 
//  应用程序关闭后收到推送消息，被点击后消息内容在launchOptions里
    if (launchOptions) {
        // launchOptions[@"UIApplicationLaunchOptionsRemoteNotificationKey"]里面的内容才是推送内容，和下面的didReceiveRemoteNotification的userInfo才是一样的，所以要取出来传值过去
        DLog(@"launchOptions :%@", launchOptions);
        NSDictionary *notificationContent = launchOptions[@"UIApplicationLaunchOptionsRemoteNotificationKey"];
        [[[NotificationTool alloc]init] displayNotificationWithRootViewController:rootViewController notificationContent:notificationContent];
        
    }else{
        
// 收到推送没有点击的时候或者没有收到推送，主动向服务器请求数据，判断当前是否在上课状态，或者是否上课结束状态
         NSString *url = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL,trainee_course_check];

         AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
         [manager POST:url parameters:@{} success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
         DLog(@"didFinishLaunchingWithOptions --- responseObject :%@", responseObject);
         if([responseObject[@"code"] intValue] == 0){
         NSDictionary *notificationContent = responseObject[@"data"];
             DLog(@"notificationContent - %@", notificationContent);
             if (notificationContent) {
                 [[[NotificationTool alloc]init] displayNotificationWithRootViewController:rootViewController notificationContent:notificationContent];
             }else{
                 
             }
         }else{
             DLog(@"没有上课或者上课已经或者其他原因%@", responseObject);
         }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             DLog(@"请求服务器失败%@",error);
         }];
     }
    return YES;
}


- (void)umengTrack{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    [MobClick startWithAppkey:@"551e4dabfd98c5ec5c0005a3" reportPolicy:SEND_INTERVAL   channelId:@""];
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    //notification是发送推送时传入的字典信息
    [XGPush localNotificationAtFrontEnd:notification userInfoKey:@"clockID" userInfoValue:@"myid"];
    
    //删除推送列表中的这一条
    [XGPush delLocalNotification:notification];
    DLog(@"%@",notification);
    //[XGPush delLocalNotification:@"clockID" userInfoValue:@"myid"];

    //清空推送列表
    //[XGPush clearLocalNotifications];
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_

    //注册UserNotification成功的回调
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
        //用户已经允许接收以下类型的推送
        //UIUserNotificationType allowedTypes = [notificationSettings types];
    
}

    //按钮点击事件回调
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler{
    if([identifier isEqualToString:@"ACCEPT_IDENTIFIER"]){
        NSLog(@"ACCEPT_IDENTIFIER is clicked");
    }
    
    completionHandler();
}

#endif

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    void (^successBlock)(void) = ^(void){
            //成功之后的处理
        NSLog(@"[XGPush]register successBlock");
    };
    
    void (^errorBlock)(void) = ^(void){
            //失败之后的处理
        NSLog(@"[XGPush]register errorBlock");
    };
    
        //注册设备
    [[XGSetting getInstance] setChannel:@"appstore"];
    [[XGSetting getInstance] setGameServer:@"巨神峰"];
    
    
    NSString * deviceTokenStr = [XGPush registerDevice:deviceToken successCallback:successBlock errorCallback:errorBlock];
    
    
    NSMutableDictionary *deviceTokenDict = [NSMutableDictionary dictionary];
    [deviceTokenDict setObject:deviceTokenStr forKey:@"deviceToken"];
    [deviceTokenDict writeToFile:DEST_PATH_DeviceToken atomically:YES];
    
    
    //打印获取的deviceToken的字符串
    NSLog(@"deviceTokenStr is %@",deviceTokenStr);
}

//如果deviceToken获取不到会进入此事件
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    
    NSString *str = [NSString stringWithFormat: @"Error: %@",err];
    
    NSLog(@"deviceToken获取不到+++%@",str);
    
}

#pragma mark - 前台和后台推送消息过来执行该方法
- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
    DLog(@"%@",userInfo);
        //推送反馈(app运行时)
    // 显示推送内容
    [[[NotificationTool alloc] init] displayNotificationWithRootViewController:self.rootViewController notificationContent:userInfo];
    [XGPush handleReceiveNotification:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

#pragma mark - 应用进入到前台的时候调用这个方法，那么只需要在这个方法里向服务器发送请求看当前是否在上课状态，如果上课状态，就直接跳转到上课界面
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
     NSString *url = [NSString stringWithFormat:@"%@%@",BASE_PLAN_URL,trainee_course_check];
     AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     [manager POST:url parameters:@{} success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
     DLog(@"applicationWillEnterForeground --- responseObject :%@", responseObject);
     if([responseObject[@"code"] intValue] == 0){
     NSDictionary *notificationContent = responseObject[@"data"];
     [[[NotificationTool alloc]init] displayNotificationWithRootViewController:self.rootViewController notificationContent:notificationContent];
     }else{
     DLog(@"没有上课或者上课结束状态或者其他原因")
     }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     DLog(@"请求服务器失败");
     }];
     
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
