//
//  HJHeightListAPI.h
//  Enjoy
//
//  Created by IMAC on 16/4/22.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJHeightListAPI : HJBaseAPI
@property (nonatomic, strong) NSArray *data;
+(instancetype)getHeightListWithPage:(NSNumber *)page rows:(NSNumber *)rows;
@end
//@interface HJHeightModel : HJBaseModel
//@end