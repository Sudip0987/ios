

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
NSMutableArray* groceryItemArray;
NSString* deviceID;
NSString* weekKeyForData;
NSString* currentWeekKey;
NSString* currentItemKey;
NSString *cItemName,*cItemPrice,*cItemShopAt;
NSMutableArray *weeklyBudget;
int numberOfItems=0;



int main(int argc, char * argv[]) {
    deviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
