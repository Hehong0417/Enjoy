//
//  HJaddNoteAPI.h
//  Enjoy
//
//  Created by IMAC on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJAddNoteAPI : HJBaseAPI
+(instancetype)addNoteWithcontent:(NSString *)content image:(NSArray *)imageDatas;
@end
