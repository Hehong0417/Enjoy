//
//  intakeFrame.h
//  Enjoy
//
//  Created by IMAC on 16/3/15.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 大号字体 */
#define bigFont    [UIFont systemFontOfSize:15]
/** 中号字体 */
#define middleFont [UIFont systemFontOfSize:13]
/** 小号字体 */
#define smallFont  [UIFont systemFontOfSize:11]

@class intakeStatus;
@interface intakeFrame : NSObject
@property (nonatomic, strong) intakeStatus *status;
/** 表格高度 */
@property (nonatomic, assign, readonly) CGRect taabelF;

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
