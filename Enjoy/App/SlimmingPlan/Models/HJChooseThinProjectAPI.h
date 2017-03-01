//
//  HJchooseThinProjectHJAPI.h
//  Enjoy
//
//  Created by IMAC on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@ class HJChooseThinProjectModel;
@interface HJChooseThinProjectAPI : HJBaseAPI
@property (nonatomic, strong) HJChooseThinProjectModel *data;
+(instancetype)chooseThinProject;
@end

@interface HJChooseThinProjectModel : HJBaseModel

@property (nonatomic, copy) NSString *ico;

@property (nonatomic, copy) NSString *Id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *remark;

@end