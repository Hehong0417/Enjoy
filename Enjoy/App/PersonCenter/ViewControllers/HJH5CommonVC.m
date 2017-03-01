//
//  HJBodyDataDetailVC.m
//  Enjoy
//
//  Created by IMAC on 16/4/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJH5CommonVC.h"
#import "HJUser.h"
#import "HJSurver.h"
#import "ChangeTarget.h"
#import "HJSendToolBar.h"
#import "HJAddCommentAPI.h"
#import "UMSocialSnsService.h"
#import "UMSocial.h"
#import "WaistHipView.h"
#import "HJaddWaistHipAPI.h"
#import "HJH5DetailWebViewVC.h"
#import "HJWaistHipListAPI.h"
#import "HJWaistCell.h"
#import "HJDeleteWaistHip.h"

@interface HJH5CommonVC ()<UIWebViewDelegate,UITextFieldDelegate,UMSocialUIDelegate,UITableViewDelegate,UITableViewDataSource>
{
    //btnType 1.调查问卷@"ic_c11_nav_01-1" 2.分享@"ic_c17_01-1" 3.录入围度@"ic_c19_01"
    NSInteger share;
    NSInteger btnType;
    NSString *reportDetailUrlStr;
    NSString *healthReportDetail;
}
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIButton *weightQTestBtn;
@property (nonatomic, strong) UIView *bGView;
@property (nonatomic, strong) UITableView *tabView;
@property (nonatomic, strong) NSMutableArray *waistHipArr;
@end

@implementation HJH5CommonVC
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.webView reload];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_h5_InterfaceType == HJArea_TiledType) {
        self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 114, kScreenWidth, kScreenHeight-114)];
        UIButton *waistBtn = [UIButton lh_buttonWithFrame:CGRectMake(kScreenWidth - 90, 74, 80, 30) target:self action:@selector(switchList:) image:kImageNamed(@"ic_c21_03")];
        [waistBtn setImage:kImageNamed(@"ic_c21_03") forState:UIControlStateNormal];
        [waistBtn setImage:kImageNamed(@"ic_c21_03_pre") forState:UIControlStateSelected];
        self.webView.hidden = NO;
        [self.view addSubview:waistBtn];
        //列表
        self.tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 114, kScreenWidth, kScreenHeight-114) style:UITableViewStyleGrouped];
        self.tabView.hidden = YES;
        self.tabView.delegate = self;
        self.tabView.dataSource = self;
        [self.tabView registerNib:[UINib nibWithNibName:@"HJWaistCell" bundle:nil] forCellReuseIdentifier:@"HJWaistCell"];
        [self.view addSubview:self.tabView];
        [self getWaistHipListData];
    }else if(_h5_InterfaceType == HJReport_detailsType){
        
        UIView *navView = [UIView lh_viewWithFrame:CGRectMake(0, 0, kScreenWidth, 64) backColor:APP_COMMON_COLOR];
        UIButton *leftBtn = [UIButton lh_buttonWithFrame:CGRectMake(20, 25, 30, 30) target:self action:@selector(backAct) image:kImageNamed(@"ic_nav_fanhui")];
        UILabel *titleLab = [UILabel lh_labelAdaptionWithFrame:CGRectMake(50, 30, kScreenWidth-100, 35) text:@"身体数据报告详细" textColor:kWhiteColor font:FONT(17) textAlignment:NSTextAlignmentCenter];
        UIButton *shareBtn = [UIButton lh_buttonWithFrame:CGRectMake(kScreenWidth-50, 25, 30, 30) target:self action:@selector(shareBtnAct) image:kImageNamed(@"ic_c17_01")];
        [navView addSubview:leftBtn];
        [navView addSubview:titleLab];
        [navView addSubview:shareBtn];
        [self.view addSubview:navView];
        self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    }else{
        self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    //设置底部按钮
    [self setBottomBtn];
    //设置标题
    [self setTitle];
    
    if (_h5_InterfaceType == HJHealthReportDetailsType) {
        UIButton *leftButton = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
        [leftButton bk_removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
        [leftButton addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
#pragma mark - 返回
-(void)pop{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

- (void)backAct {

    if (_backType == 100) {
        
        [self.navigationController popToRootVC];
        
    }else {
        
      [self.navigationController popVC];
        
    }
}

#pragma mark - 身体数据报告的分享

- (void)shareBtnAct {
    share = 1;
    [self  sharehealth];
}
#pragma mark - 获取围度数据
- (void)getWaistHipListData {
    [[[HJWaistHipListAPI getWaistHipListWithPage:@1 rows:@100 userType:self.userType puserId:self.purseId] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJWaistHipListAPI *api = responseObject;
        if (api.code ==1) {
            self.waistHipArr = api.data.waistHipList.mutableCopy;
            [self.tabView reloadData];
        }
    }];
    
}
#pragma mark - 切换按钮
- (void)switchList:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.selected) {
        self.tabView.hidden = NO;
        self.webView.hidden = YES;
    }else {
        self.tabView.hidden = YES;
        self.webView.hidden = NO;
        [self.webView reload];
    }
    
}
#pragma mark - 设置底部按钮
- (void)setBottomBtn {
    self.bGView = [UIView lh_viewWithFrame:CGRectMake(0, SCREEN_HEIGHT-65, SCREEN_WIDTH, 65) backColor:kVCBackGroundColor];
    self.weightQTestBtn = [UIButton lh_buttonWithFrame:CGRectMake(30, 15, SCREEN_WIDTH-65, 35) target:self action:@selector(ToSuver) title:@"填写健康问卷" titleColor:kWhiteColor font:FONT(14) backgroundColor:APP_COMMON_COLOR];
    [self.weightQTestBtn lh_setCornerRadius:5 borderWidth:0 borderColor:kClearColor];
    [self.bGView addSubview:self.weightQTestBtn];
    [self.view addSubview:self.bGView];
    
    if (self.h5_InterfaceType == HJReport_detailsType) {
        if (self.BtnIsShow) {
            self.bGView.hidden = NO;
            self.weightQTestBtn.hidden = NO;
            [self.weightQTestBtn setTitle:@"填写健康问卷" forState:UIControlStateNormal];
            [self setWebViewFrameAgain];
        }else {
            self.bGView.hidden = YES;
            self.weightQTestBtn.hidden = YES;
            //加分享按钮
            [self addRightBtn];
            btnType = 2;
            //
        }
    }else if(self.h5_InterfaceType == HJHealthReportDetailsType){
        
        if (self.BtnIsShow) {
            self.bGView.hidden = NO;
            self.weightQTestBtn.hidden = NO;
            [self.weightQTestBtn setTitle:@"定制个人瘦身计划" forState:UIControlStateNormal];
           // [self setWebViewFrameAgain];
        }else {
            self.bGView.hidden = YES;
            self.weightQTestBtn.hidden = YES;
            //加分享按钮
            [self addRightBtn];
            btnType = 2;
        }
    }else {
        self.bGView.hidden = YES;
        self.weightQTestBtn.hidden = YES;
    }

}

#pragma mark - 进入健康问卷
- (void)ToSuver {
    //
    if(self.h5_InterfaceType == HJHealthReportDetailsType){
        [self.navigationController pushVC:[ChangeTarget new]];
    }else if(self.h5_InterfaceType == HJReport_detailsType){
        //调查问卷
        HJSurver *vc = [HJSurver new];
        [self.navigationController pushVC:vc];
    }
   
}
#pragma mark - 设置标题
- (void)setTitle {
    switch (self.h5_InterfaceType) {
        case HJManager_NoteType:{
            switch (self.manage_type) {
                case HJManage_Note:{
                    self.title = @"管理师手记";
                }
                    break;
                case HJPublic_Class:{
                    self.title = @"瘦身公开课";
                }
                    break;
                case HJThinBible:{
                    self.title = @"瘦身宝典";
                }
                    break;
                default:
                    break;
            }
           //拼接参数columnId
            NSDictionary *pramesDic = @{@"columnId":self.columnId};
            
            NSString *urlStr = [Manager_Note_url  lh_subUrlAddParameters:pramesDic];
            
            [self webViewLoadRequestWithUrlStr:urlStr];
        }
            break;
        case HJDiet_IndexType:{
            
            self.title = @"减肥记录";
            
            //拼接参数bigTime
            NSMutableDictionary *pramesDic = [NSMutableDictionary dictionary];
            if (self.bigTime) {
                [pramesDic setObject:self.bigTime forKey:@"bigTime"];
            }
            NSString *urlStr = [Index_url  lh_subUrlAddParameters:pramesDic];
            
            [self webViewLoadRequestWithUrlStr:urlStr];

        }
            break;
        case HJReport_detailsType:{
            
            self.title = @"身体数据报告详细";

            self.hiddenNavigation = YES;
            
            //拼接参数bodyReportId & userId &
            NSDictionary *pramesDic = @{@"bodyReportId":self.bodyReportId, @"userId":self.userId,@"userType":self.bodyUserType};
            
            reportDetailUrlStr = [NSString lh_subUrlString:Report_Details_url appendingParameters:pramesDic];
            
            [self webViewLoadRequestWithUrlStr:reportDetailUrlStr];
        }
            break;
        case HJArea_TiledType:{
            
            self.title = @"围度";
            
            //拼接参数bodyReportId
            
            NSDictionary *pramesDic = @{@"puserId":self.purseId,@"userType":self.userType};
            
            NSString *urlStr = [Area_Tiled_url  lh_subUrlAddParameters:pramesDic];
            //
            [self webViewLoadRequestWithUrlStr:urlStr];
            //添加录入围度按钮
            [self addRightBtn];
            btnType = 3;
            
        }
            break;
        case HJHealthReportDetailsType:{
            
            self.title = @"健康报告详细";
            //拼接参数healthReportId
            NSDictionary *pramesDic = @{@"healthReportId":self.healthReportId};
            healthReportDetail = [HealthReportDetails_url  lh_subUrlAddParameters:pramesDic];

            [self webViewLoadRequestWithUrlStr:healthReportDetail];
            
        }
            break;
        case HJDiet_DiaryType:{
            
            self.title = @"减肥日记";
            
            NSString *urlStr = [Diet_Diary_url  lh_h5UrlStringAddUserIDAndToken];
            
            [self webViewLoadRequestWithUrlStr:urlStr];
        }
            break;
        case HJOnline_MessageType:{
            self.title = @"在线留言";
            
            //拼接参数wteacherId
            NSDictionary *pramesDic = @{@"wteacherId":self.wteacherId};
            NSString *urlStr = [Online_Message_url  lh_subUrlAddParameters:pramesDic];
            
            [self webViewLoadRequestWithUrlStr:urlStr];
        }
            break;
        case HJHealthQTestType:{
            
            self.title = @"调查问卷";
            
            NSString *urlStr = HealthQTest_url;

            [self webViewLoadRequestWithUrlStr:urlStr];

        }
            break;
            
        default:
            break;
    }
}

#pragma mark - webView加载Request
- (void)webViewLoadRequestWithUrlStr:(NSString *)urlStr {
    
    NSLog(@"urlStr-%@",urlStr);
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:urlStr]];
    
    [self.webView loadRequest:request];
    
}
#pragma mark - 分享
- (void)sharehealth
{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"5734593e67e58e9f27003459" shareText:@"好享瘦分享~" shareImage:[UIImage imageNamed:@"ic_logo"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession, UMShareToWechatTimeline, UMShareToQQ, UMShareToQzone, nil] delegate:self];

    if (share == 2) {
        
        [UMSocialData defaultData].extConfig.wechatSessionData.url = healthReportDetail;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = healthReportDetail;
        [UMSocialData defaultData].extConfig.qqData.url = healthReportDetail;
        [UMSocialData defaultData].extConfig.qzoneData.url = healthReportDetail;
        
    }else if(share == 1){
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = reportDetailUrlStr;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = reportDetailUrlStr;
    [UMSocialData defaultData].extConfig.qqData.url = reportDetailUrlStr;
    [UMSocialData defaultData].extConfig.qzoneData.url = reportDetailUrlStr;
        
    }
}

#pragma mark - webViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSURL *url = [request URL];
    NSString *urlStr = url.absoluteString;
    
    DDLogInfo(@"url = %@",urlStr);
    
    if(self.h5_InterfaceType == HJManager_NoteType){
        if ([urlStr containsString:@"manage_note_details.html"]) {
            //获取url中的字段
            NSDictionary *prames = [urlStr lh_parametersKeyValue];
            NSString *informationId = [prames objectForKey:@"informationId"];
            HJH5DetailWebViewVC *detailVC = [[HJH5DetailWebViewVC alloc]init];
            detailVC.informationId = informationId;
            [self.navigationController pushVC:detailVC];
            
            return NO;
        }
    }
          return YES;
}

#pragma mark - ---调查问卷&&分享&&录入围度---

//btnType 1.调查问卷@"ic_c11_nav_01-1" 2.分享@"ic_c17_01-1" 3.录入围度@"ic_c19_01"
- (void)addRightBtn{
    
    NSString *imgName;
    if (btnType == 1) {
        imgName = @"ic_c11_nav_01-1";
        
    }else if(btnType == 2){
        imgName = @"ic_c17_01";
        
    }else {
        imgName = @"ic_c21_01";
    }
    
    if (_h5_InterfaceType == HJHealthReportDetailsType) {
        imgName = @"ic_c17_01";
    }
    
    UIButton *rightBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 30, 30) target:self action:@selector(rightBtnAct) image:[UIImage imageNamed:imgName]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}
-(void)rightBtnAct{
    
    if (btnType == 1) {
        //调查问卷
        HJSurver *vc = [HJSurver new];
        [self.navigationController pushVC:vc];
        
    }else if(btnType == 2){
        //分享
        share = 2;
        [self sharehealth];

    }else {
        //录入围度（弹框）
        [self waistViewShow];
    }
}
#pragma mark - 录入围度
- (void)waistViewShow {
    
    WaistHipView *waistView = [WaistHipView initWaistHipViewXib];
    waistView.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
    [[UIApplication sharedApplication].keyWindow addSubview:waistView];
    waistView.waistBlock2 = ^(NSString *waistline,NSString *hipline){
        //录入腰围、臀围
        [[[HJaddWaistHipAPI addWaistHipWithUserId:self.purseId token:nil puserId:self.purseId waistline:waistline hipline:hipline userType:self.userType] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
            HJaddWaistHipAPI *api = responseObject;
            if (api.code == 1) {
                [SVProgressHUD showSuccessWithStatus:@"录入成功"];
                [self.webView reload];
                [self getWaistHipListData];
            }
        }];
        
    };
    
}
#pragma mark -设置WebView的frame
- (void)setWebViewFrameAgain {
    
    self.webView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-49);
    
}
#pragma mark - 删除围度
- (void)deleteWaistHipWithModel:(WaistHipListModel *)model {
    
    NSString *waistArrStr = [NSString stringWithFormat:@"%ld",model.Id];
    [[[HJDeleteWaistHip deleteWaistHipWithWaistHipIdArray:waistArrStr] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJDeleteWaistHip *api = responseObject;
        if (api.code == 1) {
            [self getWaistHipListData];
        }
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HJWaistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HJWaistCell"];
   WaistHipListModel *model = self.waistHipArr[indexPath.row];
    cell.waistHipModel = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    WaistHipListModel *model = self.waistHipArr[indexPath.row];
    [self.waistHipArr removeObjectAtIndex:indexPath.row];
    [self deleteWaistHipWithModel:model];
    [tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.waistHipArr.count;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}


@end
