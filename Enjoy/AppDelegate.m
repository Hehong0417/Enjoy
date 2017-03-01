//
//  AppDelegate.m
//  Enjoy
//
//  Created by zhipeng-mac on 16/2/25.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "AppDelegate.h"
#import "HJNavigationController.h"
#import "HJUser.h"
#import "HJLoginVC.h"
#import "HJPersonCenterVC.h"
#import "UMSocialData.h"
#import "UMSocialConfig.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSnsPlatformManager.h"
#import "UMSocialSnsService.h"
#import "IQKeyboardManager.h"
#import "MyGuidePageViewController.h"
#import "JPUSHService.h"
#import "MobClick.h"
#import "WXApi.h"

#define HJUmsocailKey @"5734593e67e58e9f27003459"
#define HJUMengAnalyticsKey @"5734593e67e58e9f27003459"

//#define HJShareWeixinId @"wx8fa1c1d21cbd37e1"
//#define HJShareWeixinSecret @"62ac9e62abb4757a6c216b2ebe7a189b"

#define HJShareWeixinId @"wx8fa1c1d21cbd37e1"
#define HJShareWeixinSecret @"62ac9e62abb4757a6c216b2ebe7a189b"

#define HJShareQQId @"1105262024"
#define HJShareQQSecret @"c7394704798a158208a74ab60104f0ba"

#define HJ_JPUSH_APPKEY @"f5f35f19981715d6c4dad543"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [self.window makeKeyAndVisible];
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
    
    //
    MasterSHAinfo *model = [[MasterSHAinfo alloc] init];
    model.userSex = @"";
    model.userAge = @"";
    model.userHeight = @"";
    [model write];
    
    //
    //Token失效
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginTokenExipire) name:kNotifation_TokenInvalidate object:nil];
    
    if(![[HJUser sharedUser] isFirstEnterApp])
    {
        //第一打开
        [[HJUser sharedUser] setIsFirstEnterApp:YES];
        UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:[[MyGuidePageViewController alloc] initWithNibName:@"MyGuidePageViewController" bundle:nil]];
        navigationController.navigationBar.hidden  =YES ;
        
        self.window.rootViewController= navigationController;
    }else{
        if ([HJUser sharedUser].isLogin) {
            
            self.window.rootViewController = [[HJTabBarController alloc]init];
            
        } else {
            HJLoginVC *loginVC = (HJLoginVC *)[UIViewController lh_createFromStoryboardName:@"Login" WithIdentifier:@"HJLoginVC"];
            HJNavigationController *nav = [[HJNavigationController alloc]initWithRootViewController:loginVC];
            self.window.rootViewController = nav;
        }
    }
    
//            HJNavigationController *nav = [[HJNavigationController alloc]initWithRootViewController:[[HJPersonCenterVC alloc] init]];
//            self.window.rootViewController = nav;
    
    // 极光推送
    [self configureJPushWithLaunchOptions:launchOptions];
    // 友盟分享
    [self configureUmsocial];
    // 友盟统计
    [self configureUMengAnalytics];
    return YES;
}
- (void)configureUMengAnalytics
{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick startWithAppkey:HJUMengAnalyticsKey reportPolicy:BATCH channelId:nil];
}

- (void)loginTokenExipire {
    
    UIViewController *loginVC = [UIViewController lh_createFromStoryboardName:@"Login" WithIdentifier:@"HJLoginVC"];
    HJNavigationController *nav = [[HJNavigationController alloc]initWithRootViewController:loginVC];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showInfoWithStatus:@"登录过期，请重新登录！"];
        self.window.rootViewController = nav;
    });
}

- (void)configureUmsocial {
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:HJUmsocailKey];
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:HJShareWeixinId appSecret:HJShareWeixinSecret url:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:HJShareQQId appKey:HJShareQQSecret url:@"http://www.umeng.com/social"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。若在新浪后台设置我们的回调地址，“http://sns.whalecloud.com/sina2/callback”，这里可以传nil ,需要 #import "UMSocialSinaHandler.h"
    // [UMSocialSinaSSOHandler openNewSinaSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    
   NSArray *shareToSnsNames = @[UMShareToWechatSession, UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone];
    [UMSocialConfig setSnsPlatformNames:shareToSnsNames];
    [UMSocialConfig setFinishToastIsHidden:YES position:UMSocialiToastPositionCenter];
    
    [UMSocialData openLog:YES];
}

- (void)configureJPushWithLaunchOptions:(NSDictionary *)launchOptions {
    [self addJPushWithLaunchOptions:launchOptions];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLoginSuccessNotif:) name:kLoginSuccess_Notifation object:nil];
}

- (void)addJPushWithLaunchOptions:(NSDictionary *)launchOptions {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert |UIRemoteNotificationTypeNewsstandContentAvailability
                                                          )
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert |UIRemoteNotificationTypeNewsstandContentAvailability)
                                              categories:nil];
    }
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];

    NSString *channel = @"adhoc_push";
    BOOL isProduction = NO;
    [JPUSHService setupWithOption:launchOptions appKey:HJ_JPUSH_APPKEY
                          channel:channel apsForProduction:isProduction];

}

- (void)networkDidReceiveMessage:(NSNotification *)notification
{
    NSDictionary *info = notification.userInfo;
    NSString *message = [info objectForKey:@"content"];
    HJTabBarController *tabBarController = (HJTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    if ([message isEqualToString:@"informationMessage"] && tabBarController.childViewControllers.count > 1) {
        HJNavigationController *nvc = tabBarController.childViewControllers[1];
        UIViewController *vc = nvc.childViewControllers.firstObject;
        [vc.tabBarItem setImage:[[UIImage imageNamed:@"ic_a33_15"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    } else if ([message isEqualToString:@"systemMessage"] && tabBarController.childViewControllers.count > 2) {
        HJNavigationController *nvc = tabBarController.childViewControllers[2];
        UIViewController *vc = nvc.childViewControllers.firstObject;
        [vc.tabBarItem setImage:[[UIImage imageNamed:@"ic_a33_17"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:\n%@", userInfo);
    
    NSDictionary *aps = userInfo[@"aps"];
    // 可以不要
    NSInteger badge = [aps[@"badge"] integerValue];
    application.applicationIconBadgeNumber = badge;
    NSString *alert = aps[@"alert"];
    [UIAlertView bk_showAlertViewWithTitle:@"" message:alert cancelButtonTitle:@"确定" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        NSInteger applicationIconBadgeNumber = application.applicationIconBadgeNumber;
        applicationIconBadgeNumber--;
        [JPUSHService setBadge:applicationIconBadgeNumber];
        application.applicationIconBadgeNumber = applicationIconBadgeNumber;
    }];
    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
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
    
    [UMSocialSnsService applicationDidBecomeActive];
    [JPUSHService setTags:nil alias:@"enjoythin" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        NSLog(@"%d", iResCode);
        NSLog(@"%d", iAlias);
    }];

}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [UMSocialSnsService handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
     return [UMSocialSnsService handleOpenURL:url];
}

//---------蓝牙--------//
- (void)applicationWillTerminate:(UIApplication *)application {
    
    //保存Context
    [self saveContext];

}
#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "yang.BLE_AiCare" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BLE_AiCare" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BLE_AiCare.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
