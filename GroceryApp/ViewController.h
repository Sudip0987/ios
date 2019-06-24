

#import <UIKit/UIKit.h>
#import "MyListViewController.h"
@import Firebase;
@interface ViewController : UIViewController

@property (strong, nonatomic) FIRDatabaseReference *ref;
//Budget screen controls

@property (weak, nonatomic) IBOutlet UITextField *tbBudget;
- (IBAction)btSetBudget:(id)sender;

//Add Item screen controls
@property (weak, nonatomic) IBOutlet UILabel *budgetLabel;
@property (weak, nonatomic) IBOutlet UITextField *tbItemName;
@property (weak, nonatomic) IBOutlet UITextField *tbItemPrice;
@property (weak, nonatomic) IBOutlet UITextField *tbShopAt;

- (IBAction)btAdd:(id)sender;
- (IBAction)btClear:(id)sender;
- (IBAction)btFinish:(id)sender;

//global
extern NSString* deviceID;



@end

