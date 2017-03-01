//
//  HJSurverTableV.h
//  Enjoy
//
//  Created by IMAC on 16/4/30.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJViewController.h"
#import "HJSurverAPI.h"
#import "HJSurverListAPI.h"
#import "GWQuestionnaire.h"

typedef void (^HJSurverTableVBlock) (NSInteger nowIndex);

@interface HJSurverTableV : HJViewController

@property (nonatomic, strong) HJSurverInfoModel *infoModel;

@property (nonatomic, strong) GWQuestionnaire *surveyController;

@property (nonatomic, assign) NSInteger surverTag;

@property (nonatomic, strong) HJSurverListModel *ListModel;


@property (nonatomic, copy) HJSurverTableVBlock tableVBlock;
- (void)HJSurverTableVNowIndex:(HJSurverTableVBlock)block;

@end
