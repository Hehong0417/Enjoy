//
//  HJAddShareAPI.h
//  Enjoy
//
//  Created by IMAC on 16/5/31.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJAddShareAPI : HJBaseAPI

+(instancetype)addShareInfo:(NSInteger)objectId AndbeenShareType:(NSInteger)beenShareType AndsharePlate:(NSInteger)sharePlate;

@end
