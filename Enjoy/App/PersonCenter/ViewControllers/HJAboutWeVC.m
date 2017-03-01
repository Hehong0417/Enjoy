//
//  HJAboutWeVC.m
//  Enjoy
//
//  Created by 邓朝文 on 16/4/29.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAboutWeVC.h"
#import "HJSystemAttributeAPI.h"

@interface HJAboutWeVC ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) HJSystemAttributeModel *systemAttributeModel;
@property (nonatomic, strong) UIImageView *logoImg;
@property (nonatomic, strong) UITextView *ValueText;
@end

@implementation HJAboutWeVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self getAboutWeInfo];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
    [self.view addSubview:self.webView];
    
    NSString *urlStr = @"http://42.159.229.56:80/enjoythin-mb/system/systemAttribute.json?Type=1&userId=221&token=3ed111deef3f480dbae51ad08e8cfc73&name=aboutWe";
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
    
}
- (void)doSomeThingInViewDidLoad
{
    self.title = @"关于我们";
//    [self addSubViews];
}

- (void)getAboutWeInfo
{
    [[[HJSystemAttributeAPI getAboutWeWithName:@"aboutWe" Type:@"1"] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
        HJSystemAttributeAPI *api = responseObject;
        self.systemAttributeModel = api.data.systemAttribute;
        [self refreshView];
    }];
}
- (void)addSubViews {
    self.logoImg = [UIImageView lh_imageViewWithFrame:CGRectMake(kScreenWidth/2-40, 64+60, 80, 80) image:kImageNamed(@"ic_logo")];
    [self.view addSubview:self.logoImg];
    
    self.ValueText = [UITextView lh_textViewWithFrame:CGRectMake(15, CGRectGetMaxY(self.logoImg.frame)+50, kScreenWidth-30, kScreenHeight - CGRectGetMaxY(self.logoImg.frame)-60) font:FONT(14) backgroundColor:kVCBackGroundColor];
    [self.view addSubview:self.ValueText];
    
}
- (void)refreshView
{
    self.ValueText.text = self.systemAttributeModel.value;
}

@end
