//
//  HJIncrementServiceVC.m
//  Enjoy
//
//  Created by zhipeng-mac on 16/2/25.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJIncrementServiceVC.h"
#import "WMBannerView.h"
#import "ManagerNoteVC.h"
#import "WeightManagementVC.h"
#import "HJAddServiceHomeAPI.h"
#import "HJH5CommonVC.h"
#import "HJH5DetailWebViewVC.h"
#import "HJGetInfomationNewCountAPI.h"
#import "HJUser.h"
#import "HJNeswCell.h"
#import "HJIncrementCustomTVC.h"
@interface HJIncrementServiceVC ()<UITableViewDataSource,UITableViewDelegate>
{
    WMBannerView *wmView    ;
    UITableView  *showTabael;
}
@property (nonatomic, strong) HJAddServiceHomeModel *serviceHomeModel;
@property (nonatomic, strong) NSArray *bannerList;
@property (nonatomic, strong) NSArray *columnList;
@property (nonatomic, strong) NSArray *informationList;
@property (nonatomic, strong) NSArray *bannerImageArray;
@end

@implementation HJIncrementServiceVC

#pragma mark - HJViewControllerProtocol

- (NSArray *)bannerImageArray
{
    if (!_bannerImageArray) {
        _bannerImageArray = [NSArray array];
    }
    return _bannerImageArray;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"增值服务";
    self.navigationItem.leftBarButtonItem=nil;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 添加广告
    [self addBannerView];
    
    // 添加资讯控件
    [self addShowTabael];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 请求数据
    [self getIncrementServiceHome];
    
    [self setTabBarItem];
}

- (void)setTabBarItem
{
    HJTabBarController *tabBarController = (HJTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    HJNavigationController *nvc = tabBarController.childViewControllers[1];
    UIViewController *vc = nvc.childViewControllers.firstObject;
    [vc.tabBarItem setImage:[[UIImage imageNamed:@"ic_a33_14"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

- (void)addBannerView
{
    [wmView removeFromSuperview];
    wmView = [[WMBannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*2.5/5) withURLArrayOrImagesArray:self.bannerImageArray];
    wmView.pageControlAlignment = WMPageContolAlignmentCenter;
//    wmView.placeHoldImage = [UIImage imageNamed:@"head"];
    wmView.animationDuration = 3.0;
    [wmView startWithTapActionBlock:^(NSInteger index) {
        NSLog(@"点击了第%@张",@(index));
        HJH5DetailWebViewVC *detailVC = [[HJH5DetailWebViewVC alloc]init];
        HJBannerList *BannerList = self.bannerList[index];
        detailVC.informationId = [NSString stringWithFormat:@"%ld",BannerList.informationId];
        [self.navigationController pushVC:detailVC];
    }];
    showTabael.tableHeaderView = wmView;
}

- (void)addShowTabael
{
    showTabael = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kDeviceWidth, KDeviceHeight-49-64) style:(UITableViewStyleGrouped)];
    showTabael.dataSource = self;
    showTabael.delegate = self;
    showTabael.showsVerticalScrollIndicator = NO;
    showTabael.tableHeaderView = wmView;
    [self.view addSubview:showTabael];
}

/**
 *  请求服务器数据
 */
- (void)getIncrementServiceHome
{
    [[[HJAddServiceHomeAPI getAddServiceHomeWithBannerQuantity:@10 infoQuantity:@10] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJAddServiceHomeAPI *api = responseObject;
        if (api.code == 1) {
        self.serviceHomeModel = api.data;
        self.bannerList = api.data.bannerList;
        self.columnList = api.data.columnList;
        // 更新界面
        [self refreshView];
        }
    }];
}

- (void)refreshView
{
    NSMutableArray *array = [NSMutableArray array];
    for (HJBannerList *bannerList in self.bannerList) {
        [array addObject:kAPIImageFromUrl(bannerList.ico)];
    }
    self.bannerImageArray = array;
    [self addBannerView];
    [showTabael reloadData];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.columnList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HJcolumnList *columnList = self.columnList[section];
    return columnList.informationList.count < 3 ? columnList.informationList.count + 1 : 3;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HJcolumnList *columList = self.columnList[indexPath.section];
    HJNeswCell *cell = [HJNeswCell cellWithTableView:tableView];
    if (indexPath.row < 2) {
        HJInformationList *informationList = columList.informationList[indexPath.row];
        cell.inforMationmodel = informationList;
    } else {
        cell.columnModel = columList;
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *View = [[UIView alloc]init];
    View.userInteractionEnabled = YES;
    UIImageView *ima = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, kDeviceWidth - 20, 150)];
    ima.userInteractionEnabled = YES;
    HJcolumnList *columnList = self.columnList[section];
    [ima sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(columnList.file)] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    ima.tag = section+888;
    if (section == 0) {
        //咨询体重师
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, kDeviceWidth-20, 90)];
        imageView.userInteractionEnabled = YES;
        imageView.image = kImageNamed(@"ic_b1_bg");
        //跳转咨询体重师手势
        UITapGestureRecognizer *tap1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(consult)];
        [imageView addGestureRecognizer:tap1];
        [View addSubview:imageView];
        
        /**管理师手记*/
        ima.frame = CGRectMake(10,CGRectGetMaxY(imageView.frame) + 10, kDeviceWidth - 20, 150);
    }
    UITapGestureRecognizer *tap2 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(managerNote:)];
    [ima addGestureRecognizer:tap2];
    [View addSubview:ima];

    return View;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HJcolumnList *columList = self.columnList[indexPath.section];
    if (indexPath.row < 2) {
        HJInformationList *informationList = columList.informationList[indexPath.row];
        HJH5DetailWebViewVC *detailVC = [[HJH5DetailWebViewVC alloc]init];
        detailVC.informationId = [NSString stringWithFormat:@"%ld",informationList.Id];
        [self.navigationController pushVC:detailVC];

    }else if(indexPath.row == 2){
//        HJH5CommonVC *h5commonVC = [[HJH5CommonVC alloc]init];
//        h5commonVC.h5_InterfaceType = HJManager_NoteType;
        HJIncrementCustomTVC *increCustomVC = [HJIncrementCustomTVC new];
        
        if (indexPath.section == 0) {
            increCustomVC.incrementType = HJManage_Note_Incre;
            increCustomVC.columnId = [NSString stringWithFormat:@"%ld",columList.Id];
        }else if(indexPath.section == 1){
            increCustomVC.incrementType = HJPublic_Class_Incre;
            increCustomVC.columnId = [NSString stringWithFormat:@"%ld",columList.Id];
        }else {
            increCustomVC.incrementType = HJThinBible_Incre;
            increCustomVC.columnId = [NSString stringWithFormat:@"%ld",columList.Id];
        }
        [self.navigationController pushVC:increCustomVC];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 270;
    }
    return 155;
}

#pragma mark----跳转咨询体重师------
-(void)consult{
    NSLog(@"跳转体重咨询师");
    WeightManagementVC *weightManagerVC = [WeightManagementVC new];
    HJUser *user = [HJUser read];
    weightManagerVC.puserId = [NSNumber numberWithString:user.loginModel.userId];
    weightManagerVC.consantType = IncreceService_Type;
    [self.navigationController pushVC:weightManagerVC];
}

#pragma mark-----管理师手记---------
-(void)managerNote:(UITapGestureRecognizer *)tap{
    NSLog(@"管理师手记");

    NSInteger section = tap.view.tag-888;
    HJcolumnList *columnList = self.columnList[section];
    NSLog(@"%ld",columnList.Id);
    HJIncrementCustomTVC *incrementVC = [[HJIncrementCustomTVC alloc]init];
    incrementVC.columnId = [NSString stringWithFormat:@"%ld",columnList.Id];
    
    if (section == 0) {
        incrementVC.incrementType = HJManage_Note_Incre;
    }else if(section == 1){
        incrementVC.incrementType = HJPublic_Class_Incre;
    }else {
        incrementVC.incrementType = HJThinBible_Incre;
    }
    [self.navigationController pushVC:incrementVC];
}

@end
