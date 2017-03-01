//
//  HJSportDetailAPI.h
//  Enjoy
//
//  Created by IMAC on 16/4/28.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"
@class SportModel,HJSportDetailModel;
@interface HJSportDetailAPI : HJBaseAPI
@property (nonatomic, strong) HJSportDetailModel *data;
+(instancetype)getSportDetailWithSportName:(NSString *)sportName sportCategoryId:(NSNumber *)sportCategoryId pageNo:(NSNumber *)pageNo pageSize:(NSNumber *)pageSize Id:(NSNumber *)Id;

@end
@interface HJSportDetailModel : HJBaseModel

@property (nonatomic, strong) SportModel *sport;

@end

@interface SportModel : HJBaseModel

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, assign) NSInteger calory;

@property (nonatomic, assign) NSInteger time;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, assign) NSInteger sportCategoryId;

@property (nonatomic, copy) NSString *ico;

@property (nonatomic, copy) NSString *gottenTime;

@property (nonatomic, copy) NSString *name;

@end