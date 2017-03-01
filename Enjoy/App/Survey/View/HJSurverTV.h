//
//  HJSurverTV.h
//  Enjoy
//
//  Created by IMAC on 16/4/30.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJViewController.h"
#import "HJSurverAPI.h"
#import "HJSurverListAPI.h"

@interface HJSurverTV : HJViewController

@property (nonatomic, strong) HJSurverInfoModel *infoModel;

@property (strong, nonatomic) IBOutlet UITableView *mainTable;

@end
