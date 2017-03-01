//
//  HJGetWeightTeacherDataAPI.h
//  Enjoy
//
//  Created by IMAC on 16/5/5.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJWeightTeacherModel;

@interface HJGetWeightTeacherDataAPI : HJBaseAPI

@property (nonatomic, strong) HJWeightTeacherModel *data;

+(instancetype)getWeightTeacherDataWithPuserId:(NSNumber *)puserId;

@end

@interface HJWeightTeacherModel : HJBaseModel

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *twoCode;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *telephone;
@end