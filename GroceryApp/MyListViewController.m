//
//  MyListViewController.m
//  GroceryApp
//
//  Created by Sudip Sharma on 20/1/19.
//  Copyright © 2019 Sudip Sharma. All rights reserved.
//

#import "MyListViewController.h"
#import "CustomCell.h"

@interface MyListViewController (){
    
    NSMutableArray *weeksArray;
    NSMutableArray * dateArray;
}

@end

@implementation MyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // weeksArray =[NSMutableArray arrayWithArray:@[@"Week 6",@"Week 5",@"Week 4",@"Week 3",@"Week 2",@"Week 1"]];
 //   dateArray = [NSMutableArray arrayWithArray:@[@"January 20",@"January 13",@"January 5",@"December 28",@"December 21",@"December 15"]];
    

    CustomCell *cell1 = [[CustomCell alloc]init];
    CustomCell *cell2 = [[CustomCell alloc]init];
    CustomCell *cell3 = [[CustomCell alloc]init];
    CustomCell *cell4 = [[CustomCell alloc]init];

    

    
    _arrayDate=[[NSMutableArray alloc]initWithObjects:cell1,cell2,cell3,cell4,nil];
    
    // Uncomment the following li
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)prepareData {
    self.ref = [[FIRDatabase database] reference];
    
    
    
    [[[self.ref child:@"GroceryData"] queryOrderedByChild:@"Items"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSDictionary *usersDict = snapshot.value;
        
        
        int i=0;
        
        for(FIRDataSnapshot* snap in snapshot.children){ //looping inside main object ie; snapshot
            i+=1;
            for(FIRDataSnapshot* sn in snap.children){//looping inside second object ie; Items
                for(FIRDataSnapshot* s in sn.children){ //looping inside each item in items Object
                    NSLog(@"Inf : %@", [s.value objectForKey:@"ItemName"]);
                    
                    
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
    return _arrayDate.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myItemCell" forIndexPath:indexPath];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myItemCell"];
    }
    
    
    
    
    
    CustomCell *mainCell = [_arrayDate objectAtIndex:indexPath.row];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *priceLabel = (UILabel *)[cell viewWithTag:2];
    UILabel *shopAtLabel = (UILabel *)[cell viewWithTag:3];
    UIButton *doneButton = (UIButton *)[cell viewWithTag:4];
    nameLabel.text=mainCell.itemName;
    priceLabel.text = mainCell.itemPrice;
    shopAtLabel.text = mainCell.itemShopAt;
    doneButton.titleLabel.text= mainCell.itemButton;
    // Configure the cell...
    
    return cell;
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
