//
//  HJJobListAPI.h
//  Enjoy
//
//  Created by IMAC on 16/4/22.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJJobListAPI : HJBaseAPI
@property (nonatomic, strong) NSArray *data;
+(instancetype)getJobListWithPage:(NSNumber *)page rows:(NSNumber *)rows;
@end
