//
//  HJdeleteFoodRecordAPI.h
//  Enjoy
//
//  Created by IMAC on 16/4/29.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJdeleteFoodRecordAPI : HJBaseAPI
+(instancetype)deleteFoodRecordWithFoodIdArray:(NSArray *)foodIdArray;
@end
