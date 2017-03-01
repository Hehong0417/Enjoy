//
//  MoveMomentVC.m
//  Enjoy
//
//  Created by IMAC on 16/3/21.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "MoveMomentVC.h"
#import "UILabel+LH.h"
#import "recommendedCell.h"
#import "SportsLibraryVC.h"
#import "HJBeginSportAPI.h"
#import "HJAddSportReportAPI.h"
#import "HJdeleteSportRecordAPI.h"
@interface MoveMomentVC ()<UITableViewDelegate,UITableViewDataSource,recommendedCellDelegate>
{
    UITableView *tabView;
    NSMutableArray *todaySportsArr;
}
@property (nonatomic, strong) HJBeginSportModel *beginSportModel;
@end


@implementation MoveMomentVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self netWorkingRequest];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"开始运动";
    [self createdUI];
}

#pragma mark-----------------UI---------------------------
-(void)createdUI{
    tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64,kDeviceWidth,KDeviceHeight-64) style:(UITableViewStyleGrouped)];
    tabView.delegate   = self;
    tabView.dataSource = self;
    tabView.showsVerticalScrollIndicator = NO;
    tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tabView];
    
}
#pragma mark--------------netWorkingRequest----------------------

- (void)netWorkingRequest {
    [[[HJBeginSportAPI getBeginSportData] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJBeginSportAPI *api = responseObject;
        self.beginSportModel = api.data;
        todaySportsArr = api.data.sportRecordList.mutableCopy;
        [tabView reloadData];
    }];
}
#pragma mark-------------------methods----------------------
- (void)delete:(UIButton *)sender {
    
    HJSportrecordModel *model = todaySportsArr[sender.tag-1];
    
    [[[HJdeleteSportRecordAPI deleteSportRecordWithSportIdArray:[NSString stringWithFormat:@"%ld",model.ID]] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        
        HJdeleteSportRecordAPI *api = responseObject;
        
        if (api.code == 1) {
            
            [self netWorkingRequest];
        }
    }];
}

#pragma mark-------------------uitabelView----------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==2) {
        return todaySportsArr.count+1;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==2) {
        return 20;
    }
    return 0.5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 150;
            break;
        case 1:
            return 350;
            break;
        default:
            return 44;
            break;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"cell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:{
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 80, 17)];
            image.image = [UIImage imageNamed:@"ic_c3_02"];
            [cell.contentView addSubview:image];
            if (self.beginSportModel.advice.length == 0) {
                self.beginSportModel.advice = @"暂无点评";
            }
            [cell.contentView addSubview:[UILabel lh_labelAdaptionWithFrame:CGRectMake(20, image.frame.origin.y+image.frame.size.height+10, kDeviceWidth-40, 80) text:self.beginSportModel.advice textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft]];
            
        }
            break;
            
        case 1:{
            recommendedCell *cell = [tabView dequeueReusableCellWithIdentifier:@"recommendedCell"];
            if (cell == nil) {
                cell = [recommendedCell initWithRecommendedCellXib];
            }
            [cell fillBeginSportModel:self.beginSportModel];
            [cell fillRecommentSportModel:self.beginSportModel.recommentSport];
            cell.delegate = self;
            cell.sportViewBlock = ^(NSString *sportRecord){
                if (sportRecord.length == 0) {
                    [SVProgressHUD showInfoWithStatus:@"请填写运动时间！"];
                }else {
                [[[HJAddSportReportAPI addSportRecordWithContinueTime:sportRecord sportId:[NSNumber numberWithInteger:self.beginSportModel.recommentSport.ID]] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
                    HJAddSportReportAPI *api = responseObject;
                    if (api.code==1) {
                        [SVProgressHUD showSuccessWithStatus:@"记录成功"];
                        [self netWorkingRequest];
                    }
                }];
                }
            };
            return cell;
        }
            break;
            
        default:{
            if (indexPath.row==0) {
                cell.textLabel.textColor = [UIColor grayColor];
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                cell.textLabel.text = @"  今日已运动";
            }else{
                HJSportrecordModel *model = todaySportsArr[indexPath.row-1];
                NSString *outCalory = [NSString stringWithFormat:@"%ld大卡", model.outCalory];
                
                NSArray *contenArr = @[model.name,[NSString stringWithFormat:@"%@分钟",model.continueTime],
                                       outCalory];
                
                
                for (int i =0; i<3; i++) {
                    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(18+i*(kDeviceWidth-36)/3, 0, (kDeviceWidth-56)/3, 44)];
                    if (i==1) {
                        label.textAlignment = NSTextAlignmentCenter;
                    }else if (i==2){
                        label.textAlignment = NSTextAlignmentCenter;
                    }
                    label.font = [UIFont systemFontOfSize:15];
                    label.textColor = [UIColor grayColor];
                    label.text = contenArr[i];
                    [cell.contentView addSubview:label];
                }
                UIButton *deleteBtn = [UIButton lh_buttonWithFrame:CGRectMake(kDeviceWidth-40, 0, 30, 44) target:self action:@selector(delete:) image:kImageNamed(@"ic_nav_sousuo")];
                deleteBtn.tag = indexPath.row;
                [cell.contentView addSubview:deleteBtn];
            }
        }
            break;
    }
    
    return cell;
}
//设置单元格两边边距
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(tintColor)]) {
        
        if (tableView == tabView) {
            
            CGFloat cornerRadius = 5.f;
            
            cell.backgroundColor = UIColor.clearColor;
            
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            
            CGMutablePathRef pathRef = CGPathCreateMutable();
            
            CGRect bounds = CGRectInset(cell.bounds, 10, 0);
            
            BOOL addLine = NO;
            
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                
                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
                
            } else if (indexPath.row == 0) {
                
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                
                addLine = YES;
                
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
                
            } else {
                
                CGPathAddRect(pathRef, nil, bounds);
                
                addLine = YES;
                
            }
            
            layer.path = pathRef;
            
            CFRelease(pathRef);
            
            layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
            
            
            
            if (addLine == YES) {
                
                CALayer *lineLayer = [[CALayer alloc] init];
                
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
                
                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
                
                [layer addSublayer:lineLayer];
                
            }
            
            UIView *testView = [[UIView alloc] initWithFrame:bounds];
            
            [testView.layer insertSublayer:layer atIndex:0];
            
            testView.backgroundColor = UIColor.clearColor;
            
            cell.backgroundView = testView;
            
        }
        
    }
    
}

#pragma mark--------recommendedCellDelegate-------------
-(void)pushSportsLibrary{
    NSLog(@"跳转运动裤");
    [self.navigationController pushVC:[SportsLibraryVC new]];
}


@end
