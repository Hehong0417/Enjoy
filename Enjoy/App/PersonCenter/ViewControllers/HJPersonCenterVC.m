//
//  HJPersonCenterVC.m
//  Enjoy
//
//  Created by zhipeng-mac on 16/2/25.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJPersonCenterVC.h"
#import "HJPersonCenterHeaderView.h"
#import "HJSetVC.h"
#import "HJDietDairyTVC.h"
#import "HJfamilyUserTVC.h"
#import "HJVisitorSTVC.h"
#import "HJMyDevicesTVC.h"
#import "HJMyOrderTVC.h"
#import "HJMyMessageTVC.h"
#import "HJUserInfoSTVC.h"
#import "HJH5CommonVC.h"
#import "HJBodyDataTVC.h"
#import "HJUserDetailAPI.h"
#import "HJUser.h"
#import "HJCheckNewOrderAPI.h"
#import "HJThinPlanHomeAPI.h"
#import "JPUSHService.h"

@interface HJPersonCenterVC ()<HJPersonCenterHeaderViewDeletage>
@property (nonatomic, strong) HJPersonCenterHeaderView *headerView;
@property (nonatomic, strong) HJCheckModel *checkModel;
@end

@implementation HJPersonCenterVC

- (HJPersonCenterHeaderView *)headerView{
    if (!_headerView) {
        _headerView =  [HJPersonCenterHeaderView new];
    }
    _headerView.delegate = self;
    return _headerView;
}


#pragma mark - HJViewControllerProtocol
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self checkNewOrder];
}

- (void)doSomeThingInViewDidLoad {
//    self.headerView.userInteractionEnabled = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 5, 0);
    WEAK_SELF();
    self.headerView.headerBlock = ^{
        [weakSelf.navigationController pushVC:[[HJUserInfoSTVC alloc] init]];
    };
    [self getUserDetailInfo];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[[UIApplication sharedApplication] keyWindow] setBackgroundColor:[UIColor whiteColor]];
    HJUserDetailModel *model = [HJUserDetailModel read];
    self.headerView.userDetailModel = model;
    [self setTabBarItem];
}
- (void)checkNewOrder{
    
    HJThinPlanHomeModel *thinModel = [HJThinPlanHomeModel read];

    [[[HJCheckNewOrderAPI checknewOrderWithPhone:thinModel.phone] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        
        HJCheckNewOrderAPI *api = responseObject;
        
        UIImageView *newOrderView = self.MessageViewArray[1];
        if ([api.data.haveNewOrder isEqualToNumber:@1]) {
            //有小红点
            newOrderView.image = kImageNamed(@"ic_c1_14");
        }else {
            //无小红点
            newOrderView.image = kImageNamed(@"");
        }
    }];
}
- (void)setTabBarItem
{
    HJTabBarController *tabBarController = (HJTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    HJNavigationController *nvc = tabBarController.childViewControllers[2];
    UIViewController *vc = nvc.childViewControllers.firstObject;
    [vc.tabBarItem setImage:[[UIImage imageNamed:@"ic_a33_16"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

#pragma mark - Methods
- (void)getUserDetailInfo
{
    [[[HJUserDetailAPI getUserDetail] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJUserDetailAPI *api = responseObject;
        if (api.code == 1) {
            HJUserDetailModel *model = api.data;
            if (![model  isEqual: @""]) {
                [model write];
                self.headerView.userDetailModel = model;
            }
        }
    }];
}

- (void)networkDidReceiveMessage:(NSNotification *)notification
{
    NSDictionary *info = notification.userInfo;
    NSString *message = [info objectForKey:@"content"];
    if ([message isEqualToString:@"systemMessage"]) {
        UIImageView *infoNewMessage =  self.MessageViewArray[0];
        infoNewMessage.image = kImageNamed(@"ic_c1_14");
    }
}

#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            HJH5CommonVC *h5commonVC = [[HJH5CommonVC alloc]init];
            h5commonVC.h5_InterfaceType = HJDiet_DiaryType;
            [self.navigationController pushVC:h5commonVC];
        }
            break;
        case 1:
        {
            if (indexPath.row == 0) {
                [self.navigationController pushVC:[[HJfamilyUserTVC alloc] init]];
            } else {
                [self.navigationController pushVC:[[HJVisitorSTVC alloc] init]];
            }
        }
            break;
        case 2:
        {
            if (indexPath.row == 0) {
                [self.navigationController pushVC:[[HJMyDevicesTVC alloc] init]];
                
            }else if(indexPath.row == 1){
                UIImageView *newOrderView = self.MessageViewArray[0];
                newOrderView.image = nil;
                [self.navigationController pushVC:[[HJMyMessageTVC alloc] init]];
            }else {
                UIImageView *newOrderView = self.MessageViewArray[1];
                newOrderView.image = nil;
                [self.navigationController pushVC:[[HJMyOrderTVC alloc] init]];
            }
        }
            break;
        case 3:
        {
            [self.navigationController pushVC:[HJSetVC new]];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - Setter&Getter

- (NSArray *)groupTitles {
    
    return @ [
              @[@"减肥日记"],
              @[@"家庭用户",@"我是访客"],
              @[@"我的设备",@"我的消息",@"我的订单"],
              @[@"设置"]
    ];
}

- (NSArray *)groupIcons {
    
    return @ [
              @[@"ic_c1_07"],
              @[@"ic_c1_08",@"ic_c1_09"],
              @[@"ic_c1_10",@"ic_c1_11",@"ic_c1_12"],
              @[@"ic_c1_13"]
              ];
}

- (CGFloat)firstGroupSpacing {
    
    return 0;
}


- (UIView *)tableHeaderView {
    
    return self.headerView;
}

- (NSArray *)rightViewNewMessageIndexPaths
{
    return @[[NSIndexPath indexPathForItem:1 inSection:2],[NSIndexPath indexPathForItem:2 inSection:2]];
}


#pragma mark-------HJPersonCenterHeaderViewDeletage--------
-(void)push:(NSInteger)index{
    switch (index) {
        case 100:{
            NSLog(@"减肥记录");
            HJH5CommonVC *h5commonVC = [[HJH5CommonVC alloc]init];
            h5commonVC.h5_InterfaceType = HJDiet_IndexType;
            [self.navigationController pushVC:h5commonVC];
        }
            break;
        case 101:{
            NSLog(@"身体数据报告");
              //身体数据报告
        HJBodyDataTVC *bodyDataVC = [HJBodyDataTVC new];
            bodyDataVC.reportListType = HJbodyReportType;
            bodyDataVC.userType = @1;
            [self.navigationController pushVC:bodyDataVC];
        }
            break;
        case 102:{
            NSLog(@"健康报告");
            HJBodyDataTVC *bodyDataVC = [HJBodyDataTVC new];
            bodyDataVC.reportListType = HJhealthReportType;
            [self.navigationController pushVC:bodyDataVC];
        }
            break;
        default:{
            NSLog(@"围度");
            HJH5CommonVC *h5commonVC = [[HJH5CommonVC alloc]init];
          HJUser  *user = [HJUser read];
            h5commonVC.h5_InterfaceType = HJArea_TiledType;
            h5commonVC.purseId = [NSNumber numberWithString:user.loginModel.userId];
            h5commonVC.userType = @1;
            [self.navigationController pushVC:h5commonVC];
        }
            break;
    }
}
@end
