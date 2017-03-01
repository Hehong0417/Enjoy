//
//  intakeCell.m
//  Enjoy
//
//  Created by IMAC on 16/3/15.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "intakeCell.h"
#import "intakeStatus.h"
#import "intakeFrame.h"
#import "OneCellSlimin.h"
#import "MultipleAttributeBtn.h"
#import "HJThinPlanHomeAPI.h"
#import "HJdeleteFoodRecordAPI.h"
@interface intakeCell()
{
    intakeStatus *status;
    UILabel *tipLabel;
    UILabel *heatLabel;
    
    UITableView *tabel;
    
    UIImageView *footImage;
    
}
/** 摄入表格 */
@property (nonatomic, weak) UITableView *tabelView;
@property (nonatomic, strong) NSMutableArray *bigFoodRecordList;
@property (nonatomic, strong) NSMutableArray *foodRecordList;
@end

@implementation intakeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"intakeCell";
    intakeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"intakeCell"];
    if (cell == nil) {
        cell = [[intakeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        /** 写入控件 */
        tabel = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, kDeviceWidth-20, 350) style:(UITableViewStyleGrouped)];
        tabel.dataSource = self;
        tabel.delegate   = self;
        tabel.scrollEnabled = NO;
        tabel.layer.cornerRadius  = 6;
        tabel.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        /** 摄入记录 HeaderView模块 */
        UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(10, 0, kDeviceWidth-20, 65)];
        headerV.backgroundColor = [UIColor whiteColor];
        //摄入图标
        UIImageView *image   = [[UIImageView alloc]initWithFrame:CGRectMake(8,8, 25, 25)];
        image.image = [UIImage imageNamed:@"ic_a33_07"];
        [headerV addSubview:image];
        //摄入标题
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(41, 10, 80, 20)];
        title.font = [UIFont systemFontOfSize:15];
        title.textColor = IWColor(92, 93, 102);
        title.text = @"摄入记录";
        [headerV addSubview:title];
        //摄入总量
        heatLabel = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth-28-kDeviceWidth/2, 10, kDeviceWidth/2, 20)];
        heatLabel.textAlignment = NSTextAlignmentRight;
        heatLabel.font = [UIFont systemFontOfSize:15];
        heatLabel.textColor = IWColor(92, 93, 102);
        [headerV addSubview:heatLabel];
        //摄入提示
        tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(35,35, kDeviceWidth-40, 20)];
        tipLabel.font = [UIFont systemFontOfSize:13];
        tipLabel.textColor = IWColor(160, 160, 160);
        [headerV addSubview:tipLabel];
        //分割线
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(35, headerV.frame.size.height-0.5, kDeviceWidth-35-28, 0.5)];
        line.backgroundColor = IWColor(235, 235, 241);
        [headerV addSubview:line];
        
        /** 摄入记录 FooterView模块 */
        UIView *footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth-20, 85)];
        footerV.backgroundColor = [UIColor whiteColor];
        footImage = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth/2-65, 10, 130, 14)];
        footImage.image = [UIImage imageNamed:@"ic_a33_24"];
        [footerV addSubview:footImage];
        //记录摄入
        UIButton *record = [UIButton buttonWithType:(UIButtonTypeCustom)];
        record.frame = CGRectMake(kDeviceWidth/2-10-65, 35, 130, 30);
        [record setBackgroundImage:[UIImage imageNamed:@"ic_a33_08"] forState:(UIControlStateNormal)];
        [record addTarget:self action:@selector(recordFood) forControlEvents:(UIControlEventTouchUpInside)];
        [footerV addSubview:record];
        
        tabel.tableHeaderView = headerV;
        tabel.tableFooterView = footerV;
        [self.contentView addSubview:tabel];
        self.tabelView   = tabel;
        
        
    }
    return self;
}

/**
 *  拦截frame的设置
 */
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

/**
 *  传递模型数据
 */
-(void)setStatusFrame:(intakeFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    tabel.frame = CGRectMake(10, 0, kDeviceWidth-20, _statusFrame.cellHeight);
}


/**
 *  UITableView代理方法
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.bigFoodRecordList.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HJBigFoodRecordModel *bigFoodsRecordModel = self.bigFoodRecordList[section];
    self.foodRecordList = bigFoodsRecordModel.foodRecordList.mutableCopy;
    return self.foodRecordList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    /** 此处每组应判断当无该类食物分组高度是否为0.5不显示 对应下面标题和图标不显示*/
    HJBigFoodRecordModel *bigFoodsRecordModel = self.bigFoodRecordList[section];
    self.foodRecordList = bigFoodsRecordModel.foodRecordList.mutableCopy;
    if (self.foodRecordList.count==0) {
        return 0.5;
    }
    return 38;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = [NSString stringWithFormat:@"%ld%ldcell",(long)indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //
    HJBigFoodRecordModel *bigRecordModel = self.bigFoodRecordList[indexPath.section];
    HJFoodRecord *foodsRecordModel = bigRecordModel.foodRecordList[indexPath.row];
    //食物名称
    UILabel *foodName = [[UILabel alloc]initWithFrame:CGRectMake(35, 0, (kDeviceWidth-70)/3, 20)];
    foodName.font = [UIFont systemFontOfSize:13];
    foodName.textColor = IWColor(69, 69, 69);
    foodName.text = foodsRecordModel.foodName?:@"";
    [cell.contentView addSubview:foodName];
    //食物热量
    UILabel *heat = [[UILabel alloc]initWithFrame:CGRectMake(30+2*(kDeviceWidth-70)/3, 0, (kDeviceWidth-70)/3-30, 20)];
    heat.textAlignment = NSTextAlignmentLeft;
    heat.font = [UIFont systemFontOfSize:13];
    heat.textColor = IWColor(69, 69, 69);
    heat.text = foodsRecordModel.inCalory?[NSString stringWithFormat:@"%@Kcal", foodsRecordModel.inCalory]:@"";
    [cell.contentView addSubview:heat];
    //删除图标
    MultipleAttributeBtn *deleteBtn = [MultipleAttributeBtn buttonWithType:(UIButtonTypeCustom)];
    deleteBtn.frame = CGRectMake(kDeviceWidth-50, 3, 15, 15);
    deleteBtn.indexpath = indexPath;
    [deleteBtn setBackgroundImage:[UIImage imageNamed:@"ic_a8_01"] forState:(UIControlStateNormal)];
    [deleteBtn addTarget:self action:@selector(deleteFood:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.contentView addSubview:deleteBtn];
    //食物分量
    UILabel *component = [[UILabel alloc]initWithFrame:CGRectMake(heat.frame.origin.x-70, 0, 50, 20)];
    component.font = [UIFont systemFontOfSize:13];
    component.textColor = IWColor(69, 69, 69);
    component.text = foodsRecordModel.quantity? [NSString stringWithFormat:@"%@g", foodsRecordModel.quantity]:@"";
    [cell.contentView addSubview:component];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    //餐图标
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(35, 10, 18, 18)];
    [view addSubview:image];
    //标题
    UILabel *title  = [[UILabel alloc]initWithFrame:CGRectMake(55, 10, 100, 18)];
    title.textColor = IWColor(160, 160, 160);
    title.font = [UIFont systemFontOfSize:13];
    [view addSubview:title];
    /** 此处每组应判断当无该类食物不赋值标题和图片 对应上面分组高度是否为0.5不显示 */
    HJBigFoodRecordModel *bigFoodsRecordModel = self.bigFoodRecordList[section];
    self.foodRecordList = bigFoodsRecordModel.foodRecordList.mutableCopy;
    if (self.foodRecordList.count!=0) {
        switch (bigFoodsRecordModel.eatType) {
            case 1:{
                image.image = [UIImage imageNamed:@"ic_a33_18"];
                title.text = @"早餐";
            }
                break;
            case 2:{
                image.image = [UIImage imageNamed:@"ic_a33_19"];
                title.text = @"午餐";
            }
                break;
            case 3:{
                image.image = [UIImage imageNamed:@"ic_a33_20"];
                title.text = @"晚餐";
            }
                break;
            default:{
                image.image = [UIImage imageNamed:@"ic_a33_21"];
                title.text = @"额外饮食";
            }
                break;
        }

    }
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    
    HJBigFoodRecordModel *bigFoodsRecordModel = self.bigFoodRecordList[section];
    self.foodRecordList = bigFoodsRecordModel.foodRecordList.mutableCopy;
    if (self.foodRecordList.count!=0) {
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(35, 0, kDeviceWidth-35-28, 0.5)];
        line.backgroundColor = IWColor(235, 235, 241);
        [view addSubview:line];
    }
    return view;
}

#pragma mark------------删除食物----------------
-(void)deleteFood:(MultipleAttributeBtn *)btn{
    NSLog(@"删除第%ld组第%ld个记录食物",btn.indexpath.section,btn.indexpath.row);
    
    self.deleteBlock(btn.indexpath.section,btn.indexpath.row);
}

#pragma mark------------记录食物----------------
-(void)recordFood{
    [self.delegate intakeCellPush];
}
- (void)setThinPlanHomeModel:(HJThinPlanHomeModel *)thinPlanHomeModel {
    _thinPlanHomeModel = thinPlanHomeModel;
    //摄入总量Lab
    heatLabel.text = [NSString stringWithFormat:@"%ldKcal",self.thinPlanHomeModel.totalCalory];
    //摄入提示
    tipLabel.text = [NSString stringWithFormat:@"摄入量不应多于%ldKcal",self.thinPlanHomeModel.designCalory];
    self.bigFoodRecordList = self.thinPlanHomeModel.bigFoodRecordList.mutableCopy;
    [self.tabelView reloadData];
    
    if (_thinPlanHomeModel.totalCalory>1600) {
        footImage.image = [UIImage imageNamed:@"ic_a33_22"];
    }else{
        footImage.image = [UIImage imageNamed:@"ic_a33_24"];
    }
    
    if (thinPlanHomeModel.bigFoodRecordList.count==0) {
        footImage.hidden = YES;
//        tabel.tableFooterView = nil;
    }else{
        footImage.hidden = NO;
    }
}
@end
