//
//  SolitaireDeck.m
//  w5_card
//
//  Created by Eunjoo Im on 2016. 3. 30..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "SolitaireDeck.h"
#import "NXCard.h"

@implementation SolitaireDeck

NSMutableArray *listedCardDeck;
NSMutableArray *shuffled;


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
    
    [deck0 release];
    [deck1 release];
    [deck2 release];
    [deck3 release];
    [deck4 release];
    [deck5 release];
    [deck6 release];
    [deck7 release];
    
    return shuffled;
}

- (void) prepareCardDeckList {
    listedCardDeck = [[NSMutableArray alloc]init];
    NSArray *randomArray = [self randomUniqueNumberArrayFrom:0 to:51];
    
    
    int i = 0;
    
    for (NSNumber *number in randomArray) {
        int intNum = [number intValue];
        int intForCardNum = (intNum) % 13;
        int intForCardType = floor((intNum) / 13);
    
        NXCard *newCard = [[NXCard alloc]initWithType:intForCardType Number:intForCardNum];
        NSString *cardName = [newCard cardName];
        
        NSLog(@"@now %d : %d, %d", i++, intForCardNum, intForCardType);
        [listedCardDeck addObject:cardName];
        [newCard release];
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
    return [randomArray autorelease];
}

@end
