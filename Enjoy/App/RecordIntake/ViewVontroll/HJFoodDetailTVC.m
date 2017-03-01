//
//  HJFoodDetailTVC.m
//  Enjoy
//
//  Created by IMAC on 16/4/26.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJFoodDetailTVC.h"
#import "HJFoodDetailAPI.h"
#import "HJFoodDetailHeaderView.h"
#import "HJFoodDetailCell.h"
#import "HJFoodDetailOneCell.h"

@interface HJFoodDetailTVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) HJFoodDetailModel *foodDetailModel;
@property (nonatomic, strong) UITableView *tabView;
@property (nonatomic, weak) HJFoodDetailHeaderView *headerView;
@end

@implementation HJFoodDetailTVC
#pragma mark - HJViewControllerProtocol
- (void)loadView {
    self.view = [UIView lh_viewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) backColor:kClearColor];
    self.tabView = [UITableView lh_tableViewWithFrame:CGRectMake(0,-20, kScreenWidth, kScreenHeight+20) tableViewStyle:UITableViewStyleGrouped delegate:self dataSourec:self];
    self.tabView.backgroundColor = kVCBackGroundColor;
    [self.view addSubview:self.tabView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = YES;
}

- (void)doSomeThingInViewDidLoad {
    [self getDetailData];
    
    [self setupHeaderViewAndBackButton];
}

#pragma mark - Actions
- (void)backAct{
    [self.navigationController popVC];
}

- (void)setupHeaderViewAndBackButton
{
    HJFoodDetailHeaderView *headerView = [HJFoodDetailHeaderView foodDetailHeaderView];
    self.headerView = headerView;
    self.tabView.tableHeaderView = headerView;
    
    UIButton *leftBtn = [UIButton lh_buttonWithFrame:CGRectMake(10, 30, 50, 50) target:self action:@selector(backAct) image:kImageNamed(@"ic_b12_fanhui")];
    [self.view addSubview:leftBtn];
}

#pragma mark - Methods
- (void)getDetailData {
    //食物详情
    [[[HJFoodDetailAPI getFoodDetailWithfoodId:self.foodId] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJFoodDetailAPI *api = responseObject;
        if (api.code == 1) {
            self.foodDetailModel = api.data;
            self.headerView.foodmodel = self.foodDetailModel;
            [self.tabView reloadData];
        }
    }];
}

- (UIView *)setupHeaderViewInSectionWithTitle:(NSString *)title
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = kWhiteColor;
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    UILabel *introduceLabel = [UILabel lh_labelWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40, 44) text:title textColor:RGB(150, 150, 150) font:FONT(15) textAlignment:NSTextAlignmentLeft backgroundColor:kWhiteColor];
    [headerView addSubview:introduceLabel];
    return headerView;
}

- (UIView *)setupHeaderViewInSectionWithLeftTitle:(NSString *)leftTitle centerTitle2:(NSString *)centerTitle rightTitle3:(NSString *)rightTitle
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = kWhiteColor;
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    UILabel *introduceLabel1 = [UILabel lh_labelWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40, 44) text:leftTitle textColor:RGB(150, 150, 150) font:FONT(15) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    UILabel *introduceLabel2 = [UILabel lh_labelWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40, 44) text:centerTitle textColor:RGB(150, 150, 150) font:FONT(15) textAlignment:NSTextAlignmentCenter backgroundColor:kClearColor];
    UILabel *introduceLabel3 = [UILabel lh_labelWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40, 44) text:rightTitle textColor:RGB(150, 150, 150) font:FONT(15) textAlignment:NSTextAlignmentRight backgroundColor:kClearColor];
    [headerView addSubview:introduceLabel1];
    [headerView addSubview:introduceLabel2];
    [headerView addSubview:introduceLabel3];
    return headerView;
}


#pragma mark ----UITableViewDelegate,UITableViewDataSource-----
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0: {
            HJFoodDetailOneCell *cell = [HJFoodDetailOneCell cellWithTableView:tableView];
            cell.foodDetailModel = self.foodDetailModel;
            return cell;
        }
            break;
        case 1: {
//            if (indexPath.row == 2) {
//                
//            }
            HJFoodDetailCell *cell = [HJFoodDetailCell cellWithTableView:tableView];
            HJFoodCaloryListModel *model = self.foodDetailModel.foodCaloryList[indexPath.row];
            cell.foodCaloryModel = model;
            return cell;
        }
            break;
        default: {
            HJFoodDetailCell *cell = [HJFoodDetailCell cellWithTableView:tableView];
            HJFoodNutritionListModel *model = self.foodDetailModel.foodNutritionList[indexPath.row];
            cell.foodNutritionModel = model;
            return cell;
        }
            break;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return self.foodDetailModel.foodCaloryList.count;
            break;
        case 2:
            return self.foodDetailModel.foodNutritionList.count;
            break;
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0: {
            UIView *headerView = [self setupHeaderViewInSectionWithTitle:@"食物简介"];
            return headerView;
        }
            break;
        case 1: {
            UIView *headerView = [self setupHeaderViewInSectionWithTitle:@"所含热量"];
            return headerView;
        }
            break;
        case 2: {
            UIView *headerView = [self setupHeaderViewInSectionWithLeftTitle:@"营养元素" centerTitle2:@"每100克" rightTitle3:@"备注"];
            return headerView;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return indexPath.section == 0 ? cell.frame.size.height : 44;
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
