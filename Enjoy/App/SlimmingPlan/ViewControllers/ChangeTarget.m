//
//  ChangeTarget.m
//  Enjoy
//
//  Created by IMAC on 16/3/19.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "ChangeTarget.h"
#import "UILabel+LH.h"
#import "HJChooseThinProjectAPI.h"
#import "HJConfirmpProjectAPI.h"
#import "WeightManagementVC.h"
#import "HJUser.h"
@interface ChangeTarget ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mainTable;
    NSArray *imageArr     ;
    NSArray *titleArr     ;
    NSString *textStr     ;
    UIButton *starBtn     ;
    NSInteger oldBtnTag   ;
    NSInteger select      ;
    
    NSString *imageStr;
}
@end

@implementation ChangeTarget

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self ThinProjectList];
}
-(void)doSomeThingInViewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"选择计划";
    
    mainTable =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kDeviceWidth, KDeviceHeight-64) style:(UITableViewStyleGrouped)];
    mainTable.delegate =self;
    mainTable.dataSource = self;
    [self.view addSubview:mainTable];
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, WidthScaleSize(84))];
    starBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    starBtn.frame = CGRectMake(10, 10, kDeviceWidth-20, WidthScaleSize(44));
    starBtn.backgroundColor = RGB(208, 208, 208);
    starBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    starBtn.layer.cornerRadius = 5;
    [starBtn setTitleColor:RGB(110, 110, 110) forState:(UIControlStateNormal)];
    [starBtn setTitle:@"开始瘦身" forState:(UIControlStateNormal)];
    [starBtn addTarget:self action:@selector(starThinBody) forControlEvents:(UIControlEventTouchUpInside)];
    [footView addSubview:starBtn];
    mainTable.tableFooterView = footView;
    
    imageArr = @[@"ic_a14_02",
                 @"ic_a14_03",
                 @"ic_a14_04",
                 @"ic_a14_05"];
    
    titleArr = @[@"轻松减重计划",
                 @"标准减重计划",
                 @"强力减重计划",
                 @"体重管理顾问定制计划"];
}
#pragma mark---------netWorkRequest-------------
- (void)ThinProjectList {
    [[[HJChooseThinProjectAPI chooseThinProject] netWorkClient] postRequestInView:self.view networkCodeTypeSuccessBlock:^(id responseObject) {
        HJChooseThinProjectAPI *api = responseObject;
        HJChooseThinProjectModel *chooseThinProjectModel = api.data;

        textStr = chooseThinProjectModel.remark;
        imageStr = chooseThinProjectModel.ico;
        [mainTable reloadData];
        
    }];
}

#pragma mark---------UITableViewDelegate-------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.5;
    }
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CGSize measureSize = [textStr lh_sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(kDeviceWidth-20, MAXFLOAT)];
        return WidthScaleSize(150)+measureSize.height+10;
    }
    return WidthScaleSize(50);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:str];
    if (indexPath.section == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
        title.textColor = [UIColor grayColor];
        title.font = [UIFont systemFontOfSize:15];
        title.text = @"方案推荐";
        [cell.contentView addSubview:title];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, title.frame.size.height+title.frame.origin.x+10, kDeviceWidth-20, WidthScaleSize(100))];
        [image sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(imageStr)] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        [cell.contentView addSubview:image];
        
        
        [cell.contentView addSubview:[UILabel lh_labelAdaptionWithFrame:CGRectMake(10, image.frame.origin.y+image.frame.size.height+10, kDeviceWidth-20, 100) text:textStr textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:15] textAlignment:(NSTextAlignmentLeft)]];
        
    }else{
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10,WidthScaleSize(30), WidthScaleSize(30))];
        image.image = [UIImage imageNamed:imageArr[indexPath.row]];
        [cell.contentView addSubview:image];
        
        [cell.contentView addSubview:[UILabel lh_labelWithFrame:CGRectMake(image.frame.origin.x+image.frame.size.width+10, WidthScaleSize(15), 200, 20) text:titleArr[indexPath.row] textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor]]];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth-40, WidthScaleSize(20), 15, 15)];
        button.tag = indexPath.row+100;
        [button setBackgroundImage:[UIImage imageNamed:@"ic_a14_01"] forState:(UIControlStateNormal)];
        button.userInteractionEnabled = NO;
        [cell.contentView addSubview:button];
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section!=0) {
        [tableView deselectRowAtIndexPath:tableView.indexPathForSelectedRow animated:YES];
        if (oldBtnTag>0) {
            UIButton *oldBtn = (UIButton *)[tableView viewWithTag:oldBtnTag];
            [oldBtn setBackgroundImage:[UIImage imageNamed:@"ic_a14_01"] forState:(UIControlStateNormal)];
        }
        
        UIButton *selectBtn = (UIButton *)[tableView viewWithTag:indexPath.row+100];
        [selectBtn setBackgroundImage:[UIImage imageNamed:@"ic_a2_03"] forState:(UIControlStateNormal)];
        oldBtnTag = indexPath.row+100;
        select = indexPath.row;
        starBtn.backgroundColor = RGB(104, 212, 49);
        [starBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    }
}

#pragma mark-------开始瘦身---------
-(void)starThinBody{
    NSLog(@"开始瘦身");
    NSNumber *thinProjectId;
    switch (select) {
        case 0:{
            thinProjectId = @1;
            [self goBackSlimPlan:thinProjectId];
        }
            break;
        case 1:{
            thinProjectId = @2;
            [self goBackSlimPlan:thinProjectId];
        }
            break;
        case 2:{
            thinProjectId = @3;
            [self goBackSlimPlan:thinProjectId];
        }
            break;
        default:{
            thinProjectId = @4;
         WeightManagementVC *weightManagerVC = [WeightManagementVC new];
            HJUser *user = [HJUser read];
         weightManagerVC.puserId = [NSNumber numberWithString:user.loginModel.userId];
            weightManagerVC.consantType = Charge_Target_Type;
         [self.navigationController pushVC:weightManagerVC];
        }
            break;
    }
    
}
- (void)goBackSlimPlan:(NSNumber *)thinProjectId{
    
    [[[HJConfirmpProjectAPI ConfirmpProjectWithThinProjectId:thinProjectId] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJConfirmpProjectAPI *api = responseObject;
        if (api.code == 1) {
            [SVProgressHUD showSuccessWithStatus:@"定制成功"];
            
            HJUser *user = [HJUser read];
            user.isLogin = YES;
            [user write];
            
            HJTabBarController *tab = [[HJTabBarController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController = tab;
        }
    }];
}
@end
