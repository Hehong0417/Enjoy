//
//  BluetoothManager.m
//  BLE_AiCare
//
//  Created by percy on 15/11/10.
//  Copyright © 2015年 com.percy. All rights reserved.
//

#import "BluetoothManager.h"
#import "UserInfoModel.h"
#import "HJUserDetailAPI.h"
#import "HJLoginVC.h"
#import "MasterSHAinfo.h"
#import "HJBleDeviceModel.h"

//servier uuid
static NSString * const JD_Smart_Service_UUID = @"D618D000-6000-1000-8000-000000000000";
static NSString * const AICARE_SERVICE_UUID = @"0000FAB0-0000-1000-8000-00805F9B34FB";
//static NSString * const AICARE_SERVICE_UUID = @"49437DFF-AA5A-4AF6-8DB2-1C8C68A65C18";
static NSString * const XiaozhiPlatform_Smart_Service_UUID = @"0000FFB0-0000-1000-8000-00805F9B34FB";

//characteristics uuid

static NSString *JD_Smart_Service_Write_Characteristics = @"D618D001-6000-1000-8000-000000000000";
static NSString *AICARE_NOTIFY_CHARACTERISTIC_UUID = @"0000FAB2-0000-1000-8000-00805F9B34FB";
static NSString *XiaozhiPlatform_Smart_Service_Write_Characteristics = @"0000FFB2-0000-1000-8000-00805F9B34FB";

static NSString *AICARE_WRITE_CHARACTERISTIC_UUID =  @"0000FAB1-0000-1000-8000-00805F9B34FB";


@interface BluetoothManager () <CBCentralManagerDelegate,CBPeripheralDelegate, ReturnDataDelagate>

@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) NSTimer *bleScanTimer;
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, strong) MasterSHAinfo *model;

@property (nonatomic, strong) NSMutableArray *peripheralArray;
@property (nonatomic, weak) id<PeripheralAddDelegate> addDelegate;
@property (nonatomic, weak) id<UserInfoDelegate>infoDelegate;
@property (nonatomic, weak) id<MasterSHAinfoDelegate>masterSHAinfoDelegate;

@property (nonatomic, copy) NSString *connectPeripheralUUID;
@property (nonatomic, copy) NSString *connectPeripheralCharUUID;

@property (nonatomic, strong) NSMutableArray *BLEServerDatas;

@property (nonatomic, strong) CBCharacteristic *myCharacteristic;


@end


@implementation BluetoothManager
{

    int _weightsum;           //重量
    float _BMI;               //BMI
    float _fatRate;           //体脂率
    float _muscle;            //肌肉
    float _moisture;          //水分
    float _boneMass;          //骨量
    float _subcutaneousFat;   //皮下脂肪
    float _BMR;               //基础代谢率
    float _proteinRate;       //蛋白率
    float _visceralFat;       //内脏脂肪
    float _physicalAge;       //生理年龄
    int _newAdc;              //阻抗值
}

#pragma mark - Life cycle

+ (instancetype)shareManager
{
    static BluetoothManager *shareManager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareManager = [[self alloc] init];
       
    });
    return shareManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self centralManager];
//        self.peripheral.delegate = self;
//        self.centralManager.delegate =self;
        
    }
    return self;
}
#pragma mark - ReturnDataDelegate

- (void)responeData:(MasterSHAinfo *)model
{
    self.model = model;
}
#pragma mark - Public methods

- (void)bleDoScan
{
    self.bleScanTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startBleScan) userInfo:nil repeats:YES];
}

/*
 *if ([[manufacturerData description] rangeOfString:@"ac02"].length > 0 ||
 [[manufacturerData description] rangeOfString:@"ac03"].length > 0 || [[manufacturerData description] rangeOfString:@"a80101"].length > 0 ) {
 NSData *subData = [manufacturerData subdataWithRange:NSMakeRange(manufacturerData.length-8, 8)];
 
 bindString = subData.description;
 
 if (bleMeasureMode == DisConnected  && [[self getVisiableIDUUID:bindString] isEqualToString:self.bindPeripheralIDUUID]) {
 bleMeasureMode = JDConnected;
 if (self.delegate) { [self.delegate startScanBindbindPeripheral]; }
 }
 isConnectAble = YES;
 }
 
 [self addPeripheral:bindString peripheralName:peripheralName];
 *
 */

- (void)connectPeripheral:(CBPeripheral *)peripheral
{
    if ([peripheral.name isEqualToString:@"SWAN"]) {
        self.connectPeripheralUUID = AICARE_SERVICE_UUID;
        self.connectPeripheralCharUUID = AICARE_NOTIFY_CHARACTERISTIC_UUID;
    } else if ([peripheral.name isEqualToString:@"icomon"]){
        self.connectPeripheralUUID = XiaozhiPlatform_Smart_Service_UUID;
        self.connectPeripheralCharUUID = XiaozhiPlatform_Smart_Service_Write_Characteristics;
    }
    self.peripheral = peripheral;
    
    [self.centralManager connectPeripheral:peripheral options:nil];
    
}

- (void)setPeripheralAddDelegate:(id<PeripheralAddDelegate>)delegate
{
    self.addDelegate = delegate;
}           

- (void)setUserInfoDelegate:(id<UserInfoDelegate>)delegate
{
    self.infoDelegate = delegate;
}

// 转化
- (void)exchangeDataWithSex:(NSString *)sex withHeight:(NSString *)height withAge:(NSString *)age
{
    
    //  step 1 APP请求同步数据  这里返回 <ac02fe00 0000cfcd>
    Byte user1[] = {0xac,0x02,0xff,0x00,0x00,0x00,0xcf,0xce};
    NSData * userDD1 = [[NSData alloc] initWithBytes:user1 length:8];
    [self sendDataToBle:userDD1];
    
    // step 2 发送用户数据   这里不返回数据
    Byte usrBytes[] = {0xac,0x02,0xfd,0x00,0x00,0x00,0x00,0x00,
        0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00};
    usrBytes[4] = 8;        //ID
    if ([sex isEqualToString:@"女"]) {
        usrBytes[5] = 0x02;
    } else if ([sex isEqualToString:@"男"]){
        usrBytes[5] = 0x01;
    }
    usrBytes[6] = (NSInteger)age.integerValue;
    usrBytes[7] = height.intValue;
    usrBytes[8] = (6*10 & 0x0f00)/16/16;
    usrBytes[9] =  (6*10 & 0x0ff);
    usrBytes[10] = (110& 0x0f00)/16/16;
    usrBytes[11] = (110 & 0x0ff);
    NSData * usrData = [[NSData alloc] initWithBytes:usrBytes length:20];
    [self sendDataToBle:usrData];
    
    // step 3 结束发送用户列表信息 这里返回 <ac02fc00 0000cfcb> testByte[3] == 0x00 为更新成功
    Byte finishBytes[] = {0xAC,0x02,0xFD,0x02,0x00,0x00,0xcf,0xce};
    NSData * finishData = [[NSData alloc] initWithBytes:finishBytes length:8];
    [self sendDataToBle:finishData];
    
    // step 4 (Byte [8]) bytes = ([0] = '\xac', [1] = '\x02', [2] = '\xfa', [3] = '\b', [4] = '\0', [5] = '\0', [6] = '\xcc', [7] = '\xce') 设置用户编号
    Byte setUserNum[] = {0xac,0x02,0xfa,0x01,0x00,0x00,0xcc,0xce};
    setUserNum[7] = [self getBye8:setUserNum];
    NSData * setUserNumdata  = [[NSData alloc] initWithBytes:setUserNum length:8];
    [self sendDataToBle:setUserNumdata];

    // step 5  ([0] = '\xac', [1] = '\x02', [2] = '\xfe', [3] = '\x06', [4] = '\0', [5] = '\0', [6] = '\xcc', [7] = '\xd0')   //体重校验
    
    
    // step 6   ([0] = '\xac', [1] = '\x02', [2] = '\xfb', [3] = '\x02', [4] = '\x19', [5] = '\xa0', [6] = '\xcc', [7] = '\x82')  //设置用户参数 回调 <ac02fe09 0000ccd3>
    Byte setUserCheck[] = {0xac,0x02,0xfb,0x00,0x00,0x00,0xcc,0xc8};
    setUserCheck[3] = usrBytes[5]; //sex
    setUserCheck[4] = usrBytes[6]; // age
    setUserCheck[5] = usrBytes[7]; //height
    setUserCheck[7] = [self getBye8:setUserCheck];
    NSData * setUserCheckData  = [[NSData alloc] initWithBytes:setUserCheck length:8];
    [self sendDataToBle:setUserCheckData];
    
    // step 7   ([0] = '\xac', [1] = '\x02', [2] = '\xfd', [3] = '\x0f', [4] = '\v', [5] = '\x0f', [6] = '\xcc', [7] = '\xf2')   //设置年份
    Byte dateByte[] = {0xac,0x02,0xfd,0x00,0x00,0x00,0xCC,0x00};
    NSDate *date = [NSDate date];
    dateByte[3] = (date.year & 0x0f);
    dateByte[4] = date.month;
    dateByte[5] = date.day;
    dateByte[7] = [self getBye8:dateByte];
    NSData *dateData = [[NSData alloc] initWithBytes:dateByte length:8];
    [self sendDataToBle:dateData];

    // step 8    ([0] = '\xac', [1] = '\x02', [2] = '\xfc', [3] = '\v', [4] = '\x13', [5] = '&', [6] = '\xcc', [7] = '\f')  //设置时间 回调 <ac02fe07 0000ccd1>
    dateByte[2] = 0xFC;
    dateByte[3] = date.hour;
    dateByte[4] = date.minute;
    dateByte[5] = date.second;
    dateByte[7] = [self getBye8:dateByte];
    NSData *timeData = [[NSData alloc] initWithBytes:dateByte length:8];
    [self sendDataToBle:timeData];
    
    // step 9 over

}

- (void)WriteTimeBLE
{
    Byte dateByte[] = {0xac,0x02,0xfd,0x00,0x00,0x00,0xCC,0x00};
    NSDate *date = [NSDate date];
    dateByte[3] = (date.year & 0x0f);
    dateByte[4] = date.month;
    dateByte[5] = date.day;
    dateByte[7] = [self getBye8:dateByte];
    NSData *dateData = [[NSData alloc] initWithBytes:dateByte length:8];
    [self sendDataToBle:dateData];
    
    dateByte[2] = 0xFC;
    dateByte[3] = date.hour;
    dateByte[4] = date.minute;
    dateByte[5] = date.second;
    dateByte[7] = [self getBye8:dateByte];
    NSData *timeData = [[NSData alloc] initWithBytes:dateByte length:8];
    [self sendDataToBle:timeData];
    NSLog(@"==--%@",timeData);
}

- (Byte )getBye8:(Byte[])data
{
    Byte byte8 = data[2] + data[3] + data[4] + data[5] +data[6];
    byte8 = (unsigned char) ( byte8 & 0x00ff);
    return byte8;
}

#pragma mark - Private Methods

- (void)startBleScan
{
    [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:JD_Smart_Service_UUID],
                                                          [CBUUID UUIDWithString:AICARE_SERVICE_UUID],
                                                          [CBUUID UUIDWithString:XiaozhiPlatform_Smart_Service_UUID]] options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @ YES}];
}

- (void)stopBleScan
{
    [self.bleScanTimer invalidate];
    
}
- (void)closeBleAndDisconnect
{
    [self.centralManager stopScan];
    [self.centralManager cancelPeripheralConnection:self.peripheral];
    HJBleDeviceModel *bleModel = [HJBleDeviceModel read];
    bleModel.isConnect = NO;
}

- (void)sendDataToBle:(NSData *)data
{
    [self.peripheral writeValue:data forCharacteristic:self.myCharacteristic type:CBCharacteristicWriteWithoutResponse];
}

#pragma maek - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:{

            NSLog(@"CBCentralManagerStatePoweredOn");
        }
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@"CBCentralManagerStatePoweredOff");
            break;
        default:
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary<NSString *,id> *)advertisementData
                  RSSI:(NSNumber *)RSSI
{
    NSData *manufacturerData = [advertisementData valueForKeyPath:CBAdvertisementDataManufacturerDataKey];
    [self SynUerInfo];
    //
    //
    if (advertisementData.description.length > 0)
    {
        DLog(@"/-------advertisementData:%@--------",advertisementData.description);
        DLog(@"-------peripheral:%@--------/",peripheral.description);
    }
    NSString *bindString = @"";
    NSData *subData = [manufacturerData subdataWithRange:NSMakeRange(manufacturerData.length-8, 8)];
    bindString = subData.description;
    NSString *str = [self getVisiableIDUUID:bindString];
    NSLog(@" GG == %@ == GG",str);
    
    if ([self.addDelegate respondsToSelector:@selector(addPeripheralWithPeripheral:)]) {
        BLEModel *model = [[BLEModel alloc] init];
        model.backPeripheral = peripheral;
        model.backPeripheralString = str;
        [self.addDelegate addPeripheralWithPeripheral:model];
    }
    
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"-- 成功连接外设 --：%@",peripheral.name);
    NSLog(@"Did connect to peripheral: %@",peripheral);
    
    //发送成功连接的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifation_DidConnect object:nil];
    
    [self SynUerInfo];
    
    HJBleDeviceModel *bleModel = [HJBleDeviceModel new];
    bleModel.bleArr = [NSMutableArray array];
    if (![bleModel.bleArr containsObject:peripheral.name]
        ) {
        [bleModel.bleArr addObject:peripheral.name];
    }
    bleModel.isConnect = YES;
    [bleModel write];
    NSLog(@"bleModel-%@",bleModel.bleArr);
    [self.centralManager stopScan];
    [self stopBleScan];
    [self.peripheral setDelegate:self];
    [self.peripheral discoverServices:@[[CBUUID UUIDWithString:self.connectPeripheralUUID]]];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"-- 连接失败 --");
}

#pragma mark - CBPeripheralDelegate

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (error) {
        NSLog(@"未发现服务-- error --%@ ",error);
    }
    NSLog(@"-----发现服务Services------");
    
    for (CBService *server in peripheral.services) {
        if ([server.UUID isEqual:[CBUUID UUIDWithString:self.connectPeripheralUUID]])
        {
            //@[[CBUUID UUIDWithString:self.connectPeripheralCharUUID]]ad
            [self.peripheral discoverCharacteristics:nil
                                          forService:server];
        }
    }
}
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    //在这里进行uuid的匹对，拿到特征值进行读写
//    [service.UUID isEqual:[CBUUID UUIDWithString:self.connectPeripheralUUID]]AICARE_WRITE_CHARACTERISTIC_UUID
    
    NSLog(@"------发现Service的特性------");
    if ([service.UUID isEqual:[CBUUID UUIDWithString:self.connectPeripheralUUID]]) {
        for (CBCharacteristic *characteristic in service.characteristics) {
            if (characteristic.properties & CBCharacteristicPropertyNotify) {
                [peripheral readValueForCharacteristic:characteristic];
                [peripheral setNotifyValue:YES forCharacteristic:characteristic];
                NSLog(@"=---- %@ ----",characteristic);

            }
            
            if([characteristic.UUID isEqual:[CBUUID UUIDWithString:AICARE_WRITE_CHARACTERISTIC_UUID]]){
                self.myCharacteristic  = characteristic;
                
//                测试单条信息写入⬇️⬇️⬇️
//                Byte user1[] = {0xac,0x02,0xfa,0x01,0x00,0x00,0xcc,0xc7};
//                NSData * userDD1 = [[NSData alloc] initWithBytes:user1 length:8];
//                [peripheral writeValue:userDD1 forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
//                NSLog(@"userDD1==== %@",userDD1);
//                
//                Byte user[] = {0xac,0x02,0xfb,0x01,0x14,0x9e,0xcc,0x7a};
//                NSData * userDD = [[NSData alloc] initWithBytes:user length:8];
//                [peripheral writeValue:userDD forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
//                NSLog(@"userDD==== %@",userDD);
//            
//                NSLog(@"MYCHARA == %@",self.myCharacteristic.UUID);
            }
            
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
    NSLog(@"didUpdateNotificationStateForCharacteristic: %@",characteristic.value);
}
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    @synchronized(self) {
    NSLog(@"didUpdateValueForCharacteristic:读到特性值-- %@",characteristic.value);
    
    if (characteristic.value.length == 0){
        [self SynUerInfo];
        return;
        }
    NSString *value = [NSString stringWithFormat:@"%@",characteristic.value];
        NSLog(@"value: %@",value);
        
    NSString *isStop = @"1";

    Byte *testByte = (Byte*)[characteristic.value bytes];
    
    if (testByte[6] == 0XCE) {
        
        _weightsum = testByte[2]*256 + testByte[3];
        
        //[self SynUerInfo];
        
    }
     if (testByte[6] == 0XCA) {
        _weightsum = testByte[2]*256 + testByte[3];
        
         //[self SynUerInfo];

    }
     if (testByte[2] == 0XFE && testByte[6] == 0XCB)
         //连接上收到包裹才会跳入
//    else if (testByte[0] == 0xAC && characteristic.value.length == 20)
    {
        if (testByte[3] == 0X00) {
            _weightsum = testByte[4]*256 + testByte[5];
            [self SynUerInfo];
        } else if (testByte[3] == 0X01) {
            _BMI = (float)(testByte[4]*256 +testByte[5])/10;
        } else if (testByte[3] == 0X02) {
            _fatRate = (float)(testByte[4]*256 +testByte[5])/10;
        } else if (testByte[3] == 0X03) {
            _subcutaneousFat = (float)(testByte[4]*256 +testByte[5])/10;
        } else if (testByte[3] == 0X04) {
            _visceralFat = testByte[4]*256 +testByte[5];
        } else if (testByte[3] == 0X05) {
            _muscle = (float)(testByte[4]*256 +testByte[5])/10;
        } else if (testByte[3] == 0X06) {
            _BMR = (testByte[4]*256 +testByte[5]);
        } else if (testByte[3] == 0X07) {
            _boneMass = (float)(testByte[4]*256 +testByte[5])/10;
        } else if (testByte[3] == 0X08) {
            _moisture = (float)(testByte[4]*256 +testByte[5])/10;
        } else if (testByte[3] == 0X09) {
            _physicalAge = testByte[4]*256 +testByte[5];
        } else if (testByte[3] == 0X0A) {
            _proteinRate = testByte[4]*256 +testByte[5];
//            [self showMeasureResult];
        } else if (testByte[3] == 0XFF) {
            NSLog(@"脂肪数据测量出错");
        }
    }else if (testByte[2] == 0xFD && testByte[3] == 0x01 && testByte[6] == 0xCB) {
        _newAdc = testByte[4]*256 + testByte[5];
    }
        
        NSLog(@"-------%d------",_weightsum);
        
    //*****用户模型*****//
      UserInfoModel *model = [[UserInfoModel alloc] init];
        model.weightsum = _weightsum;
        model.BMI = _BMI;
        model.fatRate = _fatRate;
        model.muscle = _muscle;
        model.moisture = _moisture;
        model.boneMass = _boneMass;
        model.subcutaneousFat = _subcutaneousFat;
        model.BMR = _BMR;
        model.proteinRate = _proteinRate;
        model.visceralFat = _visceralFat;
        model.physicalAge = _physicalAge;
        model.newAdc = _newAdc;
 
        //*****用户模型*****//
        
        if ([value containsString:@"ac02fe0a"]) {
            
            isStop = @"2";
            
            NSLog(@"测量停止。。。。");
        }
        
        if ([self.infoDelegate respondsToSelector:@selector(responeUserInfo:IsStop:)]) {
            
            [self.infoDelegate responeUserInfo:model IsStop:isStop];
        }

    }
    
}

#pragma mark-  methods
- (void)SynUerInfo {
    
    //----同步用户信息------//
    
    MasterSHAinfo *model = [MasterSHAinfo read];
    
    [[BluetoothManager shareManager] exchangeDataWithSex:model.userSex withHeight:model.userHeight withAge:model.userAge];
    
    NSLog(@"//----同步用户信息------//userAge-%@**userHeight-%@****userSex-%@",model.userAge,model.userHeight,model.userSex);
    
}

- (NSString *)getVisiableIDUUID:(NSString *)peripheralIDUUID
{
    peripheralIDUUID = [peripheralIDUUID stringByReplacingOccurrencesOfString:@"-" withString:@""];
    peripheralIDUUID = [peripheralIDUUID stringByReplacingOccurrencesOfString:@"<" withString:@""];
    peripheralIDUUID = [peripheralIDUUID stringByReplacingOccurrencesOfString:@">" withString:@""];
    peripheralIDUUID = [peripheralIDUUID stringByReplacingOccurrencesOfString:@" " withString:@""];
    peripheralIDUUID = [peripheralIDUUID substringFromIndex:peripheralIDUUID.length - 12];
    peripheralIDUUID = [peripheralIDUUID uppercaseString];
    NSData *bytes = [peripheralIDUUID dataUsingEncoding:NSUTF8StringEncoding];
    Byte * myByte = (Byte *)[bytes bytes];
    
    NSMutableString *result = [[NSMutableString alloc] initWithString:@""];
    for (int i = 5; i >= 0; i--) {
        [result appendString:[NSString stringWithFormat:@"%@",[[NSString alloc] initWithBytes:&myByte[i*2] length:2 encoding:NSUTF8StringEncoding] ]];
    }
    
    for (int i = 1; i < 6; i++) {
        [result insertString:@":" atIndex:3*i-1 ];
    }
    
    return result;
}


#pragma mark - Setter and Getter

- (CBCentralManager *)centralManager
{
    if (!_centralManager ) {
        _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return _centralManager;
}

- (NSMutableArray *)peripheralArray
{
    if (!_peripheralArray) {
        _peripheralArray = [[NSMutableArray alloc] init];
    }
    return _peripheralArray;
}

- (NSString *)connectPeripheralUUID
{
    if (_connectPeripheralUUID == nil) {
        _connectPeripheralUUID = [[NSString alloc] init];
    }
    return _connectPeripheralUUID;
}

- (NSString *)connectPeripheralCharUUID
{
    if (_connectPeripheralCharUUID == nil) {
        _connectPeripheralCharUUID  = [[NSString alloc] init];
    }
    return _connectPeripheralCharUUID;

}

- (CBCharacteristic *)myCharacteristic
{
    if (_myCharacteristic == nil) {
        _myCharacteristic = [CBCharacteristic new];
    }
    return _myCharacteristic;
}

    

@end
