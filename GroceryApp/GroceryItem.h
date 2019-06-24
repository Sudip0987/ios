

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GroceryItem : NSObject
@property NSString* ItemName;
@property NSString* shopAt;
@property float ItemPrice;
@property NSString *weekKey;
@property NSString *ItemKey;

@property bool *shopped;
@property NSDate* date;
@end

NS_ASSUME_NONNULL_END
