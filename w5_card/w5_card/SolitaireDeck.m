//
//  SolitaireDeck.m
//  w5_card
//
//  Created by Eunjoo Im on 2016. 3. 30..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "SolitaireDeck.h"

@implementation SolitaireDeck

NSArray *cardType;
NSArray *cardNumber;
NSMutableArray *listedCardDeck;
NSMutableArray *shuffled;

- (id) init {
    self = [super init];
    
    if (self) {
        cardType = [NSArray arrayWithObjects:@"c", @"d", @"h", @"s", nil];
        cardNumber = [NSArray arrayWithObjects:@"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K", nil];
    }
    return self;

}


- (NSArray *) shuffleCards {
    shuffled = [[NSMutableArray alloc] init];

    [self prepareCardDeckList];
    
    NSMutableArray *deck0 = [[NSMutableArray alloc]init];
    NSMutableArray *deck1 = [[NSMutableArray alloc]init];
    NSMutableArray *deck2 = [[NSMutableArray alloc]init];
    NSMutableArray *deck3 = [[NSMutableArray alloc]init];
    NSMutableArray *deck4 = [[NSMutableArray alloc]init];
    NSMutableArray *deck5 = [[NSMutableArray alloc]init];
    NSMutableArray *deck6 = [[NSMutableArray alloc]init];
    NSMutableArray *deck7 = [[NSMutableArray alloc]init];
    
    int loop = 1;
    int index = 0;

    index = [self addCardsToTargetDeck:deck0 cardAtIndex:index loopNum:loop++];
    index = [self addCardsToTargetDeck:deck1 cardAtIndex:index loopNum:loop++];
    index = [self addCardsToTargetDeck:deck2 cardAtIndex:index loopNum:loop++];
    index = [self addCardsToTargetDeck:deck3 cardAtIndex:index loopNum:loop++];
    index = [self addCardsToTargetDeck:deck4 cardAtIndex:index loopNum:loop++];
    index = [self addCardsToTargetDeck:deck5 cardAtIndex:index loopNum:loop++];
    index = [self addCardsToTargetDeck:deck6 cardAtIndex:index loopNum:loop++];
    [self addCardsToTargetDeck:deck7 cardAtIndex:index loopNum:24];
    
    [shuffled addObject:deck0];
    [shuffled addObject:deck1];
    [shuffled addObject:deck2];
    [shuffled addObject:deck3];
    [shuffled addObject:deck4];
    [shuffled addObject:deck5];
    [shuffled addObject:deck6];
    [shuffled addObject:deck7];
    
    return shuffled;
}

- (void) prepareCardDeckList {
    listedCardDeck = [[NSMutableArray alloc]init];
    NSArray *randomArray = [self randomUniqueNumberArrayFrom:0 to:51];
    
    for (NSNumber *number in randomArray) {
        int intNum = [number intValue];
        int intForCardNum = (intNum) % 13;
        int intForCardType = floor((intNum) / 13);
        
        NSString *cardName =  [NSString stringWithFormat:@"%@%@",
                               [cardType objectAtIndex:intForCardType],
                               [cardNumber objectAtIndex:intForCardNum]];
        [listedCardDeck addObject:cardName];
        
//        NSLog(@"%d : %d, %d = %@", intNum, intForCardType, intForCardNum, cardName);
    }
}

- (int) addCardsToTargetDeck:(NSMutableArray*)targetDeck cardAtIndex:(int)cardAtIndex loopNum:(int)loop {
    for (int i = 0; i < loop; i++ ) {
        [targetDeck addObject:[listedCardDeck objectAtIndex:cardAtIndex++]];
    }
    
    return cardAtIndex;
}

- (void) displayCards {
    for (NSArray *array in shuffled) {
        NSLog(@"%@", array);
    }
}



// http://stackoverflow.com/questions/8050681/generating-unique-random-number-in-objective-c
-(NSArray *)randomUniqueNumberArrayFrom:(int)rangeLow to:(int)rangeHigh{
    NSMutableArray *randomArray = [[NSMutableArray alloc] init];
    int randNum = arc4random() % (rangeHigh-rangeLow+1) + rangeLow;
    int counter = 0;
    while (counter < rangeHigh - rangeLow + 1) {
        if (![randomArray containsObject:[NSNumber numberWithInt:randNum]]) {
            [randomArray addObject:[NSNumber numberWithInt:randNum]];
            counter++;
        } else {
            randNum = arc4random() % (rangeHigh-rangeLow+1) + rangeLow;
        }
        
    }
//    NSLog(@"UNIQUE ARRAY %@",randomArray);
    return randomArray;
    
}

@end
