//
//  FoodClass.m
//  Enjoy
//
//  Created by IMAC on 16/3/18.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "FoodClass.h"
#import "FoodHistorySearchViewController.h"
#import "HJFoodListAPI.h"
#import "HJFoodDetailTVC.h"
#import "HJSportListAPI.h"
#import "HJFoodCell.h"
#import "RecordTimeView.h"
#import "HJAddSportRecordAPI.h"
#import "HJAddFoodRecordAPI.h"
#import "HJSportDetailTVC.h"
#import "MoveMomentVC.h"
@interface FoodClass ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource, HJFoodCellDelegate>
@property (nonatomic, strong) NSMutableArray *foodList;
@property (nonatomic, strong) NSMutableArray *sportList;
@property (strong, nonatomic) IBOutlet UITableView *tabView;

@end

@implementation FoodClass

-(void)doSomeThingInViewDidLoad{

    UISearchBar *seach = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, kDeviceWidth, 44)];
    switch (self.ClassType) {
        case HJFoodType:{
            self.title = self.foodName;
            seach.placeholder = @"请输入食物名称";
            [self getFoodListData];
        }
            break;
        case HJSportType:
            self.title = self.sportName;
            seach.placeholder = @"请输入运动名称";
            [self getSportListData];
        default:
            break;
    }
    seach.delegate = self;
    [self.view addSubview:seach];
    
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
#pragma mark---------netWorkingRequest------------

- (void)getFoodListData {
    
    [self.foodList removeAllObjects];
    [[[HJFoodListAPI getFoodListWithfoodName:nil foodCategoryId:[NSNumber numberWithInteger:self.foodCategoryId] page:@1 rows:@100] netWorkClient] postRequestInView:self.view networkCodeTypeSuccessBlock:^(id responseObject) {
        HJFoodListAPI *api = responseObject;
        if (api.code == 1) {
            self.foodList = api.data.foodList.mutableCopy;
            [self.tabView reloadData];
        }
    }];
}

-(void)getSportListData {
    [[[HJSportListAPI getSportListWithSportName:nil sportCategoryId:[NSNumber numberWithInteger:self.sportCategoryId] page:@1 rows:@100] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJSportListAPI *api = responseObject;
        if (api.code == 1) {
        self.sportList = api.data.sportList.mutableCopy;
        [self.tabView reloadData];
        }
    }];
}

#pragma mark---------HJFoodCellDelegate------------
- (void)foodCellClickRecordButton:(HJFoodCell *)cell
{
    RecordTimeView *recordView = [RecordTimeView initRecordTimeViewXib];
    recordView.frame = self.view.frame;
    recordView.foodModel = cell.foodModel;
    [self.view addSubview:recordView];
    [recordView returnText:^(NSString *titleText) {
        if ([titleText isEqualToString:@""]) {
            [SVProgressHUD showInfoWithStatus:@"请输入食物重量!"];
            return ;
        }
        [[[HJAddFoodRecordAPI addFoodRecordWtihFoodId:[NSNumber numberWithInteger:cell.foodModel.Id] quantity:[NSNumber numberWithString:titleText] eatType:self.eatType] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
            [recordView removeFromSuperview];
            [self.navigationController popToRootVC];
        }];
    }];
}

- (void)sportCellClickRecordButton:(HJFoodCell *)cell
{
    RecordTimeView *recordView = [RecordTimeView initRecordTimeViewXib];
    recordView.frame = self.view.frame;
    recordView.sportModel = cell.sportModel;
    [self.view addSubview:recordView];
    [recordView returnText:^(NSString *titleText) {
        if ([titleText isEqualToString:@""]) {
            [SVProgressHUD showInfoWithStatus:@"请输入运动时间!"];
            return ;
        }
        [[[HJAddSportRecordAPI addSportRecordWithSportId:[NSNumber numberWithInteger:cell.sportModel.Id] continueTime:[NSNumber numberWithString:titleText]] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
            [recordView removeFromSuperview];
            UIViewController *MoveMomentVC = self.navigationController.viewControllers[1];
            [self.navigationController popToVC:MoveMomentVC];
        }];
    }];
}

#pragma mark---------UITableViewDelegate------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.sportCategoryId ? self.sportList.count : self.foodList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HJFoodCell *cell = [HJFoodCell CellWithTableView:tableView];
    cell.delegate = self;
    switch (self.ClassType) {
        case HJFoodType: {
            HJFoodModel *model = self.foodList[indexPath.row];
            cell.foodModel = model;
        }
            break;
        case HJSportType: {
            HJSportModel *model = self.sportList[indexPath.row];
            cell.sportModel = model;
        }
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.ClassType) {
        case HJSportType: {
            HJSportModel *model = self.sportList[indexPath.row];
            HJSportDetailTVC *VC = [[HJSportDetailTVC alloc] init];
            VC.sportId = [NSNumber numberWithInteger:model.Id];
            VC.sportCategoryId = model.sportCategoryId;
            [self.navigationController pushVC:VC];
        }
            break;
        case HJFoodType: {
            HJFoodModel *model = self.foodList[indexPath.row];
            HJFoodDetailTVC *detailVC = [HJFoodDetailTVC new];
            detailVC.foodId = [NSNumber numberWithInteger:model.Id];
            [self.navigationController pushVC:detailVC];
        }
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    switch (self.ClassType) {
        case HJFoodType: {
            FoodHistorySearchViewController *vc = [[FoodHistorySearchViewController alloc] init];
            vc.foodCategoryId = self.foodCategoryId;
            vc.eatType = self.eatType;
            [self.navigationController pushVC:vc];
        }
            break;
        case HJSportType: {
            FoodHistorySearchViewController *vc = [[FoodHistorySearchViewController alloc] init];
            vc.sportCategoryId = self.sportCategoryId;
            [self.navigationController pushVC:vc];
        }
        default:
            break;
    }
    return NO;
}

#pragma mark---------Actions------------
@end
