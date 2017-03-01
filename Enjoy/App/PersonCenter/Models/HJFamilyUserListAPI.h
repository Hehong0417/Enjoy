//
//  HJFamilyUserListAPI.h
//  Enjoy
//
//  Created by 邓朝文 on 16/4/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJFamilyUserListModel;
@interface HJFamilyUserListAPI : HJBaseAPI
+ (instancetype)getFamilyUserListWithPage:(NSNumber *)page rows:(NSNumber *)rows;
@property (nonatomic, strong) HJFamilyUserListModel *data;
@end

@interface HJFamilyUserListModel : HJBaseModel
@property (nonatomic, strong) NSMutableArray *familyUserList;
@end

@interface HJFamilyUserModel : HJBaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, copy) NSString *photo;

@property (nonatomic, assign) NSInteger Id;
@end