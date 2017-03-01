//
//  HJMyOrderDetailAPI.h
//  Enjoy
//
//  Created by 邓朝文 on 16/4/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJMyOrderDetailModel;
@interface HJMyOrderDetailAPI : HJBaseAPI
+ (instancetype)getMyOrderDetailWithOrderNo:(NSNumber *)orderNo;
@property (nonatomic, strong) HJMyOrderDetailModel *data;
@end

@interface HJMyOrderDetailModel : HJBaseModel
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSString *orderCode;
@property (nonatomic, assign) NSInteger orderState;
@property (nonatomic, strong) NSString *packCode;
@property (nonatomic, copy) NSString *express;
@property (nonatomic, strong) NSString *price;
@end
