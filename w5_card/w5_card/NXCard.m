//
//  NXCard.m
//  w5_card
//
//  Created by Eunjoo Im on 2016. 3. 30..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "NXCard.h"

@implementation NXCard

NSString *cardName;
NSArray *cardTypeArray;
NSArray *cardNumberArray;

- (id) initWithType:(int)type Number:(int)number {
    self = [super init];
    
    if (self) {
        cardTypeArray = [NSArray arrayWithObjects:@"c", @"d", @"h", @"s", nil];
        cardNumberArray = [NSArray arrayWithObjects:@"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K", nil];
        
        cardName = [NSString stringWithFormat:@"%@%@", [cardTypeArray objectAtIndex:type], [cardNumberArray objectAtIndex:number]];
    }

    return self;
}

- (NSString*)cardName {
    NSLog(@"%@", cardName);
    return cardName;
}

@end
