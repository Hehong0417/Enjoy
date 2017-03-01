//
//  HJsportCategoryListAPI.h
//  Enjoy
//
//  Created by IMAC on 16/4/26.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJSportCategoryListModel;

@interface HJSportCategoryListAPI : HJBaseAPI

@property (nonatomic, strong) HJSportCategoryListModel *data;

+(instancetype)getSportCategoryList;

@end
@interface HJSportCategoryListModel : HJBaseModel

@property (nonatomic, strong) NSArray *sportCategoryList;

@end
@interface HJSportCategoryModel : HJBaseModel

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *ico;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *desc;

@end