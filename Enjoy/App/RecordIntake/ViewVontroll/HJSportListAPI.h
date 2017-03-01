//
//  HJSportListAPI.h
//  Enjoy
//
//  Created by IMAC on 16/4/26.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJSportListModel;
@interface HJSportListAPI : HJBaseAPI

+(instancetype)getSportListWithSportName:(NSString *)sportName sportCategoryId:(NSNumber *)foodCategoryId page:(NSNumber *)page rows:(NSNumber *)rows;
@property (nonatomic, strong) HJSportListModel *data;

@end

@interface HJSportListModel : HJBaseModel
@property (nonatomic, strong) NSArray *sportList;
@end

@interface HJSportModel : HJBaseModel
@property (nonatomic, assign) NSNumber *sportCategoryId;
@property (nonatomic, copy) NSString *ico;
@property (nonatomic, assign) NSInteger calory;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger outenQuantity;
@property (nonatomic, assign) NSInteger outenCalory;
@end


