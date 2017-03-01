//
//  HJBleDeviceModel.h
//  Enjoy
//
//  Created by IMAC on 16/5/7.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseModel.h"

@interface HJBleDeviceModel : HJBaseModel
@property (nonatomic, strong) NSMutableArray *bleArr;
@property (nonatomic, assign) BOOL isConnect;
@end
