//
//  FoodClass.h
//  Enjoy
//
//  Created by IMAC on 16/3/18.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJViewController.h"


@interface FoodClass : HJViewController

@property (nonatomic, assign) NSInteger foodCategoryId;
@property (nonatomic, strong) NSNumber *eatType;
@property (nonatomic, assign) NSInteger sportCategoryId;
@property (nonatomic, strong) NSString *foodName;
@property (nonatomic, strong) NSString *sportName;
@property (nonatomic, assign) HJClassType ClassType;

@end
