//
//  ViewController.m
//  GroceryApp
//
//  Created by Sudip Sharma on 19/1/19.
//  Copyright © 2019 Sudip Sharma. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize tbItemName,tbShopAt,tbItemPrice;
bool dateAdded=false;
 NSString *key1, *key2,*key3;
- (void)viewDidLoad {
    
    
    [super viewDidLoad];
   self.ref = [[FIRDatabase database] reference];  //creating an instance of FIRDatabaseReference to read and write data
    
}

-(void) storeDeviceID{
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* dateString  = [formatter stringFromDate:date];

    NSLog(@"DeviceID:%@ ", deviceID);
   key1 = [[_ref child:@"/GroceryData/"] childByAutoId].key;
    NSDictionary *post2 = @{
                            @"deviceID": deviceID,
                            @"date": dateString,
                            @"isCurrent":@true,
                            
                            };    NSDictionary *childUpdates2 = @{[@"/GroceryData/" stringByAppendingString:key1]: post2};
    [_ref updateChildValues:childUpdates2];
    

}



-(void)setPreviousDataAsHistory{
 
    [[[self.ref child:@"GroceryData"] queryOrderedByChild:@"Items"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        
        int i=0;
        for(FIRDataSnapshot* snap in snapshot.children){ //looping inside main object ie; snapshot
            if([[snap.value objectForKey:@"deviceID"] isEqualToString:deviceID]){
                NSLog(@"KEY: %@",snap.key );
                [[[[_ref child:@"GroceryData"] child:snap.key]child:@"isCurrent"] setValue:@true];

          
            }
            
            
            
        }
        
        
    }];
    
    
}




- (IBAction)btAdd:(id)sender {
    
   // NSLog(@"sss %@",dateString);
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
    
    NSString *deviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];

    
 
    
    
    
    
   

}

- (IBAction)btClear:(id)sender {
    
    
   //[_ref updateChildValues:childUpdates2];
}

- (IBAction)btFinish:(id)sender {
}

- (IBAction)btSetBudget:(id)sender {
    
   
    
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
                                    [self setPreviousDataAsHistory];                              }];
    
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


@end
