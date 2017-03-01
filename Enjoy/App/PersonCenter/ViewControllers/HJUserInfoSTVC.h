//
//  HJUserInfoSTVC.h
//  Enjoy
//
//  Created by IMAC on 16/2/27.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJStaticGroupTableVC.h"
#import "MasterSHAinfo.h"
@protocol ReturnDataDelagate <NSObject>

- (void)responeData:(MasterSHAinfo *)model;

@end

@interface HJUserInfoSTVC : HJStaticGroupTableVC

@property (nonatomic, assign) NSInteger familyUserId;

@property (nonatomic, weak) id<ReturnDataDelagate> dataDelegate;

@end
