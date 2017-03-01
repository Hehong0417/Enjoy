//
//  SportsLibraryVC.m
//  Enjoy
//
//  Created by IMAC on 16/3/21.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "SportsLibraryVC.h"
#import "MovementListCell.h"
#import "HJSportCategoryListAPI.h"
#import "FoodClass.h"
@interface SportsLibraryVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) HJSportCategoryListModel *SportCategoryListModel;
@property (strong, nonatomic) IBOutlet UITableView *tabView;

@end

@implementation SportsLibraryVC

-(void)doSomeThingInViewDidLoad{
    self.title = @"运动库";
    [self getSportCategoryList];
}

#pragma mark--------------netWorkingRequest----------------------
- (void)getSportCategoryList {
    [[[HJSportCategoryListAPI getSportCategoryList] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJSportCategoryListAPI *api = responseObject;
        self.SportCategoryListModel = api.data;
        [self.tabView reloadData];
    }];

}


#pragma mark---------UITableViewDelegate--------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.SportCategoryListModel.sportCategoryList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovementListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovementListCell"];
    if (cell == nil) {
        cell = [MovementListCell initWithMovementListCellXib];
    }
    cell.SportCategoryModel = self.SportCategoryListModel.sportCategoryList[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:tableView.indexPathForSelectedRow animated:YES];
    HJSportCategoryModel *model = self.SportCategoryListModel.sportCategoryList[indexPath.row];
    FoodClass *vc = [[FoodClass alloc] init];
    vc.ClassType = HJSportType;
    vc.sportCategoryId = model.Id;
    vc.sportName = model.name;
    [self.navigationController pushVC:vc];
}


@end
