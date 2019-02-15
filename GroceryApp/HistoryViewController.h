//
//  HistoryViewController.h
//  GroceryApp
//
//  Created by Sudip Sharma on 20/1/19.
//  Copyright © 2019 Sudip Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"
#import "GroceryItem.h"
NS_ASSUME_NONNULL_BEGIN
@import Firebase;
@interface HistoryViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) NSMutableArray *weeksArray,*weekKeyArray, *dateArray;

extern NSMutableArray* groceryItemArray;
extern NSString* deviceID;
extern NSString* weekKeyForData;
extern int numberOfItems;



@end

NS_ASSUME_NONNULL_END
