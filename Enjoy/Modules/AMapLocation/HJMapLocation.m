//
//  HJMapLocation.m
//  Ddsc
//
//  Created by zhipeng-mac on 16/1/20.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJMapLocation.h"

static NSString * const kLocationApiKey = @"68e9fbd57e487c8cde21b4082705575f";

@interface HJMapLocation ()

@property (nonatomic, strong) AMapLocationManager *locationManager;

@end

@implementation HJMapLocation

+ (instancetype)sharedMapLocation {
 static HJMapLocation *_instance;
 static dispatch_once_t onceToken;
 dispatch_once(&onceToken, ^{
 _instance = [[self alloc] init];
 });
 return _instance;
 }

- (void)startLocationWithSuccessHandler:(void (^)(HJUserCurrentLocationModel *currentLocationModel))successHandler failureHandler:(void (^)(NSError *error))failureHandler{
    
    [AMapLocationServices sharedServices].apiKey = kLocationApiKey;
    
    self.locationManager = [[AMapLocationManager alloc] init];
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    // 带逆地理（返回坐标和地址信息）
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            DDLogError(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            //failureHandler(error);
            
#warning 模拟器模拟定位
            CLLocation *s_location = [[CLLocation alloc]initWithLatitude:23.11 longitude:113.39];
            AMapLocationReGeocode *s_reGeocode = [[AMapLocationReGeocode alloc]init];
            s_reGeocode.province = @"广东省";
            s_reGeocode.city = @"广州市";
            s_reGeocode.district = @"天河区";
            s_reGeocode.building = @"时代TIT广场";
            self.currentLocationModel.regeocode = s_reGeocode;
            self.currentLocationModel.location = s_location;
            successHandler(self.currentLocationModel);
            return;
//            if (error.code == AMapLocationErrorLocateFailed)
//            {
//                return;
//            }
        }
        DDLogInfo(@"location:%@", location);
        
        if (regeocode)
        {
            DDLogInfo(@"reGeocode:%@", regeocode);
            
            self.currentLocationModel.regeocode = regeocode;
            self.currentLocationModel.location = location;
            
            successHandler(self.currentLocationModel);
        }
    }];
}

- (HJUserCurrentLocationModel *)currentLocationModel {
    
    if (!_currentLocationModel) {
        
        _currentLocationModel = [HJUserCurrentLocationModel new];
    }
    
    return _currentLocationModel;
}

@end

@implementation HJUserCurrentLocationModel


@end
