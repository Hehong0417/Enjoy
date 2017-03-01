//
//  HJMyOrderListAPI.h
//  Enjoy
//
//  Created by 邓朝文 on 16/4/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJMyOrderListModel;
@interface HJMyOrderListAPI : HJBaseAPI
+ (instancetype)getMyOrderListWithPage:(NSNumber *)pageNo phone:(NSString *)phone rows:(NSNumber *)pageSize;
@property (nonatomic, strong) NSArray *data;
@end

@interface HJMyOrderListModel : HJBaseModel
@property (nonatomic, copy) NSString *goodsName;
@property (nonatomic, copy) NSNumber *orderNo;
@property (nonatomic, strong) NSString *orderState;
@end
