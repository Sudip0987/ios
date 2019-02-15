//
//  GroceryWeeks.h
//  GroceryApp
//
//  Created by Sudip Sharma on 13/2/19.
//  Copyright © 2019 Sudip Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GroceryWeeks : NSObject
@property NSString* ItemName;
@property (strong, nonatomic) NSMutableArray *GroceryItems;

@end

NS_ASSUME_NONNULL_END
