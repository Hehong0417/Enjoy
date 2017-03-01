//
//  HJIcoCell.h
//  Cancer
//
//  Created by IMAC on 16/2/16.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJIcoCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *ico;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;
@property (nonatomic, copy) idBlock deleteBlock;
@end
