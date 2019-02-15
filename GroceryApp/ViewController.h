//
//  ViewController.h
//  GroceryApp
//
//  Created by Sudip Sharma on 19/1/19.
//  Copyright © 2019 Sudip Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
@interface ViewController : UIViewController
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (weak, nonatomic) IBOutlet UITextField *tbItemName;
@property (weak, nonatomic) IBOutlet UITextField *tbItemPrice;
@property (weak, nonatomic) IBOutlet UITextField *tbShopAt;
- (IBAction)btAdd:(id)sender;
- (IBAction)btClear:(id)sender;
- (IBAction)btFinish:(id)sender;
extern NSString* deviceID;


@end

