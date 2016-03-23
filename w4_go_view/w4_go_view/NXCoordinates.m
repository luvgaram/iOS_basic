//
//  NXCoordinates.m
//  w4_go_view
//
//  Created by Eunjoo Im on 2016. 3. 23..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "NXCoordinates.h"

@implementation NXCoordinates

- (id)initWithX:(int)x y: (int)y color:(int)color{
    self = [super init];
    
    if (self) {
        self.x = x;
        self.y = y;
        self.color = color;
    }
    
    return self;
}

@end
