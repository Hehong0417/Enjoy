//
//  HJFamilyUserDetailVC.h
//  Enjoy
//
//  Created by 邓朝文 on 16/5/3.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJViewController.h"
#import "HJUserInfoSTVC.h"

@class HJFamilyUserModel;
@interface HJFamilyUserDetailVC : HJViewController
@property (nonatomic, assign) NSInteger familyUserId;
@property (nonatomic, copy) voidBlock headerBlock;
@property (nonatomic, weak) id<ReturnDataDelagate> dataDelegate;
@end
