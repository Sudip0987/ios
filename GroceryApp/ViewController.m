
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize tbItemName,tbShopAt,tbItemPrice;
bool dateAdded=false;
NSString *key1, *key2,*key3;
NSMutableArray *addedItem;
bool performSegue = false;

NSInteger totalBudget=0,usedBudget=0;
- (void)viewDidLoad {
    
    addedItem = [[NSMutableArray alloc]init];
    [super viewDidLoad];
    self.ref = [[FIRDatabase database] reference];  //creating an instance of FIRDatabaseReference to read and write data
    
}
-(void)updateBudgetInDB{
    
    [[[self.ref child:@"GroceryData"] queryOrderedByChild:@"Items"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        
        for(FIRDataSnapshot* snap in snapshot.children){ //looping inside main object ie; snapshot
            if([[snap.value objectForKey:@"deviceID"] isEqualToString:deviceID]){
                if([snap.key isEqualToString:key1]){//if snap.key matches with the current key, skip it and set value of other item to 0
                      [[[[self.ref child:@"GroceryData"] child:snap.key]child:@"budget"] setValue:
                       [NSString stringWithFormat:@"%ld",usedBudget]];
                }
                
            }
            
            
            
        }
        
        
    }];
    
    
}

-(void) storeDeviceID{
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* dateString  = [formatter stringFromDate:date];
    
    key1 = [[_ref child:@"/GroceryData/"] childByAutoId].key;
    NSDictionary *post2 = @{
                            @"deviceID": deviceID,
                            @"date": dateString,
                            @"isCurrent":@true,
                            @"budget":[NSString stringWithFormat:@"%ld",(long)usedBudget]
                            
                            };    NSDictionary *childUpdates2 = @{[@"/GroceryData/" stringByAppendingString:key1]: post2};
    [_ref updateChildValues:childUpdates2];
    
    
}



-(void)setPreviousDataAsHistory{
    
    [[[self.ref child:@"GroceryData"] queryOrderedByChild:@"Items"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        
        for(FIRDataSnapshot* snap in snapshot.children){ //looping inside main object ie; snapshot
            if([[snap.value objectForKey:@"deviceID"] isEqualToString:deviceID]){
                if(![snap.key isEqualToString:key1]){//if snap.key matches with the current key, skip it and set value of other item to 0

                [[[[self.ref child:@"GroceryData"] child:snap.key]child:@"isCurrent"] setValue:@false];
                }
                
            }
            
            
            
        }
        
        
    }];
    
    
}


-(void)updateBudgetValue{
    

    _budgetLabel.text = [NSString stringWithFormat:@"Budget : %ld$\n\nUsed   :  %ld$",(long)totalBudget,(long)usedBudget];
    _budgetLabel.numberOfLines=0;    _budgetLabel.numberOfLines=0;
    
}
-(void) addItem{
    usedBudget += [tbItemPrice.text integerValue];
    [self updateBudgetValue];
    if(usedBudget>totalBudget){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Budget Warning"
                                                        message:@"You are about to excceeding your budget limit"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        performSegue =true;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Item Added"
                                                    message:[NSString stringWithFormat:@"%@ has been successfully added to database.",tbItemName.text]
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    if(dateAdded==false){
        // key1 = [[_ref child:@"/GroceryData/"] childByAutoId].key;
        
    }
    key2 = [[_ref child:[key1 stringByAppendingString:@"/Items/"]] childByAutoId].key;
    
    
    
    
    NSDictionary *post = @{@"ItemName": [tbItemName text],
                           @"ItemPrice": [tbItemPrice text],
                           @"ShopAt": [tbShopAt text],
                           @"shopped":@false
                           
                           };
    
    
    NSDictionary *childUpdates1 = @{[@"/GroceryData/" stringByAppendingString:[key1 stringByAppendingString:[@"/Items/" stringByAppendingString:key2]]]: post};
    [_ref updateChildValues:childUpdates1];
    
    
    
    
    
    
    
}

-(bool) checkIfValid:(NSString*)checkNumber {
    if([checkNumber intValue]!=nil){
        
        return true;
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Item Added"
                                                        message:@"Budget value miust be numerical"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return false;
    }
}
- (IBAction)btAdd:(id)sender {
    
    
    if([self checkIfValid:tbItemPrice.text]==true){
        if(addedItem.count>0){
            for(NSString *it in addedItem){
                if([tbItemName.text isEqualToString:it]){
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Item Added"
                                                                    message:[NSString stringWithFormat:@"%@ already exists in database.",tbItemName.text]
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                }else {
                    [self addItem];
                }
                NSLog(@"%@", it);
            }
        }else {
            [self addItem];
            [addedItem addObject:tbItemName.text];
        }
    }

    
}

- (IBAction)btClear:(id)sender {
    tbShopAt.text=@"";
    tbItemName.text = @"";
    tbItemPrice.text = @"";
    
    //[_ref updateChildValues:childUpdates2];
}

- (IBAction)btFinish:(id)sender {
    
    [self updateBudgetInDB];
}

- (IBAction)btSetBudget:(id)sender {
    if([self checkIfValid:_tbBudget.text]==true){
        [self naviagteScreen];

    }
   
}
    
    
-(void) naviagteScreen{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Create shopping list"
                                 message:@"This new list will replace your old list as current shopping list. Do you wish to procced?"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [self performSegueWithIdentifier:@"showItemScreen" sender:self];
                                    [self setPreviousDataAsHistory];
                                    totalBudget = [self.tbBudget.text integerValue];
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle no, thanks button
                               }];
    
    //Add your buttons to alert controller
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    [self storeDeviceID];
    
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    if(performSegue==true){
        return  true;
    }else{
        return false;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [self updateBudgetValue];
}
@end
