//
//  HJInformationAPI.h
//  Enjoy
//
//  Created by IMAC on 16/5/30.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"
@class HJDataModel;
@interface HJInformationAPI : HJBaseAPI
@property (nonatomic, strong) HJDataModel *data;
+(instancetype)getInformationListWithColumnId:(NSString *)columnId page:(NSNumber *)page rows:(NSNumber *)rows;
@end
@interface HJDataModel : HJBaseModel
@property (nonatomic, strong) NSArray *informationList;
@end
@interface HJInformationModel : HJBaseModel

@property (nonatomic, assign) NSInteger informationId;

@property (nonatomic, assign) NSInteger goodNum;

@property (nonatomic, assign) NSInteger commentNum;

@property (nonatomic, assign) NSInteger columnId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *shareNum;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, assign) NSInteger isRead;

@property (nonatomic, copy) NSString *isLove;

@property (nonatomic, assign) NSInteger isNew;

@property (nonatomic, copy) NSString *commentList;

@property (nonatomic, copy) NSString *ico;

@property (nonatomic, copy) NSString *content;

@end