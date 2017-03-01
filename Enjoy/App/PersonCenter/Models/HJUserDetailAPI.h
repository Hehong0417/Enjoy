//
//  HJUserDetailAPI.h
//  Enjoy
//
//  Created by 邓朝文 on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJUserDetailModel;
@interface HJUserDetailAPI : HJBaseAPI
@property (nonatomic, strong) HJUserDetailModel *data;
+ (instancetype)getUserDetail;
@end

@interface HJUserDetailModel : HJBaseModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *job;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *weight;
@property (nonatomic, strong) NSString *waistline;
@property (nonatomic, strong) NSString *hipline;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *regInfoTag;
@end
