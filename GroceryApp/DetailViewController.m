
#import "DetailViewController.h"
@interface DetailViewController (){
   NSMutableArray *itemNameArray;
    NSMutableArray *itemPriceArray;
    
 
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    
    //remove this
    
    
    [super viewDidLoad];
    
    
;
   // itemPriceArray = [NSMutableArray arrayWithArray:@[@"10$",@"15$",@"07$",@"10$",@"15$",@"05$",@"30$"]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return numberOfItems;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell" forIndexPath:indexPath];
    itemNameArray  = [[NSMutableArray alloc] init];
    itemPriceArray = [[NSMutableArray alloc] init];
    // Configure the cell...
    for(GroceryItem *gItem in groceryItemArray){
        if([[gItem weekKey] isEqualToString:weekKeyForData]){
            [itemNameArray addObject:[gItem ItemName]];
            [itemPriceArray addObject:[NSString stringWithFormat:@"%.f$",[gItem ItemPrice]]];
        }
    }
    cell.textLabel.text= [itemNameArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [itemPriceArray objectAtIndex:indexPath.row];
        //cell.textLabel.text = [[groceryItemArray objectAtIndex:indexPath.row] ItemName ];
      //  cell.detailTextLabel.text = [NSString stringWithFormat:@"%.02f",[[groceryItemArray objectAtIndex:indexPath.row] ItemPrice]];
        
  //  }
    return cell;
}

- (void)viewDidDisappear:(BOOL)animated{
    
    NSLog(@"back");
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
