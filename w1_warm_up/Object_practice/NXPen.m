//
//  NXPen.m
//  Object_practice
//
//  Created by Eunjoo Im on 2016. 3. 2..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "NXPen.h"

@implementation NXPen

@synthesize brand, color, usage;

-(id)initWithBrand:(NSString *)aBrand {
    self = [super init];
    
    if (self) {
        self.brand = aBrand;
    }
    
    return self;
}

-(void)printDescription {
    NSLog(@"brand: %@, color: %@, usage: %d", self.brand, self.color, usage);
}

@end
