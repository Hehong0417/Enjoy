//
//  HJWaistHipListAPI.h
//  Enjoy
//
//  Created by IMAC on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class WaistHipModel,WaistHipListModel;

@interface HJWaistHipListAPI : HJBaseAPI

@property (nonatomic, strong) WaistHipModel *data;

+(instancetype)getWaistHipListWithPage:(NSNumber *)page rows:(NSNumber *)rows userType:(NSNumber *)userType puserId:(NSNumber *)puserId;
@end

@interface WaistHipModel : HJBaseModel

@property (nonatomic, strong) NSArray *waistHipList;
@end
@interface WaistHipListModel : HJBaseModel

@property (nonatomic, assign) NSInteger userType;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *hipline;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSString *waistline;

@end