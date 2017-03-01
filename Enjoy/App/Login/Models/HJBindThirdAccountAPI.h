//
//  HJBindThirdAccountAPI.h
//  Enjoy
//
//  Created by IMAC on 16/5/4.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"
@class HJBindModel;
@interface HJBindThirdAccountAPI : HJBaseAPI
@property (nonatomic, strong) HJBindModel *data;
+(instancetype)bindThirdAccountWithtelephone:(NSString *)telephone account:(NSString *)account  thirdNickName:(NSString *)thirdNickName type:(NSNumber *)type icon:(NSString *)icon;
@end
@interface HJBindModel : HJBaseModel
@property (nonatomic, strong) NSString *isVip;
@property (nonatomic, strong) NSString *regInfoTag;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *sex;
@end
