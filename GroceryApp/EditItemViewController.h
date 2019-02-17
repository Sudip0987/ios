//
//  EditItemViewController.h
//  GroceryApp
//
//  Created by Sudip Sharma on 17/2/19.
//  Copyright © 2019 Sudip Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@import Firebase;
@interface EditItemViewController : UIViewController
@property (strong, nonatomic) FIRDatabaseReference *ref;
extern NSString *cItemName,*cItemPrice,*cItemShopAt;


extern NSString* currentWeekKey;
extern NSString* currentItemKey;

@property (weak, nonatomic) IBOutlet UITextField *tbShop;
@property (weak, nonatomic) IBOutlet UITextField *tbPrice;

@property (weak, nonatomic) IBOutlet UITextField *tbName;
- (IBAction)btConfirm:(id)sender;

@end

NS_ASSUME_NONNULL_END
