//
//  BodyOfDateVCViewController.m
//  Enjoy
//
//  Created by IMAC on 16/3/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBodyOfDateVCViewController.h"
#import "HJUser.h"
#import "UMSocialSnsService.h"
#import "UMSocial.h"

@interface HJBodyOfDateVCViewController ()<UIWebViewDelegate,UMSocialUIDelegate>
{
    NSString *bodyDataUrlStr;
}
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation HJBodyOfDateVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //身体数据报告详细(我是游客)
    self.title = @"身体数据报告详细";
    
    UIView *navView = [UIView lh_viewWithFrame:CGRectMake(0, 0, kScreenWidth, 64) backColor:APP_COMMON_COLOR];
    UIButton *leftBtn = [UIButton lh_buttonWithFrame:CGRectMake(20, 25, 30, 30) target:self action:@selector(backAct) image:kImageNamed(@"ic_nav_fanhui")];
    UILabel *titleLab = [UILabel lh_labelAdaptionWithFrame:CGRectMake(50, 30, kScreenWidth-100, 35) text:@"身体数据报告详细" textColor:kWhiteColor font:FONT(17) textAlignment:NSTextAlignmentCenter];
    UIButton *shareBtn = [UIButton lh_buttonWithFrame:CGRectMake(kScreenWidth-50, 25, 30, 30) target:self action:@selector(shareBtnAct) image:kImageNamed(@"ic_c17_01")];
    [navView addSubview:leftBtn];
    [navView addSubview:titleLab];
    [navView addSubview:shareBtn];
    [self.view addSubview:navView];
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    
    NSString *pramesDicUrlStr =  [self.visterDic mj_JSONString];
    
    NSString *userId = [HJUser read].loginModel.userId;
    
    bodyDataUrlStr = [NSString stringWithFormat:@"%@?data=%@&userId=%@&userType=3",Report_Details_url,pramesDicUrlStr,userId];
    
    [self webViewLoadRequestWithUrlStr:bodyDataUrlStr];
    
}

#pragma mark - 返回

- (void)backAct {
    
    [self.navigationController popToRootVC];

}
#pragma mark - 分享
- (void)shareBtnAct
{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"5734593e67e58e9f27003459" shareText:@"好享瘦分享~" shareImage:[UIImage imageNamed:@"ic_logo"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession, UMShareToWechatTimeline, UMShareToQQ, UMShareToQzone, nil] delegate:self];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = bodyDataUrlStr;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = bodyDataUrlStr;
    [UMSocialData defaultData].extConfig.qqData.url = bodyDataUrlStr;
    [UMSocialData defaultData].extConfig.qzoneData.url = bodyDataUrlStr;
}

#pragma mark - webView加载Request
- (void)webViewLoadRequestWithUrlStr:(NSString *)urlStr {
    
    NSLog(@"urlStr-%@",urlStr);
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [self.webView loadRequest:request];
}

@end
