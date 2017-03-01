//
//  NSDate+LH.h
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LH)

/**
 *  获取指定格式的显示时间
 *
 *  @param format 日期格式，比如：yyyy-MM-dd HH:mm:ss
 *
 *  @return 日期字符串
 */
- (NSString *)lh_stringWithFormat:(NSString *)format;

/**
 *  获取 日期+星期 字符串，比如：2011年4月4日 星期一
 *
 *  @return 日期+星期 字符串
 */
- (NSString *)lh_string_yyyyMMdd_EEEE;

/**
 *  获取 日期 字符串，比如：2011-4-4
 *
 *  @return 日期 字符串
 */
- (NSString *)lh_string_yyyyMMdd;

/**
 *  获取 日期时间 字符串，比如：20151107142223
 *
 *  @return 日期时间 字符串
 */
- (NSString *)lh_string_yyyyMMddHHmmss;

/**
 *  获取 日期+时间 字符串，比如：2015-11-07 14:22:23
 *
 *  @return 日期+时间 字符串
 */
- (NSString *)lh_string_yyyyMMdd_HHmmss;

/**
 *  @author hejing
 *
 *  获取日期距离现在年份
 *
 *  @return 日期距离现在年份
 */
- (NSUInteger)lh_YearsFromDate;

/**
 *  计算前一天和后一天
 *
 *  @return 前一天和后一天
 */
- (NSDictionary *)lh_lastAndNextDayFromDate;


/**
 *  获取几年之前，几年之后的Date
 *
 *  @param year 几年之前（负数），几年之后（正数）
 *
 *  @return   1896-05-15
 */
+(NSDate *)lh_formerDateFromYear:(NSInteger)year;


@end
