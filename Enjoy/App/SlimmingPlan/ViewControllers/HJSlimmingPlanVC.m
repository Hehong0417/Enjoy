//
//  HJSlimmingPlanVC.m
//  Enjoy
//
//  Created by zhipeng-mac on 16/2/25.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJSlimmingPlanVC.h"
#import "OneCellSlimin.h"
#import "TwoSliminCell.h"
#import "ThreeCellSlimin.h"
#import "DiaryCell.h"
#import "intakeCell.h"
#import "intakeStatus.h"
#import "intakeFrame.h"
#import "RecordIntakVC.h"
#import "ChangeTarget.h"
#import "MoveMomentVC.h"
#import "DiaryEditor.h"
#import "HJThinPlanHomeAPI.h"
#import "HJYesterDayEffectVC.h"
#import "BluetoothManager.h"
#import "HJdeleteFoodRecordAPI.h"
#import "HJConnectFatScaleVC.h"
#import "HJUser.h"
#import "MasterSHAinfo.h"
@interface HJSlimmingPlanVC ()<UITableViewDelegate,UITableViewDataSource,OneCellSliminDelegate,intakeCellDelegate,ThreeCellSliminDelegate,DiaryCellDelegate,HJTwoSliminCellDelegate>
{
    UITableView *tabView;
    OneCellSlimin *headerView;
    
    intakeFrame *statusFrame;
}
@property (nonatomic, strong) HJThinPlanHomeModel *thinPlanHomeModel;

@end

@implementation HJSlimmingPlanVC

#pragma mark - HJViewControllerProtocol
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getThinplanHomeData];
}

-(void)doSomeThingInViewDidLoad {
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self createdUI];
    
    MasterSHAinfo *info = [MasterSHAinfo read];
    NSInteger userHeight = info.userHeight.integerValue;
    NSLog(@"身高%f---性别%@---年龄%@",userHeight/100.0,info.userSex,info.userAge);
}

#pragma mark-----------------UI---------------------------
-(void)createdUI{
    
    tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width , self.view.frame.size.height-49) style:(UITableViewStyleGrouped)];
    tabView.delegate   = self;
    tabView.dataSource = self;
    headerView = [OneCellSlimin initWithOneCellXib];
    headerView.delegate = self;
    tabView.tableHeaderView = headerView;
    tabView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 20)];
    tabView.showsVerticalScrollIndicator = NO;
    tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tabView];
    
}
#pragma mark -------netWorkRequest-------
- (void)getThinplanHomeData {
    [[[HJThinPlanHomeAPI getThinPlanHomeData] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJThinPlanHomeAPI *api = responseObject;
        if (api.code == 1) {
            self.thinPlanHomeModel = api.data;
            headerView.thinPlanHomeModel = self.thinPlanHomeModel;
            [self.thinPlanHomeModel write];
            //保存HJUser
            HJUser *user = [HJUser sharedUser];
            user.loginModel.isVip = self.thinPlanHomeModel.isMember;
            [user write];
            
            intakeStatus *Status = [intakeStatus new];
            [Status initIntakeStatus:self.thinPlanHomeModel];
            
            // 创建frame模型对象
            statusFrame = [intakeFrame new];
            // 传递模型数据
            statusFrame.status = Status;
            
            headerView.menstruationStatus = self.thinPlanHomeModel.isMenstruation;
            
            [tabView reloadData];
        }
    }];
}



#pragma mark-------------------uitabelView----------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        return statusFrame.cellHeight?:10;
        
    }else if (indexPath.section==3){
        return WidthScaleSize(260);
    }
    return 150;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            TwoSliminCell *twoCell = [tabView dequeueReusableCellWithIdentifier:@"TwoSliminCell"];
            if (twoCell == nil) {
                twoCell = [TwoSliminCell initWithTwoSliminCellXib];
            }
            twoCell.delegate = self;
            twoCell.thinPlanHomeModel = self.thinPlanHomeModel;
            twoCell.fatBlock = ^{
           //连接智能体脂秤
            HJUser *user = [HJUser sharedUser];
            HJConnectFatScaleVC *fatScalVC = (HJConnectFatScaleVC *)[UIViewController lh_createFromStoryboardName:SB_LOGIN  WithIdentifier:@"HJConnectFatScaleVC"];
                fatScalVC.puserId = user.loginModel.userId;
                fatScalVC.userType = 1;
                fatScalVC.fatScaleType = 2;
                    //
//                [[BluetoothManager shareManager] bleDoScan];
                //
                [self.navigationController pushVC:fatScalVC];
            };
            return twoCell;
        }
            break;
            
        case 1:{
            // 1.创建cell
            intakeCell *cell = [intakeCell cellWithTableView:tabView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            // 2.传递frame模型
//            cell.statusFrame = [NSMutableArray array][0];
            cell.thinPlanHomeModel = self.thinPlanHomeModel;
            cell.statusFrame = statusFrame;
            cell.deleteBlock = ^(NSInteger sec,NSInteger row){
                HJBigFoodRecordModel *bigRecordModel = self.thinPlanHomeModel.bigFoodRecordList[sec];
                HJFoodRecord *foodsRecordModel = bigRecordModel.foodRecordList[row];
                [[[HJdeleteFoodRecordAPI deleteFoodRecordWithFoodIdArray:[NSArray arrayWithObject:foodsRecordModel.foodId]] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
                    
                    [self getThinplanHomeData];
                }];
            };
            return cell;
        }
            break;
            
        case 2:{
            ThreeCellSlimin *threeCell = [tabView dequeueReusableCellWithIdentifier:@"threeCell"];
            if (threeCell == nil) {
                threeCell = [ThreeCellSlimin initWithThreeCellSliminXib];
            }
            threeCell.delegate = self;
            [threeCell fillRuningTime:self.thinPlanHomeModel.sportOutCalory AndDesignCalory:[NSString stringWithFormat:@"%ld",self.thinPlanHomeModel.designCalory] AndDesignSportCalory:[NSString stringWithFormat:@"%ld",self.thinPlanHomeModel.designSportCalory]];
            return threeCell;
            
        }
            break;
        default:{
            DiaryCell *diaryCell = [tabView dequeueReusableCellWithIdentifier:@"DiaryCell"];
            if (diaryCell == nil) {
                diaryCell = [DiaryCell initWithDiaryCellSliminXib];
            }
            diaryCell.delegate = self;
            return diaryCell;
        }
            break;
    }
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
#pragma mark -------HJTwoSliminCellDelegate------
- (void)addWeightSuccess {
    [self getThinplanHomeData];
}

#pragma mark -------OneCellSliminDelegate--------
-(void)push:(NSInteger)stype{
    if (stype==1) {
        [self.navigationController pushVC:[HJYesterDayEffectVC new]];
    }else{
        //选择计划
        [self.navigationController pushVC:[ChangeTarget new]];
    }
}


#pragma mark - -------intakeCellDelegate--------
-(void)intakeCellPush{
    [self.navigationController pushVC:[RecordIntakVC new]];
}



#pragma mark -------ThreeCellSliminDelegate-------
-(void)recordMovementPush{
    [self.navigationController pushVC:[MoveMomentVC new]];
}


#pragma mark -------DiaryCellDelegate-------
-(void)pushDiaryEditor{
    [self.navigationController pushVC:[DiaryEditor new]];
}


@end
