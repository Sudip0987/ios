//
//  EditItemViewController.m
//  GroceryApp
//
//  Created by Sudip Sharma on 17/2/19.
//  Copyright © 2019 Sudip Sharma. All rights reserved.
//

#import "EditItemViewController.h"

@interface EditItemViewController ()

@end
int i=0;
@implementation EditItemViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _tbName.text = cItemName;
    _tbPrice.text = cItemPrice;
    _tbShop.text= cItemShopAt;

    // Do any additional setup after loading the view.
}








/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btConfirm:(id)sender {
    self.ref = [[FIRDatabase database] reference];

    [[[[[[self.ref child:@"GroceryData"]child:currentWeekKey]child:@"Items"]child:currentItemKey] child:@"ItemName"] setValue:_tbName.text];
    [[[[[[self.ref child:@"GroceryData"]child:currentWeekKey]child:@"Items"]child:currentItemKey] child:@"ItemPrice"] setValue:_tbPrice.text];
    [[[[[[self.ref child:@"GroceryData"]child:currentWeekKey]child:@"Items"]child:currentItemKey] child:@"ShopAt"] setValue:_tbShop.text];
}
@end
