//
//  CustomCell.h
//  GroceryApp
//
//  Created by Sudip Sharma on 20/1/19.
//  Copyright © 2019 Sudip Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomCell : NSObject
@property(strong,nonatomic)NSString* itemName;
@property(strong,nonatomic)NSString* itemPrice;
@property(strong,nonatomic)NSString* itemShopAt;
@property(strong,nonatomic)NSString* itemButton;

@end

NS_ASSUME_NONNULL_END
