//
//  HistoryViewController.m
//  GroceryApp
//
//  Created by Sudip Sharma on 20/1/19.
//  Copyright © 2019 Sudip Sharma. All rights reserved.
//

#import "HistoryViewController.h"
@interface HistoryViewController (){
    
    
}
@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)prepareData {
    
    
    self.ref = [[FIRDatabase database] reference];
    _dateArray = [[NSMutableArray alloc] init];
    _weeksArray = [[NSMutableArray alloc] init];
    _weekKeyArray = [[NSMutableArray alloc] init];

    groceryItemArray = [[NSMutableArray alloc] init];

    
    [[[self.ref child:@"GroceryData"] queryOrderedByChild:@"date"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        
        int i=0;
        for(FIRDataSnapshot* snap in snapshot.children){ //looping inside main object ie; snapshot
            if([[snap.value objectForKey:@"deviceID"] isEqualToString:deviceID]){
                i+=1;
                [self.weeksArray addObject:[NSString stringWithFormat:@"Week %d",i]];
                if(![self->_weekKeyArray containsObject:snap.key]){
                 [self.weekKeyArray addObject:snap.key];
                    [self->_dateArray addObject:[snap.value objectForKey:@"date"]];
                }
                for(FIRDataSnapshot* sn in snap.children){//looping inside second object ie; Items
                    
                    for(FIRDataSnapshot* s in sn.children){ //looping inside each item in items Object

                       GroceryItem *groceryItem = [[GroceryItem alloc]init];
                        
                        [groceryItem setItemName:[s.value objectForKey:@"ItemName"] ];
                        [groceryItem setItemPrice:[[s.value objectForKey:@"ItemPrice"] floatValue]];
                        [groceryItem setShopAt:[s.value objectForKey:@"ShopAt"] ];
                        [groceryItem setItemKey:s.key];
                        [groceryItem setWeekKey: snap.key];
                        [groceryItemArray addObject:groceryItem];
                    }
                }
            }
     
            

        }
        [self.tableView reloadData];


    }];
    
 
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}
- (void)viewWillAppear:(BOOL)animated{
    [self prepareData];

    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _weeksArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weekCell" forIndexPath:indexPath];
  
    cell.textLabel.text = _weeksArray[indexPath.row];
    cell.detailTextLabel.text = _dateArray[indexPath.row];
  
  

    
    return cell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    weekKeyForData = _weekKeyArray[indexPath.row];
    numberOfItems=0;
    for (GroceryItem *gItem in groceryItemArray ){
        if([[gItem weekKey]isEqualToString:weekKeyForData ]){
            numberOfItems +=1;

        }
    }
   
}

 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
