//
//  JDTabBarController.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/12.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "HJTabBarController.h"
#import "HJNavigationController.h"
#import "HJStoryBoardItem.h"
#import "HJGetInfomationNewCountAPI.h"
#import "HJGetMessageNewCountAPI.h"

@interface HJTabBarController () <UITabBarControllerDelegate>

@property (nonatomic,strong) NSArray *tabBarItemTitles;
@property (nonatomic,strong) NSArray *tabBarItemNormalImages;
@property (nonatomic,strong) NSArray *tabBarItemSelectedImages;
@property (nonatomic,strong) NSArray *tabBarStoryBoardItems;

@end

@implementation HJTabBarController

#pragma mark - LifeCycle

+ (void)initialize
{
    //设置底部tabbar的主题样式
    UITabBarItem *appearance = [UITabBarItem appearance];
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kFontGrayColor, NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //添加所有的自控制器
    
    [self addAllChildVcs];
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self getInfomationNewCount];
//    [self getMessageNewCount];
//}

- (void)getInfomationNewCount
{
    [[[HJGetInfomationNewCountAPI getInfomationNewCount] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJGetInfomationNewCountAPI *api = responseObject;
        if (api.data) { 
            HJNavigationController *nvc = self.childViewControllers[1];
            UIViewController *vc = nvc.childViewControllers.firstObject;
            [vc.tabBarItem setImage:[[UIImage imageNamed:@"ic_a33_15"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        }
    }];
}

- (void)getMessageNewCount
{
    [[[HJGetMessageNewCountAPI getMessageNewCount] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJGetMessageNewCountAPI *api = responseObject;
        if (api.data) {
            HJNavigationController *nvc = self.childViewControllers[2];
            UIViewController *vc = nvc.childViewControllers.firstObject;
            [vc.tabBarItem setImage:[[UIImage imageNamed:@"ic_a33_17"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        }
    }];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Methods

- (void)addAllChildVcs {
    
    for (int i=0; i < self.tabBarStoryBoardItems.count; i++) {
        
        HJStoryBoardItem *storyBoardItem = self.tabBarStoryBoardItems[i];
        UIViewController *childVC = [storyBoardItem correspondingViewController];
        
        [self addOneChildVc:childVC title:self.tabBarItemTitles[i] imageName:self.tabBarItemNormalImages[i] selectedImageName:self.tabBarItemSelectedImages[i] tabBarItemIndex:i];
    }
}

- (void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName tabBarItemIndex:(NSUInteger)tabBarItemIndex {
    
    //设置标题
    childVc.title = title;
    //设置图标
    [childVc.tabBarItem setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //设置选中图标
    [childVc.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    // 矫正TabBar图片位置，使之垂直居中显示
    CGFloat offset = 7.0;
    childVc.tabBarItem.imageInsets = UIEdgeInsetsMake(offset, 0, -offset, 0);
    
    //设置背景
    //    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabBar_bg"];
    
    HJNavigationController *nav = [[HJNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

#pragma mark - Setter&Getter

- (NSArray *)tabBarItemTitles {
    
    if (!_tabBarItemTitles) {
        
        _tabBarItemTitles = @[ @"",
                               @"",
                               @""];
    }
    
    return _tabBarItemTitles;
}

- (NSArray *)tabBarItemNormalImages {
    
    if (!_tabBarItemNormalImages) {
        
        _tabBarItemNormalImages =@[ @"ic_a33_13_pre",
                                    @"ic_a33_14",
                                    @"ic_a33_16",
                                    ];
    }
    
    return _tabBarItemNormalImages;
}

- (NSArray *)tabBarItemSelectedImages {
    
    if (!_tabBarItemSelectedImages) {
        
        _tabBarItemSelectedImages = @[ @"ic_a33_13",
                                       @"ic_a33_14_pre",
                                       @"ic_a33_16_pre",
                                       ];
    }
    
    return _tabBarItemSelectedImages;
}

- (NSArray *)tabBarStoryBoardItems {
    
    if (!_tabBarStoryBoardItems) {
        
        //
        HJStoryBoardItem *item1 = [HJStoryBoardItem itemWithStroyBoardName:SB_HOME_PAGE identifier:@"HJSlimmingPlanVC" viewControllerExist:NO];
        HJStoryBoardItem *item2 = [HJStoryBoardItem itemWithStroyBoardName:SB_SERVICE identifier:@"HJIncrementServiceVC" viewControllerExist:NO];
        HJStoryBoardItem *item3 = [HJStoryBoardItem itemWithStroyBoardName:SB_PERSON_CENTER identifier:@"HJPersonCenterVC" viewControllerExist:NO];
        
        _tabBarStoryBoardItems = @[ item1,
                                    item2,
                                    item3,
                                    ];
    }
    
    return _tabBarStoryBoardItems;
}

@end
