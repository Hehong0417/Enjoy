//
//  HJHeightListAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/22.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJHeightListAPI.h"

@implementation HJHeightListAPI
+(instancetype)getHeightListWithPage:(NSNumber *)page rows:(NSNumber *)rows {
    HJHeightListAPI *api = [self new];
    [api.parameters setObject:page forKey:@"page"];
    [api.parameters setObject:rows forKey:@"rows"];
    api.subUrl = API_HEIGHT_LIST;
    return api;
}
@end
