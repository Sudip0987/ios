
#import "MyListViewController.h"
#import "CustomCell.h"

@interface MyListViewController (){
    
    NSMutableArray *weeksArray;
    NSMutableArray * dateArray;
    NSMutableArray* currentItemsArray;
    
}

@end

@implementation MyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)prepareData {
    
    
    self.ref = [[FIRDatabase database] reference];
    currentItemsArray = [[NSMutableArray alloc] init];
    
    
    
    [[[self.ref child:@"GroceryData"] queryOrderedByChild:@"Items"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        
        int i=0;
        for(FIRDataSnapshot* snap in snapshot.children){ //looping inside main object ie; snapshot
            if([[snap.value objectForKey:@"deviceID"] isEqualToString:deviceID]){
                i+=1;
                ;
                
                
                if ([[snap.value objectForKey:@"isCurrent"]boolValue]==true){
                    
                    for(FIRDataSnapshot* sn in snap.children){//looping inside second object ie; Items
                        
                        for(FIRDataSnapshot* s in sn.children){ //looping inside each item in items Object
                            
                            GroceryItem *groceryItem = [[GroceryItem alloc]init];
                            [groceryItem setItemName:[s.value objectForKey:@"ItemName"] ];
                            [groceryItem setItemPrice:[[s.value objectForKey:@"ItemPrice"] floatValue]];
                            [groceryItem setShopAt:[s.value objectForKey:@"ShopAt"] ];
                            [groceryItem setShopped:[[s.value objectForKey:@"shopped"]boolValue] ];
                            [groceryItem setItemKey:s.key];
                            NSLog(@"SSS---%@",s.key);
                            
                            [groceryItem setWeekKey: snap.key];
                            //   NSLog(@"SSS---%@",[s.value objectForKey:@"ItemName"]);
                            [currentItemsArray addObject:groceryItem];
                        }
                    }
                }
                
            }
            
            
            
        }
        [self.tableView reloadData];
        
        
    }];
    
    
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self prepareData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return currentItemsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myItemCell" forIndexPath:indexPath];
    if(cell==nil){
        cell=[[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myItemCell"];
    }
    
    
    
    
    
    // Configure the cell...
    GroceryItem* gItem = [[GroceryItem alloc]init];
    gItem =[currentItemsArray objectAtIndex:indexPath.row];
    cell.tbName.text=[gItem ItemName];
    cell.tbPrice.text=[NSString stringWithFormat:@"%.02f",[gItem ItemPrice]];
    cell.tbShop.text=[gItem shopAt];
    
    if([gItem shopped]==false){
        [cell.btDone setTitle:@" X" forState:UIControlStateNormal];
    }else {
        [cell.btDone setTitle:@" ✔" forState:UIControlStateNormal];
        [cell.btDone setEnabled:false];
        
    }
    cell.btDone.tag = indexPath.row;
    [cell.btDone addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}


-(void)buttonClicked:(UIButton*)btn
{
    
    GroceryItem* gItem = [[GroceryItem alloc]init];
    gItem =[currentItemsArray objectAtIndex:btn.tag];
    NSLog(@"%@",[gItem ItemKey]);
    [self tickOffItem:[gItem ItemKey]];
    
}

-(void) tickOffItem:(NSString*) Itemkey{
    // NSLog(@"%@",[gItem ItemKey]);
    
    currentItemsArray = [[NSMutableArray alloc] init];
    
    [[[self.ref child:@"GroceryData"] queryOrderedByChild:@"Items"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        
        int i=0;
        for(FIRDataSnapshot* snap in snapshot.children){ //looping inside main object ie; snapshot
            if([[snap.value objectForKey:@"deviceID"] isEqualToString:deviceID]){
                i+=1;
                ;
                
                
                if ([[snap.value objectForKey:@"isCurrent"]boolValue]==true){
                    
                    for(FIRDataSnapshot* sn in snap.children){//looping inside second object ie; Items
                        
                        for(FIRDataSnapshot* s in sn.children){
                            if([Itemkey isEqualToString:s.key ]){
                                NSLog(@"equal");
                            }
                            
                            NSLog(@"Checking boy:%@/%@/%@/%@",@"GroceryData",snap.key,sn.key,Itemkey);
                            //looping inside each item in items Object
                            
                            // [[[[_ref child:@"GroceryData"] child:snap.key]child:@"isCurrent"] setValue:@false];
                            [[[[[[_ref child:@"GroceryData"] child:snap.key]child:sn.key]child:Itemkey]child:@"shopped"]setValue:@1];
                            
                        }
                    }
                }
                
            }
            
            
            
        }
        [self.tableView reloadData];
        
        
    }];
    
    
    
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

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
