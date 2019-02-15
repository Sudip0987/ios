//
//  GroceryItem.h
//  GroceryApp
//
//  Created by Sudip Sharma on 12/2/19.
//  Copyright © 2019 Sudip Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GroceryItem : NSObject
@property NSString* ItemName;
@property NSString* shopAt;
@property float ItemPrice;
@property NSString *weekKey;
@property NSDate* date;
@end

NS_ASSUME_NONNULL_END
