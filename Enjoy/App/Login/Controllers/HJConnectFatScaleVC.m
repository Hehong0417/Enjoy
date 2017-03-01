//
//  HJConnectFatScaleVC.m
//  Enjoy
//
//  Created by IMAC on 16/4/20.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJConnectFatScaleVC.h"
#import "InputWeightView.h"
#import "HJH5CommonVC.h"
#import "BluetoothManager.h"
#import "UserInfoModel.h"
#import "CKAlertView.h"
#import "HJAddBodyReportAPI.h"
#import "HJUserDetailAPI.h"
#import "ChangeTarget.h"
#import "HJAddWeightAPI.h"
#import "HJUser.h"
#import "HJSurver.h"
#import "HJBodyOfDateVCViewController.h"
#import "HJManInfoModel.h"
#import "MasterSHAinfo.h"
#import "FRK_fatScalesdataSDK.h"
#import "MBProgressHUD.h"
#import "HJLoginVC.h"
#import "HJBleDeviceModel.h"

#define kSavePath [NSString stringWithFormat:@"%@/savedata",DOCU_PATH]

#define DOCU_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

@interface HJConnectFatScaleVC ()<UserInfoDelegate,CBCentralManagerDelegate, PeripheralAddDelegate,CBPeripheralDelegate,UIScrollViewDelegate>
{
    int weightsum;           //重量
    float BMI;               //BMI
    float fatRate;           //体脂率
    float muscle;            //肌肉
    float moisture;          //水分
    float boneMass;          //骨量
    float subcutaneousFat;   //皮下脂肪
    float BMR;               //基础代谢率
    float proteinRate;       //蛋白率
    float visceralFat;       //内脏脂肪
    float physicalAge;       //生理年龄
    int newAdc;              //阻抗值
    
}
@property (strong, nonatomic) IBOutlet UILabel *FatScaleDataLab;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
//中间图片
@property (strong, nonatomic) IBOutlet UIImageView *startImgView;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) MasterSHAinfo *model;
@property (nonatomic, strong) CKAlertView *alertView;
//蓝牙
@property (nonatomic, strong) CBCentralManager *manager;         //建立中心角色 Manager
@property (nonatomic, strong) CBPeripheral *peripheral;          //外部设备
@property (nonatomic, strong) NSMutableArray *peripheralArray;
@property (nonatomic, assign) BOOL isAddPeripheraling;           //判断是否正在增加

@property (nonatomic, strong) NSString *weightsumValue;
@property (nonatomic, strong) NSString *BMIValue;
@property (nonatomic, strong) NSString *fatRateValue;
@property (nonatomic, strong) NSString *muscleValue;
@property (nonatomic, strong) NSString *moistureValue;
@property (nonatomic, strong) NSString *boneMassValue;
@property (nonatomic, strong) NSString *subcutaneousFatValue;
@property (nonatomic, strong) NSString *BMRValue;
@property (nonatomic, strong) NSString *proteinRateValue;
@property (nonatomic, strong) NSString *visceralFatValue;
@property (nonatomic, strong) NSString *physicalAgeValue;
@property (nonatomic, strong) NSString *smrValue;
@property (nonatomic, strong) NSString *AdcValue;

@property (strong, nonatomic) IBOutlet UIButton *writeWeightBtn;
@property (nonatomic, strong) NSMutableDictionary *fatScaleValueDic;
@end

@implementation HJConnectFatScaleVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.FatScaleDataLab.hidden = YES;
    //
    //创建弹框
    self.alertView = [[CKAlertView alloc]initWithContentView:self.view];
    
    //********是否隐藏手写体重按钮*********//
    if (self.fatScaleType == 1) {
        self.writeWeightBtn.hidden = NO;
    }else {
        self.writeWeightBtn.hidden = YES;
    }
    
//    //添加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didConnect:) name:kNotifation_DidConnect object:nil];
    
}
- (void)didConnect:(NSNotification *)noti{
    
    self.FatScaleDataLab.hidden = NO;

}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    HJBleDeviceModel *bleModel = [HJBleDeviceModel read];
    if (bleModel.isConnect) {
        //[[BluetoothManager shareManager] stopBleScan];
        [self stopScan];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"连接智能体脂秤";
    
    MasterSHAinfo *model = [MasterSHAinfo read];
    NSLog(@"=====Age:%@--Sex:%@--Height:%@=====",model.userAge,model.userSex,model.userHeight);
    
    self.startImgView.userInteractionEnabled = YES;
    
    //配置蓝牙
    [self configureBluetooth];
    
    //
    [[BluetoothManager shareManager] setUserInfoDelegate:self];
    
    
    [[BluetoothManager shareManager] setPeripheralAddDelegate:self];

    // -----点击进行扫描-----//
    [self.startImgView lh_setTapActionWithBlock:^{
    
    NSLog(@"开始扫描");

    [[BluetoothManager shareManager] startBleScan];
        
    }];
    
    //------注册过程中体脂秤返回操作-------//
    
    if (self.fatScaleType == 1) {
        
      [self leftBtnAction];
    }
    
}

- (void)configureBluetooth {
    
    self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    [self.peripheral setDelegate:self];
    
}
#pragma mark-  methods

- (void)leftBtnAction {
    
    UIButton *leftButton = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
    [leftButton bk_removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
    [leftButton lh_setTapActionWithBlock:^{
     
        HJLoginVC *loginVC = (HJLoginVC *)[UIViewController lh_createFromStoryboardName:@"Login" WithIdentifier:@"HJLoginVC"];
        HJNavigationController *nav = [[HJNavigationController alloc]initWithRootViewController:loginVC];
        [UIApplication sharedApplication].keyWindow. rootViewController = nav;
    }];
}
- (void)stopScan
{
    [[BluetoothManager shareManager] closeBleAndDisconnect];
    NSLog(@"断开扫描 && 断开连接");
    
}
- (void)SynUerInfo {
    
    //----同步用户信息------//
    
    MasterSHAinfo *model = [MasterSHAinfo read];
    
    [[BluetoothManager shareManager] exchangeDataWithSex:model.userSex withHeight:model.userHeight withAge:model.userAge];

    NSLog(@"//----同步用户信息------//userAge-%@**userHeight-%@****userSex-%@",model.userAge,model.userHeight,model.userSex);
    
}

- (void)uploadBodyData:(NSArray *)bodyDataArr {
//    体重：50 BMI ：21.6 bfr：23.4 皮下脂肪：0.71 内脂肪：7.1
//    肌肉：48.4 基代：1135 骨量：2.65 水含量：25 蛋白率：20
    
    self.FatScaleDataLab.textColor = kRedColor;
    
    NSNumber *userId;
    HJUser *user = [HJUser sharedUser];
    userId = [NSNumber numberWithString:user.loginModel.userId];
    
    NSNumber *userType = [NSNumber numberWithInteger:self.userType];
    NSNumber *puserId = [NSNumber numberWithString:self.puserId];
    
    self.weightsumValue = bodyDataArr[0];
    self.BMIValue = bodyDataArr[1];
    self.fatRateValue = bodyDataArr[2];
    self.muscleValue = bodyDataArr[3];
    self.moistureValue = bodyDataArr[4];
    self.boneMassValue = bodyDataArr[5];
    self.BMRValue = bodyDataArr[6];
    self.visceralFatValue = bodyDataArr[7];
    self.subcutaneousFatValue = bodyDataArr[8];
    self.proteinRateValue = bodyDataArr[9];
    self.physicalAgeValue = bodyDataArr[10];
    self.smrValue = bodyDataArr[10];
    self.AdcValue = bodyDataArr[11];
    
    [[[HJAddBodyReportAPI addBodyReportWithweight:self.weightsumValue bmi:self.BMIValue bfr:self.fatRateValue sfr:self.subcutaneousFatValue uvi:self.visceralFatValue rom:self.muscleValue bmr: self.BMRValue bm:self.boneMassValue vwc:self.moistureValue  pp:self.proteinRateValue userId:userId puserId:puserId userType:userType age:[NSNumber numberWithString:self.physicalAgeValue] smr:self.smrValue adc:self.AdcValue] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJAddBodyReportAPI *api = responseObject;
        if (api.code == 1) {
            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
        //断开连接
        //[self stopScan];
        
        HJH5CommonVC *h5commonVC = [[HJH5CommonVC alloc]init];
            h5commonVC.h5_InterfaceType = HJReport_detailsType;
            
            if (self.fatScaleType == 1) {
                //填写个人资料
                h5commonVC.BtnIsShow = YES;
                h5commonVC.userId = [NSString stringWithFormat:@"%@",userId];
            }else if(self.fatScaleType == 2){
                //瘦身计划
                h5commonVC.BtnIsShow = NO;
                h5commonVC.backType = 100;
                h5commonVC.bodyType = 1111;
                h5commonVC.userId = [NSString stringWithFormat:@"%@",userId];

            }else {
                //家庭用户
                h5commonVC.BtnIsShow = NO;
                h5commonVC.backType = 100;
                h5commonVC.bodyType = 1000;
                h5commonVC.userId = [NSString stringWithFormat:@"%@",puserId];
                
            }
           
            h5commonVC.bodyReportId = [NSString stringWithFormat:@"%ld",api.data.reportId];
            h5commonVC.bodyUserType = [NSString stringWithFormat:@"%@",userType];
            [self.navigationController pushVC:h5commonVC];
        }
    }];
}
- (IBAction)writeHeightBtn:(id)sender {
    
    InputWeightView *view = [InputWeightView initInputWeightViewXib];
    view.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
    view.titleLab.text = @"记录您的体重";
    view.nickBlock= ^(NSString *weight){
        //录入当日体重
        [[[HJAddWeightAPI addWeightWithWeight:weight] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
            HJSurver *vc = [HJSurver new];
            [self.navigationController pushVC:vc];
        }];
    };
    view.KgLab.hidden = NO;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

#pragma mark - UserInfoDelegate
- (void)responeUserInfo:(UserInfoModel *)infoModel IsStop:(NSString *)isStop
{

    [self setInfoData:infoModel IsStop:isStop];
    // 保存数据
    NSString *userinfoSavePath = [NSString stringWithFormat:@"%@/userinfo.json",kSavePath];
    [self creatDirectiory];
    NSDictionary *infoDir = infoModel.mj_keyValues;
    [infoDir writeToFile:userinfoSavePath atomically:YES];
    
    NSString *masterSavePath = [NSString stringWithFormat:@"%@/master.json",kSavePath];
    [self creatDirectiory];
    NSDictionary *masterDir = self.model.mj_keyValues;
    [masterDir writeToFile:masterSavePath atomically:YES];
}

- (void)creatDirectiory
{
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:kSavePath]) {
        [fm createDirectoryAtPath:kSavePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

- (void)setInfoData:(UserInfoModel *)infoModel IsStop:(NSString *)isStop
{
    //体重
    self.weightsumValue = [NSString stringWithFormat:@"%.1f",infoModel.weightsum/10];
    //BMI
    self.BMIValue = [NSString stringWithFormat:@"%.1f",infoModel.BMI];
    //体脂率
    self.fatRateValue = [NSString stringWithFormat:@"%.1f",infoModel.fatRate];
    //肌肉
    self.muscleValue = [NSString stringWithFormat:@"%.1f ",infoModel.muscle];
    //水分
    self.moistureValue = [NSString stringWithFormat:@"%.1f",infoModel.moisture];
    //骨量
    self.boneMassValue = [NSString stringWithFormat:@"%.1f",infoModel.boneMass];
    //皮下脂肪
    self.subcutaneousFatValue = [NSString stringWithFormat:@"%.1f",infoModel.subcutaneousFat];
    //基础代谢率
    self.BMRValue = [NSString stringWithFormat:@"%.1f",infoModel.BMR];
    //蛋白率
    self.proteinRateValue = [NSString stringWithFormat:@"%.1f",infoModel.proteinRate];
    //内脏脂肪
    self.visceralFatValue = [NSString stringWithFormat:@"%.1f",infoModel.visceralFat];
    //生理年龄
    self.physicalAgeValue = [NSString stringWithFormat:@"%.1f",infoModel.physicalAge];
    //阻抗值
    self.AdcValue = [NSString stringWithFormat:@"%d",infoModel.newAdc];
   // NSLog(@"BMIValue = %@",self.BMIValue);
    
    if ([isStop isEqualToString:@"2"]) {
        NSLog(@"IS_STOP!!!!");
        
        if (_visitorType == 1000) {
            //直接拼接（h5）
            NSDictionary *vistorDic = [self appendingParames];
            HJBodyOfDateVCViewController *visterBodyWebVC = [HJBodyOfDateVCViewController new];
            visterBodyWebVC.visterDic = vistorDic;
            //断开连接
            [self stopScan];
            
            [self.navigationController pushVC:visterBodyWebVC];
            
        }else {
            
            MasterSHAinfo *masModel = [MasterSHAinfo read];
            NSInteger userAge = masModel.userAge.integerValue;
            
            NSInteger userSex = [masModel.userSex isEqualToString:@"男"]?1:2;
            
            CGFloat userHeight = masModel.userHeight.floatValue;
            
            float Weight = self.weightsumValue.floatValue;
            int adc = self.AdcValue.intValue;
            
            NSLog(@"******%ld-%ld-%.2f-%f",userAge,userSex,userHeight,Weight);
            
            if (userAge >=0&&userAge<=120&&Weight>0&&Weight<=220&&userHeight>0&&userHeight<270&&adc>0&&adc<=1000) {
                
                NSArray *bodyDataArr =  [FRK_fatScalesdataSDK getUserSex:userSex withAge:userAge withHeight:userHeight/100 withWeight:Weight withAdc:adc];
                            NSLog(@"******%@-%ld-%ld-%f-%f",bodyDataArr,userAge,userSex,userHeight/100,Weight);
                //上传数据
                [self uploadBodyData:bodyDataArr];
            }
        }
        
        }
}
#pragma mark - 拼接参数
- (NSDictionary *)appendingParames {
    
    HJManInfoModel *manInfoM = [HJManInfoModel read];
    NSString *createTime = [[NSDate date] lh_string_yyyyMMdd];
    
    //******计算年龄*****
    NSString *birth = manInfoM.birthDay;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //生日
    NSDate *birthDay = [dateFormatter dateFromString:birth];
    //当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
    NSLog(@"currentDate %@ birthDay %@",currentDateStr,birth);
    NSTimeInterval time=[currentDate timeIntervalSinceDate:birthDay];
    int userAge = ((int)time)/(3600*24*365);
    NSLog(@"year %d",userAge);
    
    NSString *realAge = [NSString stringWithFormat:@"%d",userAge];
    
    NSNumber *sex = [manInfoM.sex isEqualToString:@"男"]?@0:@1;
    
    NSDictionary *pramesDic = @{@"weight":self.weightsumValue, @"bmi":self.BMIValue,@"bfr":self.fatRateValue,@"sfr":self.subcutaneousFatValue,@"uvi":self.visceralFatValue,@"rom":self.muscleValue,@"bmr":self.BMRValue,@"bm":self.boneMassValue,@"vwc":self.moistureValue,@"pp":self.proteinRateValue,@"age":self.physicalAgeValue,@"createTime":[createTime stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding],@"realAge":realAge,@"sex":sex};
    
    return pramesDic;
}
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{

}
#pragma mark - PeripheralAddDelegate

- (void)addPeripheralWithPeripheral:(BLEModel  *)peripheralModel
{
    //5
    if (self.isAddPeripheraling == YES)
        return;
    self.isAddPeripheraling = YES;
    if (self.peripheralArray.count == 0) {
        [self.peripheralArray addObject:peripheralModel];
        //弹框选择
        [self.alertView.peripheralArray addObject:peripheralModel];
        [self.alertView show];
        NSLog(@"alertViewArr--%@",self.alertView.peripheralArray);
        NSLog(@"peripheralArray--%@",self.peripheralArray);
        
        NSLog(@"-----addPeripheralWithPeripheral-----");

    }
    BOOL willAdd = YES;
    for (BLEModel *model in self.peripheralArray)
    {
        if ([model.backPeripheral.description isEqualToString:peripheralModel.backPeripheral.description])
        {
            willAdd = NO;
        }
    }
    if (willAdd) {
        
        [self.peripheralArray addObject:peripheralModel];
        
     //弹框选择设备
        [self.alertView.peripheralArray addObject:peripheralModel];
        NSLog(@"alertViewArray2--%@",self.peripheralArray);
        NSLog(@"peripheralArray2--%@",self.alertView.peripheralArray);
    
        [self.alertView reload];
    }
    self.isAddPeripheraling = NO;
    
}
#pragma mark - Setter and Getter

- (NSMutableArray *)peripheralArray
{
    if (_peripheralArray == nil) {
        _peripheralArray = [[NSMutableArray alloc] init];
    }
    return _peripheralArray;
}



//---------------end------------------//
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
