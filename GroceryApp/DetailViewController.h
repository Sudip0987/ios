//
//  DetailViewController.h
//  GroceryApp
//
//  Created by Sudip Sharma on 20/1/19.
//  Copyright © 2019 Sudip Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroceryItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
extern NSMutableArray* groceryItemArray;
extern NSString* weekKeyForData;
extern int numberOfItems;
@end

NS_ASSUME_NONNULL_END
