//
//  MyListViewController.h
//  GroceryApp
//
//  Created by Sudip Sharma on 20/1/19.
//  Copyright © 2019 Sudip Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@import Firebase;
@interface MyListViewController : UITableViewController<UITableViewDataSource,UITableViewDataSource>
@property(strong, nonatomic) NSMutableArray * arrayDate;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

NS_ASSUME_NONNULL_END
