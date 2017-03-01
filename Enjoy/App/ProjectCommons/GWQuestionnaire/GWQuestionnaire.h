//
//  GWQuestionnaire.h
//
//  Created by Grzegorz Wójcik on 07.03.2014.
//
//
#import <UIKit/UIKit.h>
#import "GWQuestionnaireItem.h"

typedef void (^GWQuestionnaireItemBlock) (NSInteger nowIndex);

@interface GWQuestionnaire : UITableViewController
// contains GWQuestionnaireItem (questions with answers)
@property (nonatomic, strong) NSMutableArray *surveyItems;

@property (nonatomic, copy) GWQuestionnaireItemBlock Block;
- (void)nowIndex:(GWQuestionnaireItemBlock)block;

- (id)initWithItems:(NSMutableArray*)items;
-(BOOL)isCompleted;
@end
