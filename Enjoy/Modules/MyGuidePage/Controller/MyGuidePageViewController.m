//
//  MyGuidePageViewController.m
//  ParentingGuru_Expert
//
//  Created by jiangjunwy on 15/9/24.
//  Copyright (c) 2015年 三优科技. All rights reserved.
//

#import "MyGuidePageViewController.h"
#import "HJLoginVC.h"

@interface MyGuidePageViewController ()

@end

@implementation MyGuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (k_iOS7) {
        self.automaticallyAdjustsScrollViewInsets =NO ;
    }
//    self.guideButton.layer.cornerRadius =5.0;
//    self.guideButton.layer.borderColor  =[UIColor whiteColor].CGColor;
//    self.guideButton.layer.borderWidth  =1.0f ;
    [self initGuidePageImage];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.notFirstTime) {
        self.navigationController.navigationBar.hidden = NO ;
    }
}
#pragma mark ----------------------------引导图片读取--------------------------------
-(void)initGuidePageImage{
    NSArray * array = [NSArray arrayWithArray:[self getGuidePageImageMethord:4]];
    
    self.guideImageView1.image  =[UIImage imageNamed:[array objectAtIndex:0] ];
    self.guideImageView2.image  =[UIImage imageNamed:[array objectAtIndex:1] ];
    self.guideImageView3.image  =[UIImage imageNamed:[array objectAtIndex:2] ];
    self.guideImageView4.image  =[UIImage imageNamed:[array objectAtIndex:3] ];
}
//返回引导图片的图片名称数组
-(NSArray*)getGuidePageImageMethord:(NSInteger)pageNumber{
    NSMutableArray * array =[NSMutableArray array];
    for (int i=1;i<=pageNumber;i++) {
        NSString * subString = [NSString stringWithFormat:@"ic_ydy%ld",(long)i];
        [array addObject:subString];
    }
    return array;
}
#pragma mark ----------------------------UIScrollViewDelegate----------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [self.mainPageControl setCurrentPage:offset.x / bounds.size.width];
}
#pragma mark ------------------------------UIPageControl----------------------------
- (IBAction)pageControlClicked:(UIPageControl *)sender {
    CGSize viewSize = self.mainScrollView.frame.size;
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    [self.mainScrollView scrollRectToVisible:rect animated:YES];
}
#pragma mark ------------------------------体验按钮点击事件----------------------------

- (IBAction)nowExperienceButtonClicked:(UIButton *)sender {
    
//    UITabBarController *tabBarController = [[UITabBarController alloc]init];
//    tabBarController.viewControllers = [self CustomTabBar];
//    tabBarController.selectedIndex = 0;
//    [tabBarController.tabBar setTintColor:IWColor(26, 178, 56)];
//    [[UIApplication sharedApplication].delegate.window setRootViewController:tabBarController];
//    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
    if (self.notFirstTime==YES) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        HJLoginVC *loginVC = (HJLoginVC *)[UIViewController lh_createFromStoryboardName:@"Login" WithIdentifier:@"HJLoginVC"];
        HJNavigationController *nav = [[HJNavigationController alloc]initWithRootViewController:loginVC];
        [[UIApplication sharedApplication].keyWindow setRootViewController:nav];
    }
    
}


@end
