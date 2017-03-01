//
//  HJAddServiceHomeAPI.h
//  Enjoy
//
//  Created by 邓朝文 on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJAddServiceHomeModel;
@interface HJAddServiceHomeAPI : HJBaseAPI
+ (instancetype)getAddServiceHomeWithBannerQuantity:(NSNumber *)bannerQuantity infoQuantity:(NSNumber *)infoQuantity;
@property (nonatomic, strong) HJAddServiceHomeModel *data;

@end

@interface HJAddServiceHomeModel : HJBaseModel
@property (nonatomic, strong) NSArray *bannerList;
@property (nonatomic, strong) NSArray *columnList;
@end

@interface HJBannerList : HJBaseModel
@property (nonatomic, copy) NSString *ico;
@property (nonatomic, assign) NSInteger informationId;
@property (nonatomic, assign) NSInteger Id;
@end

@class HJInformationList;
@interface HJcolumnList : HJBaseModel
@property (nonatomic, copy) NSString *file;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger isNew;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, copy) NSArray *informationList;
@end

@interface HJInformationList : HJBaseModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *ico;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) NSUInteger isNew;
@end
