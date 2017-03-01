//
//  HJSurverAPI.h
//  Enjoy
//
//  Created by IMAC on 16/4/29.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJSurverModel;
@class HJSurverInfoModel;
@interface HJSurverAPI : HJBaseAPI

+(instancetype)getSurverListpage:(NSNumber *)page rows:(NSNumber *)rows;

@property (nonatomic, strong) HJSurverModel *data;

@end


@interface HJSurverModel : HJBaseModel
@property (nonatomic, strong) NSArray *healthList;
@end


@interface HJSurverInfoModel : HJBaseModel
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *showForMember;
@end
