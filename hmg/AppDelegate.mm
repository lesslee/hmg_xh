//
//  AppDelegate.m
//  hmg
//
//  Created by Lee on 15/3/23.
//  Copyright (c) 2015年 com.lz. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "ViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
@interface AppDelegate ()


@property (nonatomic) BOOL isLaunchedByNotification;


@end

@implementation AppDelegate
    @synthesize userInfo1;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;//这个是点击空白区域键盘收缩的开关
                                             // 设置输入框与键盘间距
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 44;
    
        // 默认键盘上面有toolbar，不要的话设置NO
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
        //启动图片停留时间2秒
    //[UIView setAnimationDuration:2.0];
    
    //1.初始化ShareSDK应用,字符串"5559f92aa230"换成http://www.mob.com/后台申请的ShareSDK应用的Appkey
    [ShareSDK registerApp:@"fdacc2ba8c90"];
    
    //2. 初始化社交平台
    [self initializePlat];

    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"2Z62RDC8zTNraGQEUQ578bEavs92mnoP"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    
    
    //极光推送
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
            //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
        //5754e52172b342dca7e6ddc6
        //ffcedbe3f12ebbb90efc9dfc  wo zijide
    //appKey : 在极光推送申请下来的appKey channel : 可以直接设置默认值即可 Publish channel
    [JPUSHService setupWithOption:launchOptions appKey:@"5754e52172b342dca7e6ddc6"
                          channel:@"Publish channel"
                 apsForProduction:YES  //如果为生产环境为yes,开发环境为no
     ];
    
    
    [NSThread sleepForTimeInterval:1.0];
    [_window makeKeyAndVisible];
    return YES;
}

-(void)initializePlat{
//连接邮件
    [ShareSDK connectMail];
}

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [JPUSHService resetBadge];
    
    [application setApplicationIconBadgeNumber:0];//清除角标
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
    //第三步： 接受Token值
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
        // Required
        // 第四步：   向服务器发送Token值
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}


- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
   NSLog(@"DeviceToken 获取失败，原因：%@",error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif

//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    
//        // Required
//    [JPUSHService handleRemoteNotification:userInfo];
//    
//    application.applicationIconBadgeNumber = 0;
//       NSLog(@"收到通知:%@", [self logDic:userInfo]);
//   
//}


//iOS 7 Remote Notification
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"this is iOS7 Remote Notification");
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
        // Required
       NSLog(@"收到通知:%@", [self logDic:userInfo]);
   
    
    // 1.应用正处理前台状态下，不会收到推送消息，因此在此处需要额外处理一下
    if (application.applicationState == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收到推送消息"
                                                        message:userInfo[@"aps"][@"alert"]
                                                       delegate:nil
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
        [alert show];
    }else{
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收到推送消息"
                                                        message:userInfo[@"aps"][@"alert"]
                                                       delegate:nil
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];

        [alert show];
    }
    
}
- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

    // log NSSet with UTF8
    // if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

@end
