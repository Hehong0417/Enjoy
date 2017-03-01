//
//  HJBodyDataTVC.h
//  Enjoy
//
//  Created by IMAC on 16/2/27.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJTableViewController.h"

typedef enum : NSUInteger {
    HJbodyReportType,
    HJhealthReportType,
} HJReportListType;

@interface HJBodyDataTVC : HJTableViewController
@property (nonatomic, strong) NSNumber *userType;
@property (nonatomic, strong) NSNumber *puserId;
@property (nonatomic, assign) HJReportListType reportListType;
@end
