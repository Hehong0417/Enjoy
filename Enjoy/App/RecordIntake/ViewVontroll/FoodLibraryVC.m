//
//  FoodLibraryVC.m
//  Enjoy
//
//  Created by IMAC on 16/3/18.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "FoodLibraryVC.h"
#import "FoodClass.h"
#import "HJFoodCategoryListAPI.h"
#import "MovementListCell.h"
@interface FoodLibraryVC ()<UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *FoodCategoryList;
@end

@implementation FoodLibraryVC
- (void)viewWillAppear:(BOOL)animated {
    [self getFoodCategoryList];
}
-(void)doSomeThingInViewDidLoad{
    self.title = @"食物库";
    if ([self.mainTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.mainTable setSeparatorInset:UIEdgeInsetsZero];
    }if ([self.mainTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.mainTable setLayoutMargins:UIEdgeInsetsZero];
    }
    
}
- (void)getFoodCategoryList {
    [[[HJFoodCategoryListAPI getfoodCategoryList] netWorkClient] postRequestInView:self.view networkCodeTypeSuccessBlock:^(id responseObject) {
        HJFoodCategoryListAPI *api = responseObject;
        if (api.code == 1) {
        self.FoodCategoryList = api.data.foodCategoryList.mutableCopy;
        [self.mainTable reloadData];
        }
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.FoodCategoryList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MovementListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovementListCell"];
    if (cell == nil) {
        cell = [MovementListCell initWithMovementListCellXib];
    }

    HJfoodCategoryModel *model = self.FoodCategoryList[indexPath.row];
    cell.foodCategoryModel = model;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:tableView.indexPathForSelectedRow animated:YES];
    HJfoodCategoryModel *model = self.FoodCategoryList[indexPath.row];
    
    FoodClass *foodClass = [[FoodClass alloc] initWithNibName:@"FoodClass" bundle:nil];
    foodClass.foodCategoryId = model.Id;
    foodClass.foodName = model.name;
    foodClass.eatType = self.eatType;
    [self.navigationController pushVC:foodClass];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
