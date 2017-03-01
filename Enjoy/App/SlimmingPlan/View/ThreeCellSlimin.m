//
//  ThreeCellSlimin.m
//  Enjoy
//
//  Created by IMAC on 16/3/15.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "ThreeCellSlimin.h"

@implementation ThreeCellSlimin

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.recordBtn addTarget:self action:@selector(recordMovement) forControlEvents:(UIControlEventTouchUpInside)];
    
    _nowLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    _nowLabel.font = [UIFont systemFontOfSize:12];
    _nowLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_nowLabel];
}

-(void)recordMovement{
    [self.delegate recordMovementPush];
}

+ (instancetype)initWithThreeCellSliminXib{
    return [[[NSBundle mainBundle] loadNibNamed:@"ThreeCellSlimin" owner:nil options:nil] lastObject];
}

-(void)fillRuningTime:(NSString *)nowDesignCalory AndDesignCalory:(NSString *)designCalory AndDesignSportCalory:(NSString *)designSportCalory{
    if ([nowDesignCalory floatValue]>0) {
        _tipLabel.hidden = YES;
        _slider.value = [nowDesignCalory floatValue]/([designCalory floatValue]);
        if (_slider.value>1) {
            _slider.value = 1;
        }
        _slider.userInteractionEnabled = NO;
        [_slider setThumbImage:[UIImage imageNamed:@"ic_a2_03_pre"] forState:UIControlStateNormal];
        _nowLabel.text = [NSString stringWithFormat:@"%@Kcal",nowDesignCalory];
        _nowLabel.center = CGPointMake(_slider.frame.origin.x+WidthScaleSize(_slider.frame.size.width)*_slider.value, _slider.frame.origin.y-8);
        _maxLabel.text = [NSString stringWithFormat:@"%@Kcal",designSportCalory];
    }else{
        _slider.hidden = YES;
        _minLabel.hidden = YES;
        _maxLabel.hidden = YES;
    }
}

- (UIImage *)buttonImageFromColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, 15, 15);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
