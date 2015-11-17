//
//  AppDelegate.m
//  iOSStrongDemo
//
//  Created by apple on 15/7/9.
//  Copyright (c) 2015年 LiGang. All rights reserved.
//
//  iOS开发技术网站：http://www.superqq.com/
//  iOS开发微信公众号：iOSDevTip

#import "AppDelegate.h"
#import "ViewController.h"
#import <Bugtags/Bugtags.h>
#import <LocalAuthentication/LocalAuthentication.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    NSLog(@"sourceApplication: %@", sourceApplication);
    NSLog(@"URL scheme:%@", [url scheme]);
    NSLog(@"URL query: %@", [url query]);
    
    if ([sourceApplication isEqualToString:@"com.3Sixty.CallCustomURL"]){
        // 接受传过来的参数
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"打开啦"
                                                            message:[url query]
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
        
        return YES;
    }else{
        return NO;
    }
    
}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL*)url
//{
//    // 接受传过来的参数
//    NSString *text = [[url host] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"打开啦"
//                                           message:text
//                                          delegate:nil
//                                 cancelButtonTitle:@"OK"
//                                 otherButtonTitles:nil];
//    [alertView show];
//    return YES;
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    [Bugtags startWithAppKey:@"e69f2fcac16de5dd471916ab8279dd66" invocationEvent:BTGInvocationEventShake];
    
    
    //接受按钮
    UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
    acceptAction.identifier = @"acceptAction";
    acceptAction.title = @"接受";
    acceptAction.activationMode = UIUserNotificationActivationModeForeground;
    //拒绝按钮
    UIMutableUserNotificationAction *rejectAction = [[UIMutableUserNotificationAction alloc] init];
    rejectAction.identifier = @"rejectAction";
    rejectAction.title = @"拒绝";
    rejectAction.activationMode = UIUserNotificationActivationModeBackground;
    rejectAction.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
    rejectAction.destructive = YES;
    
    UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
    categorys.identifier = @"alert";
    NSArray *actions = @[acceptAction, rejectAction];
    [categorys setActions:actions forContext:UIUserNotificationActionContextMinimal];
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:[NSSet setWithObjects:categorys, nil]];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.alertBody = @"测试推送的快捷回复";
    notification.category = @"alert";
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    
    
//    [self doSomeAuth];
    
    return YES;
}


- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    NSLog(@"%@", notificationSettings);
}

-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler
{
    //在非本App界面时收到本地消息，下拉消息会有快捷回复的按钮，点击按钮后调用的方法，根据identifier来判断点击的哪个按钮，notification为消息内容
    NSLog(@"%@----%@",identifier,notification);
    //处理完消息，最后一定要调用这个代码块
    completionHandler();
}

- (void)doSomeAuth
{
    LAContext *myContext = [[LAContext alloc] init];
    myContext.localizedFallbackTitle = @"支付宝的 Touch ID";
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"通过Home键验证已有手机指纹";
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError])
    {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if(success)
                                {
                                    //处理验证通过
                                }
                                else
                                {
                                    //处理验证失败
                                }
                            }];
    }
    else
    {
        //不支持Touch ID验证，提示用户
    }
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
