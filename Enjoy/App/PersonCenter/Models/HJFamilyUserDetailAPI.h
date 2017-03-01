//
//  HJFamilyUserDetailAPI.h
//  Enjoy
//
//  Created by 邓朝文 on 16/4/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJFamilyUserDetailModel;
@interface HJFamilyUserDetailAPI : HJBaseAPI
@property (nonatomic, strong) HJFamilyUserDetailModel *data;

+ (instancetype)getFamilyUserDetailWithFamilyUserId:(NSNumber *)familyUserId;

@end

@interface HJFamilyUserDetailModel : HJBaseModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, strong) NSString *job;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, strong) NSString *weight;
@property (nonatomic, copy) NSString *waistline;
@property (nonatomic, strong) NSString *hipline;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *province;


@end
