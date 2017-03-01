//
//  HJVisitorAPI.h
//  Enjoy
//
//  Created by 邓朝文 on 16/5/5.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJVisitorAPI : HJBaseAPI

@end

@interface HJVisitorModel : HJBaseModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *job;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *weight;
@property (nonatomic, copy) NSString *waistline;
@property (nonatomic, copy) NSString *hipline;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *province;
@end
