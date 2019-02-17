//
//  CustomCell.h
//  GroceryApp
//
//  Created by Sudip Sharma on 16/2/19.
//  Copyright © 2019 Sudip Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tbName;
@property (weak, nonatomic) IBOutlet UILabel *tbPrice;
@property (weak, nonatomic) IBOutlet UILabel *tbShop;
@property (weak, nonatomic) IBOutlet UIButton *btDone;
@property (weak, nonatomic) IBOutlet UIButton *btDelete;
@property (weak, nonatomic) IBOutlet UIButton *btEdit;

@end

NS_ASSUME_NONNULL_END
