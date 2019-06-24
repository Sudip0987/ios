//
//  DrawGraph.m
//  GroceryApp
//
//  Created by Sudip Sharma on 17/2/19.
//  Copyright © 2019 Sudip Sharma. All rights reserved.
//

#import "DrawGraph.h"

@implementation DrawGraph

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)drawRect:(CGRect)rect{
   

    
   NSMutableArray * data = [[NSMutableArray alloc]init];
    int budget = 25;
    for(int i=0;i<10;i++){
        budget+=budget;
        [data addObject:[NSString stringWithFormat:@"Week %d",i]];
    }
    //converting ui color to core graphics color
    CGColorRef yellow = [[UIColor yellowColor]CGColor];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, self.bounds);

    for(int i=20;i<1000;i=i+20){
    
    //clear the contents before drawing a rectangle
    CGContextSetFillColorWithColor(context, yellow);
    CGContextFillRect(context, CGRectMake(20,i,100+i,15));
        
    }
    
}


- (void)dealloc
{
}
@end
