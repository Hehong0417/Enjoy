//
//  HJSystemAttributeAPI.h
//  Enjoy
//
//  Created by 邓朝文 on 16/4/29.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJAboutWeModel,HJSystemAttributeModel;
@interface HJSystemAttributeAPI : HJBaseAPI
+ (instancetype)getAboutWeWithName:(NSString *)name Type:(NSString *)Type;
@property (nonatomic, strong) HJAboutWeModel *data;
@end

@interface HJAboutWeModel : HJBaseModel
@property (nonatomic, strong) HJSystemAttributeModel *systemAttribute;
@end
@interface HJSystemAttributeModel : HJBaseModel

@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *valueName;

@end