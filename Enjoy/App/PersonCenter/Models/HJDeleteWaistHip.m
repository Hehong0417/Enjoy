//
//  HJDeleteWaistHip.m
//  Enjoy
//
//  Created by IMAC on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJDeleteWaistHip.h"

@implementation HJDeleteWaistHip

+(instancetype)deleteWaistHipWithWaistHipIdArray:(NSString *)waistHipIdArray {
    
    HJDeleteWaistHip *api = [self new];
    
    [api.parameters setObject:waistHipIdArray forKey:@"waistHipIdArray"];
    
    api.subUrl = API_DELETE_WAIST_HIP;
    
    return api;
}

@end
