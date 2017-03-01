//
//  HJfoodCategoryListAPI.h
//  Enjoy
//
//  Created by IMAC on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"
@class HJFoodCategoryListModel;
@interface HJFoodCategoryListAPI : HJBaseAPI
@property (nonatomic, strong) HJFoodCategoryListModel *data;
+(instancetype)getfoodCategoryList;
@end
@interface HJFoodCategoryListModel : HJBaseModel

@property (nonatomic, strong) NSArray *foodCategoryList;
@end
@interface HJfoodCategoryModel : HJBaseModel

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *ico;

@property (nonatomic, copy) NSString *name;

@end