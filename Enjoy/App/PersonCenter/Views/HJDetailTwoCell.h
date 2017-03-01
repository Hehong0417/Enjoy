//
//  HJDetailTwoCell.h
//  Enjoy
//
//  Created by IMAC on 16/2/26.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^callBlock)();
@interface HJDetailTwoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *onlineMessageBtn;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

- (IBAction)clickCallButton:(id)sender;
@property (nonatomic, copy) callBlock callBlock;
@end
