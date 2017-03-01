//
//  UIViewController+LH.m
//  
//
//  Created by zhipeng-mac on 16/2/23.
//
//

#import "UIViewController+LH.h"
#import "UIStoryboard+Addition.h"

@implementation UIViewController (LH)

@end

@implementation UIViewController(Create)

+ (id)lh_create
{
    NSString *className = NSStringFromClass([self class]);
    id newObj = [[UIStoryboard fromName:className] instantiateInitialViewController];
    return newObj;
}

+ (id)lh_createFromStoryboardName:(NSString *)sbName WithIdentifier:(NSString *)identifier;
{
    if (sbName && identifier) {
        
        UIStoryboard *storyboard = [UIStoryboard fromName:sbName];
        
        return [storyboard instantiateViewControllerWithIdentifier:identifier];
        
    }
    return nil;
}

+ (id)lh_createFromStoryboardName:(NSString *)sbName {
    
    return  [self lh_createFromStoryboardName:sbName WithIdentifier:[self className]];
}

@end

@implementation UIViewController (BarButtonItemOffset)

-(NSArray *)rightBarButtonItemsWithOffSetBarButtonItem:(UIBarButtonItem *)barButtomItem Offset:(CGFloat)offset {
    
    return @[[self fixedSpaceItemWithOffset:offset], barButtomItem];
    
}

- (NSArray *)leftBarButtonItemsWithOffSetBarButtonItem:(UIBarButtonItem *)barButtomItem Offset:(CGFloat)offset {
    
    return @[[self fixedSpaceItemWithOffset:-offset], barButtomItem];
}

- (UIBarButtonItem *)fixedSpaceItemWithOffset:(CGFloat)offset {
    
    UIBarButtonItem *fixedSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceItem.width = -offset;
    
    return fixedSpaceItem;
}

@end
