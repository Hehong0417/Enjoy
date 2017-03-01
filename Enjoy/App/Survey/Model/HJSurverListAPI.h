//
//  HJSurverListAPI.h
//  Enjoy
//
//  Created by IMAC on 16/4/30.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"
@class HJSurverListModel;
@class HJquestionListModel;
@class HJanswerListModel;
@interface HJSurverListAPI : HJBaseAPI

+(instancetype)getList:(NSString *)healthId AndPage:(NSNumber *)page rows:(NSNumber *)rows;

@property (nonatomic, strong) HJSurverListModel *data;

@end

@interface HJSurverListModel : HJBaseModel
@property (nonatomic, strong) NSArray *questionList;
@property (nonatomic, strong) NSString *isRequired;
@end

@interface HJquestionListModel : HJBaseModel
@property (nonatomic, strong) NSArray *answerList;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *healthId;
@property (nonatomic, strong) NSString *Id;
@end

@interface HJanswerListModel : HJBaseModel
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *questionId;
@property (nonatomic, strong) NSString *Id;
@end