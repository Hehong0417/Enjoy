//
//  HJManInfoModel.h
//  Enjoy
//
//  Created by IMAC on 16/4/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJBaseModel.h"

@interface HJManInfoModel : HJBaseModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *birthDay;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *job;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, copy) NSString *waistline;
@property (nonatomic, copy) NSString *hipline;
@property (nonatomic, copy) NSString *weight;
@end
