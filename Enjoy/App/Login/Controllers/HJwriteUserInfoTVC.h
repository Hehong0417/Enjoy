//
//  HJwriteUserInfoTVC.h
//  Enjoy
//
//  Created by IMAC on 16/2/25.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJStaticGroupTableVC.h"
#import "MasterSHAinfo.h"
#import "HJUserInfoSTVC.h"


@interface HJwriteUserInfoTVC : HJStaticGroupTableVC

@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) NSString *token;

@property (nonatomic, weak) id<ReturnDataDelagate> dataDelegate;

- (NSData *)setUpMasterDataWithWeight:(NSString *)weight withHight:(NSString *)hight withSex:(NSString *)sex;
@end
