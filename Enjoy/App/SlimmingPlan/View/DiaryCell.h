//
//  DiaryCell.h
//  Enjoy
//
//  Created by IMAC on 16/3/16.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DiaryCellDelegate <NSObject>
-(void)pushDiaryEditor;
@end

@interface DiaryCell : UITableViewCell

@property (weak, nonatomic) id<DiaryCellDelegate>delegate;


@property (weak, nonatomic) IBOutlet UIView *ViewBtn;
+ (instancetype)initWithDiaryCellSliminXib;
@end
