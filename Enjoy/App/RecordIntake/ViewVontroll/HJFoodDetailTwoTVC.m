//
//  HJFoodDetailTwoTVC.m
//  Enjoy
//
//  Created by IMAC on 16/5/3.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJFoodDetailTwoTVC.h"
#import "HJFoodDetailOneCell.h"
#import "HJFoodsThreeSmallCell.h"
#import "HJFoodDetailTwoCell.h"

@interface HJFoodDetailTwoTVC ()
@property (nonatomic, strong) UITableView *tabView;
@property (nonatomic, strong) HJFoodDetailModel *foodDetailModel;
@end

@implementation HJFoodDetailTwoTVC

- (void)loadView {
    self.view = [UIView lh_viewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) backColor:kClearColor];
    self.tabView = [UITableView lh_tableViewWithFrame:CGRectMake(0,-20, kScreenWidth, kScreenHeight+20) tableViewStyle:UITableViewStyleGrouped delegate:self dataSourec:self];
    self.tabView.backgroundColor = kVCBackGroundColor;
    [self.view addSubview:self.tabView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self getDetailData];
}

- (void)doSomeThingInViewDidLoad {
    [self registerCell];
    [self getDetailData];
    UIButton *leftBtn = [UIButton lh_buttonWithFrame:CGRectMake(10, 30, 50, 50) target:self action:@selector(backAct) image:kImageNamed(@"ic_b12_fanhui")];
    [self.view addSubview:leftBtn];
}

#pragma mark - Actions
- (void)backAct{
    
    [self.navigationController popVC];
}
#pragma mark - Methods
- (void)registerCell {
    
    [self.tabView registerNib:[UINib nibWithNibName:@"HJFoodDetailOneCell" bundle:nil] forCellReuseIdentifier:@"HJFoodDetailOneCell"];
    [self.tabView registerNib:[UINib nibWithNibName:@"HJFoodDetailTwoCell" bundle:nil] forCellReuseIdentifier:@"HJFoodDetailTwoCell"];
    [self.tabView registerNib:[UINib nibWithNibName:@"HJFoodsThreeSmallCell" bundle:nil] forCellReuseIdentifier:@"HJFoodsThreeSmallCell"];
}
- (void)getDetailData {

        [[[HJFoodDetailAPI getFoodDetailWithfoodId:self.foodId] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
            HJFoodDetailAPI *api = responseObject;
            if (api.code == 1) {
                self.foodDetailModel = api.data;
                [self.tabView reloadData];
            }
        }];

}

#pragma mark - HJDataHandlerProtocol



#pragma mark - Setter&Getter


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:{
            HJFoodDetailOneCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"HJFoodDetailOneCell"];
            oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
            oneCell.foodDetailModel = self.foodDetailModel;
            return oneCell;
        }
            break;
        case 1:{
            HJFoodDetailTwoCell *twoCell = [tableView dequeueReusableCellWithIdentifier:@"HJFoodDetailThreeCell"];
            twoCell.selectionStyle = UITableViewCellSelectionStyleNone;
            twoCell.foodDetailModel = self.foodDetailModel;
            return twoCell;
        
        }
            break;
        default:{
            HJFoodsThreeSmallCell *threeCell = [tableView dequeueReusableCellWithIdentifier:@"HJFoodDetailThreeCell"];
            threeCell.selectionStyle = UITableViewCellSelectionStyleNone;
           // threeCell.foodDetailModel;
            return threeCell;

        }
            break;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:{
            return WidthScaleSize(250)+40;
        }
            break;
        case 1:{
            return 150;
        }
            break;
        default:{
            return 44;
        }
            break;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
        return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [UIView new];
}
@end
