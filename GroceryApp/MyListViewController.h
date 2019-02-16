//
//  MyListViewController.h
//  GroceryApp
//
//  Created by Sudip Sharma on 20/1/19.
//  Copyright © 2019 Sudip Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroceryItem.h"
#import "CustomCell.h"
NS_ASSUME_NONNULL_BEGIN
@import Firebase;

@interface MyListViewController : UITableViewController<UITableViewDataSource,UITableViewDataSource>
@property(strong, nonatomic) NSMutableArray * arrayDate;
extern NSString* deviceID;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

NS_ASSUME_NONNULL_END
