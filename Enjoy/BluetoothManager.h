//
//  BluetoothManager.h
//  BLE_AiCare
//
//  Created by percy on 15/11/10.
//  Copyright © 2015年 com.percy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#import "MasterSHAinfo.h"
#import "BLEModel.h"
#import "UserInfoModel.h"


@protocol PeripheralAddDelegate <NSObject>

@optional

- (void)addPeripheralWithPeripheral:(BLEModel *)peripheralModel;

@end

@protocol UserInfoDelegate <NSObject>

- (void)responeUserInfo:(UserInfoModel *)infoModel IsStop:(NSString *)isStop;

@end

@protocol MasterSHAinfoDelegate <NSObject>

- (void)masterSHAinfo:(MasterSHAinfo *)infoModel;

@end

@interface BluetoothManager : NSObject

+ (instancetype)shareManager;

- (void)startBleScan;
- (void)closeBleAndDisconnect;
- (void)WriteTimeBLE;
- (void)setPeripheralAddDelegate:(id<PeripheralAddDelegate>)delegate;
- (void)setUserInfoDelegate:(id<UserInfoDelegate>)delegate;
- (void)bleDoScan;
- (void)stopBleScan;
- (void)connectPeripheral:(CBPeripheral *)peripheral;

- (void)exchangeDataWithSex:(NSString *)string withHeight:(NSString *)height withAge:(NSString *)age;

- (Byte )getBye8:(Byte[])data;
- (void)sendDataToBle:(NSData *)data;

@property (nonatomic, copy) boolBlock isconnectBlock;
//@property (nonatomic, assign) BOOL isconnet;
@end
