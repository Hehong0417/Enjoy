//
//  HJCheckNewOrderAPI.h
//  Enjoy
//
//  Created by IMAC on 16/5/12.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJCheckModel;

@interface HJCheckNewOrderAPI : HJBaseAPI

@property (nonatomic, strong) HJCheckModel *data;

+(instancetype)checknewOrderWithPhone:(NSString *)phone;
@end
@interface HJCheckModel : HJBaseModel
@property (nonatomic, strong) NSNumber *haveNewOrder;
@end