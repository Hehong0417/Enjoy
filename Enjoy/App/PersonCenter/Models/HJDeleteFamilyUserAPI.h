//
//  HJDeleteFamilyUserAPI.h
//  Enjoy
//
//  Created by 邓朝文 on 16/4/27.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJDeleteFamilyUserAPI : HJBaseAPI
+ (instancetype)deleteFamilyUserWithFamilyUserIdArray:(NSArray *)familyUserIdArray;
@end
