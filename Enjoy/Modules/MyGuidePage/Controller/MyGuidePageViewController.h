//
//  MyGuidePageViewController.h
//  ParentingGuru_Expert
//
//  Created by jiangjunwy on 15/9/24.
//  Copyright (c) 2015年 三优科技. All rights reserved.
//

#import "HJViewController.h"

@interface MyGuidePageViewController : HJViewController<UIScrollViewDelegate>
@property (nonatomic,weak) IBOutlet UIScrollView  * mainScrollView  ;
@property (nonatomic,weak) IBOutlet UIPageControl * mainPageControl ;
@property (nonatomic,weak) IBOutlet UIButton      * guideButton     ;

@property (nonatomic,weak) IBOutlet UIImageView   * guideImageView1 ;
@property (nonatomic,weak) IBOutlet UIImageView   * guideImageView2 ;
@property (nonatomic,weak) IBOutlet UIImageView   * guideImageView3 ;
@property (nonatomic,weak) IBOutlet UIImageView   * guideImageView4 ;
@property (nonatomic,assign) BOOL                   notFirstTime    ;
@end
