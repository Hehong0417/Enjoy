//
//  HJaddNoteAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAddNoteAPI.h"

@implementation HJAddNoteAPI
+(instancetype)addNoteWithcontent:(NSString *)content image:(NSArray *)imageDatas{
    HJAddNoteAPI *api = [self new];
    [api.parameters setObject:content forKey:@"content"];
    NSMutableArray *imgs = [NSMutableArray array];
    if (imageDatas) {
        for (NSData *imgData in imageDatas) {
            HJNetworkClientFile *file = [HJNetworkClientFile imageFileWithFileData:imgData name:@"ico"];
            [imgs addObject:file];
            // NSLog(@"imgs=%@\n",imgs);
        }
    }
    api.uploadFile = imgs;
    api.subUrl = API_ADD_NOTE_URL;
    return api;
}
@end
