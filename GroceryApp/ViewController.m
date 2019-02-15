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
    
    [self storeDeviceID];
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

-(void) setNewList{
   // NSString dkey = [[_ref child:@"/GroceryData"] child:@"deviceID/"].key;

    
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
    
    
    
   // [_ref updateChildValues:childUpdates2];
}

- (IBAction)btFinish:(id)sender {
}
@end
