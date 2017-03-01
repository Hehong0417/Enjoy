//
//  HJPersonCenterHeaderView.h
//  Enjoy
//
//  Created by zhipeng-mac on 16/2/25.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HJUserDetailModel;
typedef NS_ENUM(NSUInteger, HJPerCenterHeaderButtonType) {
    HJPerCenterHeaderButtonTypeSlimmingRecord,
    HJPerCenterHeaderButtonTypeBodyDataReport,
    HJPerCenterHeaderButtonTypeHealthReport,
    HJPerCenterHeaderButtonTypeGirth
};


@protocol HJPersonCenterHeaderViewDeletage <NSObject>
-(void)push:(NSInteger)index;
@end

@interface HJPersonCenterHeaderView : UIView
@property (nonatomic, weak) id<HJPersonCenterHeaderViewDeletage>delegate;

@property (nonatomic, copy) voidBlock headerBlock;

@property (nonatomic, strong) HJUserDetailModel *userDetailModel;
@end
