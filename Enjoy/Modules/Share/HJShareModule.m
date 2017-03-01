//
//  HJShareModule.m
//  Apws
//
//  Created by zhipeng-mac on 15/12/21.
//  Copyright (c) 2015年 hejing. All rights reserved.
//

#import "HJShareModule.h"
//
//＝＝＝＝＝＝＝＝＝＝ShareSDK头文件＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//以下是ShareSDK必须添加的依赖库：
//1、libicucore.dylib
//2、libz.dylib
//3、libstdc++.dylib
//4、JavaScriptCore.framework

//＝＝＝＝＝＝＝＝＝＝以下是各个平台SDK的头文件，根据需要继承的平台添加＝＝＝
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//以下是腾讯SDK的依赖库：
//libsqlite3.dylib

//微信SDK头文件
#import "WXApi.h"
//以下是微信SDK的依赖库：
//libsqlite3.dylib

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"
//以下是新浪微博SDK的依赖库：
//ImageIO.framework
//libsqlite3.dylib
//AdSupport.framework


#define SHARE_APP_ID @"14735aeffbdc"
#define SHARE_APP_KEY @"a08e26c4a2863ce56d6e1c57c66e0f32"
//
#define QQ_APP_ID @"1104838221"
#define QQ_APP_KEY @"ZWxsdRNR4FZLjbyX"
//

#define WEIXIN_ID @"wxe3fdd0bdb059c19b"
#define WEIXIN_KEY @"4b499e51afbe08952c54affb47f58968"


@implementation HJShareModule

//
+ (void)initializeSharePlatforms {
    
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个参数用于指定要使用哪些社交平台，以数组形式传入。第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    
    [ShareSDK registerApp:SHARE_APP_ID activePlatforms:@[@(SSDKPlatformTypeSMS),@(SSDKPlatformTypeQQ)] onImport:^(SSDKPlatformType platformType) {
        
        switch (platformType)
        {
//            case SSDKPlatformTypeWechat:
//                //                             [ShareSDKConnector connectWeChat:[WXApi class]];
//                [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
//                break;
            case SSDKPlatformTypeQQ:
                [ShareSDKConnector connectQQ:[QQApiInterface class]
                           tencentOAuthClass:[TencentOAuth class]];
                break;
            default:
                break;
        };
        
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        
        switch (platformType)
        {
//            case SSDKPlatformTypeWechat:
//                [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
//                                      appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
//                break;
            case SSDKPlatformTypeQQ:
                [appInfo SSDKSetupQQByAppId:@"100371282"
                                     appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                   authType:SSDKAuthTypeBoth];
                break;
            default:
                break;
        }
        
    }];
    
}

@end
