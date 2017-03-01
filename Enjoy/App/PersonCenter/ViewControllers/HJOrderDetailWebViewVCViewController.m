//
//  HJOrderDetailWebViewVCViewController.m
//  Enjoy
//
//  Created by IMAC on 16/5/12.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJOrderDetailWebViewVCViewController.h"

@interface HJOrderDetailWebViewVCViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation HJOrderDetailWebViewVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    NSDictionary *pramesDic = @{@"orderId":self.orderNo};
    NSString *urlStr = [Order_Detaisl_url  lh_subUrlAddParameters:pramesDic];
    [self webViewLoadRequestWithUrlStr:urlStr];
}
#pragma mark - webView加载Request
- (void)webViewLoadRequestWithUrlStr:(NSString *)urlStr {
    
    NSLog(@"urlStr-%@",urlStr);
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:urlStr]];
    
    [self.webView loadRequest:request];
    
}

#pragma mark - webViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSURL *url = [request URL];
    NSString *urlStr = url.absoluteString;
    
    DDLogInfo(@"url = %@",urlStr);
    
        if ([urlStr containsString:@"online_message.html"]) {
            self.title = @"在线留言";
            UIButton *leftButton = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
            [leftButton bk_removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
            [leftButton lh_setTapActionWithBlock:^{
                if (webView.canGoBack) {
                    [webView goBack];
                    self.title = @"订单详情";
                }else {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
            return YES;
            }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
