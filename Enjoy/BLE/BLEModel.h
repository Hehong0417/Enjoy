//
//  BLEModel.h
//  BLE_AiCare
//
//  Created by percy on 15/11/15.
//  Copyright © 2015年 com.percy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface BLEModel : NSObject

@property (nonatomic) CBPeripheral *backPeripheral;

@property (nonatomic, strong) NSString *backPeripheralString;




@end
