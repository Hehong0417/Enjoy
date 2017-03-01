//
//  HJSportDetailTVC.m
//  Enjoy
//
//  Created by 邓朝文 on 16/5/4.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSportDetailTVC.h"
#import "HJSportListAPI.h"
#import "HJSportDetailAPI.h"
#import "HJFoodDetailHeaderView.h"
#import "HJSportIntroduceCell.h"

@interface HJSportDetailTVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) HJSportDetailModel *sportDetailModel;
@property (nonatomic, strong) UITableView *tabView;
@property (nonatomic, weak) HJFoodDetailHeaderView *headerView;

@end

@implementation HJSportDetailTVC


- (void)loadView {
    self.view = [UIView lh_viewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) backColor:kWhiteColor];
    self.tabView = [UITableView lh_tableViewWithFrame:CGRectMake(0,-20, kScreenWidth, kScreenHeight+20) tableViewStyle:UITableViewStyleGrouped delegate:self dataSourec:self];
    self.tabView.backgroundColor = kWhiteColor;
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tabView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = YES;
}

- (void)doSomeThingInViewDidLoad {
    UIButton *leftBtn = [UIButton lh_buttonWithFrame:CGRectMake(10, 30, 50, 50) target:self action:@selector(backAct) image:kImageNamed(@"ic_b12_fanhui")];
    [self.view addSubview:leftBtn];

    HJFoodDetailHeaderView *headerView = [HJFoodDetailHeaderView foodDetailHeaderView];
    self.headerView = headerView;
    self.tabView.tableHeaderView = headerView;
    
    [self getDetailData];
}

- (void)getDetailData
{
    [[[HJSportDetailAPI getSportDetailWithSportName:nil sportCategoryId:self.sportCategoryId pageNo:@1 pageSize:@30 Id:self.sportId] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJSportDetailAPI *api = responseObject;
        if (api.code == 1) {
            self.sportDetailModel = api.data;
            self.headerView.sportModel = self.sportDetailModel.sport;
            [self.tabView reloadData];
        }
    }];
}

- (void)backAct
{
    [self.navigationController popVC];
}

- (UIView *)setupHeaderViewInSectionWithTitle:(NSString *)title
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = kWhiteColor;
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    UILabel *introduceLabel = [UILabel lh_labelWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40, 44) text:title textColor:RGB(150, 150, 150) font:FONT(17) textAlignment:NSTextAlignmentLeft backgroundColor:kWhiteColor];
    [headerView addSubview:introduceLabel];
    return headerView;
}

#pragma mark ------UITableViewDataSource,UITableViewDelegate----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HJSportIntroduceCell *cell = [HJSportIntroduceCell cellWithTableView:tableView];
    cell.sportMedel = self.sportDetailModel.sport;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [self setupHeaderViewInSectionWithTitle:@"运动简介"];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
