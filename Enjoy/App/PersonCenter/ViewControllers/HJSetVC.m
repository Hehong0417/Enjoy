//
//  HJSetVC.m
//  Enjoy
//
//  Created by zhipeng-mac on 16/2/25.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJSetVC.h"
#import "HJFeedbackVC.h"
#import "HJUser.h"
#import "HJLoginVC.h"
#import "HJAboutWeVC.h"
#import "UMSocialSnsService.h"
#import "UMSocial.h"
#import "HJExitLoginView.h"

@interface HJSetVC () <UMSocialUIDelegate,UIAlertViewDelegate>

@end

@implementation HJSetVC


#pragma mark - HJViewControllerProtocol

- (void)doSomeThingInViewDidLoad {
    
    self.title = @"设置";
    
    [self addExitBtn];
    
}

#pragma mark - Actions

- (void)exitAct {
    HJExitLoginView *warnView = [HJExitLoginView exitLoginView];
    [self.view addSubview:warnView];
    warnView.certanBlock = ^{
        HJUser *user = [HJUser sharedUser];
        user.loginModel = nil;
        user.isLogin = NO;
        [user write];
        HJLoginVC *loginVC = (HJLoginVC *)[UIViewController lh_createFromStoryboardName:@"Login" WithIdentifier:@"HJLoginVC"];
        HJNavigationController *nav = [[HJNavigationController alloc]initWithRootViewController:loginVC];
        [UIApplication sharedApplication].keyWindow.rootViewController = nav;
    };
}

#pragma mark - Methods
- (void)addExitBtn {
    UIView *footView = [UIView lh_viewWithFrame:CGRectMake(0, 0, kScreenWidth, 100) backColor:kVCBackGroundColor];
    UIButton *exitBtn = [UIButton lh_buttonWithFrame:CGRectMake(30, 60, kScreenWidth-2*30, 35) target:self action:@selector(exitAct) title:@"注销登录" titleColor:kWhiteColor font:FONT(14) backgroundColor:APP_COMMON_COLOR];
    [exitBtn lh_setCornerRadius:5 borderWidth:0 borderColor:kClearColor];
    [footView addSubview:exitBtn];
    self.tableView.tableFooterView = footView;
}

- (void)ValueChange:(UISwitch *)swi {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:swi.on forKey:@"messageSwitch"];
    [defaults synchronize];
}


#pragma mark - HJDataHandlerProtocol



#pragma mark - Setter&Getter

- (NSArray *)groupTitles {
    
    return @[ @[@"提醒开关",
              @"分享APP",
              @"意见反馈",
//              @"检查更新",
              @"关于我们"] ];
}

- (NSArray *)rightViewSwitchIndexPaths {
    
    return @[[NSIndexPath indexPathForRow:0 inSection:0]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 1:{
            //分享
            [UMSocialSnsService presentSnsIconSheetView:self appKey:@"5734593e67e58e9f27003459" shareText:@"好享瘦分享~" shareImage:[UIImage imageNamed:@"ic_logo"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession, UMShareToWechatTimeline, UMShareToQQ, UMShareToQzone, nil] delegate:self];
            [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://hxsapp.lvshou.me/";
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://hxsapp.lvshou.me/";
            [UMSocialData defaultData].extConfig.qqData.url = @"http://hxsapp.lvshou.me/";
            [UMSocialData defaultData].extConfig.qzoneData.url = @"http://hxsapp.lvshou.me/";
        }
            break;
        case 2:
            //意见反馈
            [self.navigationController pushViewControllerWithStoryBoardName:@"PersonCenter" identifier:@"HJFeedbackVC"];
            break;
//        case 3:
//            //检查更新
//            
//            break;
        case 3:
            //关于
            [self.navigationController pushVC:[[HJAboutWeVC alloc] init]];
            
            break;
        default:
            break;
    }
    
}
@end
