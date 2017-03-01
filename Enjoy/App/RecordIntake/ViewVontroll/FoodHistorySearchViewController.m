//
//  FoodHistorySearchViewController.m
//  Enjoy
//
//  Created by IMAC on 16/3/31.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "FoodHistorySearchViewController.h"
#import "HJFoodListAPI.h"
#import "HJFoodDetailTVC.h"
#import "HJSportDetailTVC.h"
#import "HJAddFoodRecordAPI.h"
#import "HJFoodCell.h"
#import "HJSportListAPI.h"
#import "RecordTimeView.h"
#import "HJAddSportRecordAPI.h"
#import "HJSlimmingPlanVC.h"
#import "MoveMomentVC.h"

@interface FoodHistorySearchViewController ()<UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate, HJFoodCellDelegate>
{
    UITableView *mainTable;
}
@property (nonatomic, weak) UISearchBar *seach;
@property (nonatomic, strong) NSMutableArray *seachFoodArray;
@property (nonatomic, strong) NSMutableArray *seachSportArray;
@property (nonatomic, strong) NSArray *foodList;
@property (nonatomic, strong) NSArray *sportList;
@end

@implementation FoodHistorySearchViewController

- (NSMutableArray *)seachFoodArray
{
    if (!_seachFoodArray) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *array = (NSMutableArray *)[defaults valueForKey:@"seachFoodArray"];
        if (array.count != 0) {
            _seachFoodArray = [NSMutableArray arrayWithArray:array];
        } else {
            _seachFoodArray = [NSMutableArray array];
        }
    }
    return _seachFoodArray;
}

- (NSMutableArray *)seachSportArray
{
    if (!_seachSportArray) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *array = (NSMutableArray *)[defaults valueForKey:@"seachSportArray"];
        if (array.count) {
            _seachSportArray = [NSMutableArray arrayWithArray:array];
        } else {
            _seachSportArray = [NSMutableArray array];
        }
    }
    return _seachSportArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addSeachBarAndSeachButton];
    
    [self setupTableView];
}

/**
 *  初始化搜索条
 */
- (void)addSeachBarAndSeachButton
{
    UISearchBar *seach = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    seach.delegate = self;
    self.seach = seach;
    
    if (self.foodCategoryId) {
        seach.placeholder = @"输入食物名称";
    } else {
        seach.placeholder = @"输入运动名称";
    }
    self.navigationItem.titleView = seach;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"搜索" forState:(UIControlStateNormal)];
    button.frame = CGRectMake(0, 0, 40, 20);
    button.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
    [button addTarget:self action:@selector(clickSeach) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

/**
 *  初始化tableView
 */
- (void)setupTableView
{
    mainTable = [[UITableView alloc]
                 initWithFrame:CGRectMake(0, 0, LH_ScreenWidth, LH_ScreenHeight) style:(UITableViewStyleGrouped)];
    mainTable.dataSource = self;
    mainTable.delegate = self;
    mainTable.separatorStyle = UITableViewCellSelectionStyleNone;
    mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:mainTable];
}

/**
 *  清除搜索记录
 */
- (void)deleteSeachHistory:(UIButton *)button
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (self.foodCategoryId) {
        [self.seachFoodArray removeAllObjects];
        [defaults setObject:self.seachFoodArray forKey:@"seachFoodArray"];
    } else {
        [self.seachSportArray removeAllObjects];
        [defaults setObject:self.seachSportArray forKey:@"seachSportArray"];
    }
    [defaults synchronize];
    [mainTable reloadData];
}

/**
 *  点击搜索按钮搜索
 */
- (void)clickSeach
{
    [self.navigationController.view  endEditing:YES];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (self.foodCategoryId) {
        if (![self.seachFoodArray containsObject:self.seach.text]) {
            [self.seachFoodArray insertObject:self.seach.text atIndex:0];
        };
        [defaults setObject:self.seachFoodArray forKey:@"seachFoodArray"];
        [self getSeachFoodResultWtihText:self.seach.text];
    } else {
        if (![self.seachSportArray containsObject:self.seach.text]) {
            [self.seachSportArray insertObject:self.seach.text atIndex:0];
        }
        [defaults setObject:self.seachSportArray forKey:@"seachSportArray"];
        [self getSeachSportResultWtihText:self.seach.text];
    }
    [defaults synchronize];
}

/**
 *  获得运动搜索结果
 */
- (void)getSeachSportResultWtihText:(NSString *)text
{
    [[[HJSportListAPI getSportListWithSportName:text sportCategoryId:[NSNumber numberWithInteger:self.sportCategoryId] page:@1 rows:@100] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
        HJSportListAPI *api = responseObject;
        self.sportList = api.data.sportList;
        if (self.sportList.count == 0) {
            [SVProgressHUD showInfoWithStatus:@"没有您要搜索的结果..."];
        }
        [mainTable reloadData];
    }];
}

/**
 *  获得食物搜索结果
 */
- (void)getSeachFoodResultWtihText:(NSString *)text
{
    [[[HJFoodListAPI getFoodListWithfoodName:text foodCategoryId:[NSNumber numberWithInteger:self.foodCategoryId] page:@1 rows:@100] netWorkClient] postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
        HJFoodListAPI *api = responseObject;
        if (api.code == 1) {
        self.foodList = api.data.foodList;
        if (self.foodList.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"没有您要搜索的结果..."];
        }
        [mainTable reloadData];
        }
    }];
}

#pragma mark-------HJFoodCellDelegate--------
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
        [[[HJAddFoodRecordAPI addFoodRecordWtihFoodId:[NSNumber numberWithInteger:cell.foodModel.Id] quantity:[NSNumber numberWithString:titleText] eatType:@4] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
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

#pragma mark-------UITableViewDataSource--------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.foodCategoryId) {
        NSInteger historyCount = (self.seachFoodArray.count > 8 ? 8 : self.seachFoodArray.count);
        return self.foodList.count ? self.foodList.count : historyCount;
    } else {
        NSInteger historyCount = (self.seachSportArray.count > 8 ? 10 : self.seachSportArray.count);
        return self.sportList.count ? self.sportList.count : historyCount;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.foodCategoryId) {
        if (self.foodList.count == 0) {
            mainTable.separatorStyle = UITableViewCellSelectionStyleBlue;
            static NSString *str = @"seachTextCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:str];
            }
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.text = self.seachFoodArray[indexPath.row];
            return cell;
        } else {
            HJFoodCell *cell = [HJFoodCell CellWithTableView:tableView];
            HJFoodModel *model = self.foodList[indexPath.row];
            cell.foodModel = model;
            cell.delegate = self;
            return cell;
        }
    } else {
        if (self.sportList.count == 0) {
            mainTable.separatorStyle = UITableViewCellSelectionStyleBlue;
            static NSString *str = @"cell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:str];
            }
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.text = self.seachSportArray[indexPath.row];
            return cell;
        } else {
            HJFoodCell *cell = [HJFoodCell CellWithTableView:tableView];
            HJSportModel *model = self.sportList[indexPath.row];
            cell.sportModel = model;
            cell.delegate = self;
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.foodList.count) {
        HJFoodModel *model = self.foodList[indexPath.row];
        HJFoodDetailTVC *foodDetailVC = [HJFoodDetailTVC new];
        foodDetailVC.foodId = [NSNumber numberWithInteger:model.Id];
        [self.navigationController pushVC:foodDetailVC];
    } else if (self.sportList.count) {
        HJSportModel *model = self.sportList[indexPath.row];
        HJSportDetailTVC *VC = [HJSportDetailTVC new];
        VC.sportId = [NSNumber numberWithInteger:model.Id];
        VC.sportCategoryId = model.sportCategoryId;
        [self.navigationController pushVC:VC];
    } else {
        self.seach.text = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        [self clickSeach];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *View = [[UIView alloc]init];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(12, 10, 90, 20)];
    title.textColor = [UIColor grayColor];
    title.font = [UIFont systemFontOfSize:15];
    title.text = @"最近搜索";
    [View addSubview:title];
    return View;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *View = [[UIView alloc]init];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(50, 50, LH_ScreenWidth-100, 44)];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = IWColor(200, 200, 200).CGColor;
    button.layer.cornerRadius = 5;
    [button setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    if (self.seachFoodArray.count || self.seachSportArray.count) {
        [button setTitle:@"删除历史记录" forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    } else {
        [button setTitle:@"没有搜索记录" forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    }
    ;
    [button addTarget:self action:@selector(deleteSeachHistory:) forControlEvents:UIControlEventTouchUpInside];
    [View addSubview:button];
    return View;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.foodCategoryId) {
        return self.foodList.count ?  0 : 44 ;
    } else {
        return self.sportList.count ?  0 : 44 ;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 150;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    if (self.foodCategoryId) {
        return self.foodList.count ? 90 : 44;
    } else {
        return self.sportList.count ? 90 : 44;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.navigationController.view  endEditing:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.navigationItem.rightBarButtonItem.enabled = searchText.length;
}


@end
