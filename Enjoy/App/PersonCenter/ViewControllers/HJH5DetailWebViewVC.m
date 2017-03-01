//
//  HJH5DetailWebViewVC.m
//  Enjoy
//
//  Created by IMAC on 16/5/8.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJH5DetailWebViewVC.h"
#import "HJSendToolBar.h"
#import "HJAddCommentAPI.h"
#import "WeightManagementVC.h"
#import "HJUser.h"
#import "UMSocialSnsService.h"
#import "UMSocial.h"
#import "IQKeyboardManager.h"
#import "IQToolbar.h"
#import "HJAddShareAPI.h"

@interface HJH5DetailWebViewVC ()<UIWebViewDelegate,UITextFieldDelegate,UMSocialUIDelegate,UIScrollViewDelegate>
{
    BOOL _wasKeyboardManagerEnabled;
    NSString *urlStr1;
    CGFloat oldOffset;
    NSInteger index;
}
@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) HJSendToolBar *sendToolBar;
@end

@implementation HJH5DetailWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"详情";
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-49)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    //拼接参数informationId
    
    NSDictionary *pramesDic = @{@"informationId":self.informationId};
    urlStr1 = [Manager_Note_detail_url  lh_subUrlAddParameters:pramesDic];
    [self webViewLoadRequestWithUrlStr:urlStr1];
    
    //添加发送条

    [self addSendToolBar];
    
    
    //详情评论
    [self.sendToolBar.sendBtn lh_setTapActionWithBlock:^{

            [self sendComment:self.informationId];
        }];
    //咨询体重师按钮
    [self AddConsantTeacerBtn];
    
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - 键盘隐藏通知
-(void)keyboardWillBeHidden:(NSNotification*)aNotification
{
//    NSDictionary *userInfo = aNotification.userInfo;
//    // 键盘的frame
//    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self.sendToolBar.sendText becomeFirstResponder];
}

#pragma mark-------UIWebViewDelegate代理方法-----------
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([[NSString stringWithFormat:@"%@",request.URL] isEqualToString:@"app://share"]) {
        [self sharehealth];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
//    [[IQKeyboardManager sharedManager] resignFirstResponder];
}

#pragma mark - 分享成功

-(void)shareSuccess{
    
    [self.webView stringByEvaluatingJavaScriptFromString:@"ajaxUpdateShareCount()"];
}

#pragma mark - 分享
- (void)sharehealth
{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"5734593e67e58e9f27003459" shareText:@"好享瘦分享~" shareImage:[UIImage imageNamed:@"ic_logo"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession, UMShareToWechatTimeline, UMShareToQQ, UMShareToQzone, nil] delegate:self];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = urlStr1;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = urlStr1;
    [UMSocialData defaultData].extConfig.qqData.url = urlStr1;
    [UMSocialData defaultData].extConfig.qzoneData.url = urlStr1;
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        [[[HJAddShareAPI addShareInfo:[_informationId integerValue] AndbeenShareType:1 AndsharePlate:1] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"分享成功"];
            [self shareSuccess];
        }];

    }
}



#pragma mark - webView加载Request
- (void)webViewLoadRequestWithUrlStr:(NSString *)urlStr {
    
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:urlStr]];
    
    [self.webView loadRequest:request];
    
}

#pragma mark- 添加咨询体重师按钮

- (void)AddConsantTeacerBtn {
    
    UIButton *addTeachBtn = [UIButton lh_buttonWithFrame:CGRectMake(kScreenWidth -70, kScreenHeight - 49 -100, 60, 60) target:self action:@selector(consantTeachAct) image:kImageNamed(@"ic_b5_05")];
    [self.view addSubview:addTeachBtn];
}
- (void)consantTeachAct {

    WeightManagementVC *weightManagerVC = [WeightManagementVC new];
    weightManagerVC.puserId = [NSNumber numberWithString:[HJUser read].loginModel.userId];
    weightManagerVC.consantType = Detail_Type;
    [self.navigationController pushVC:weightManagerVC];
}
#pragma -mark ----添加发送条

- (void)addSendToolBar{
    self.sendToolBar = [[[NSBundle mainBundle]loadNibNamed:@"HJSendToolBar" owner:self options:nil]firstObject];
    self.sendToolBar.frame = CGRectMake(0, kScreenHeight-49, kScreenWidth, 49);
    [self.view addSubview:self.sendToolBar];
    
}
#pragma mark ----发送评论---

- (void)sendComment:(NSString *)informationId {
    NSString *sendContent =  self.sendToolBar.sendText.text;
    if (sendContent.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入评论内容！"];
    }else {
        
        [[[HJAddCommentAPI addCommentWithInformationId:informationId content:sendContent] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
            HJAddCommentAPI *api = responseObject;
            if (api.code == 1) {
                [SVProgressHUD showSuccessWithStatus:@"评论成功!"];
                self.sendToolBar.sendText.text = nil;
                [self.sendToolBar.sendText resignFirstResponder];
                //
                //[self.webView reload];
                [self sendFinished];

            }
        }];
    }
}
- (void)sendFinished {
    
    HJUser *user = [HJUser sharedUser];
    
    NSString *userId = user.loginModel.userId;
    
    NSString *js = [NSString stringWithFormat:@"updateComment('%@','%@')",userId, self.informationId];
    [self.webView stringByEvaluatingJavaScriptFromString:js];
    
}
@end
