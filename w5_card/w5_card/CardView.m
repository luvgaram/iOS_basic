//
//  CardView.m
//  w5_card
//
//  Created by Eunjoo Im on 2016. 3. 30..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "CardView.h"

@implementation CardView

int cardWidth = 130;
int cardHeight = 150;

- (void)awakeFromNib {

}

- (void)drawRect:(CGRect)rect {
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    
    int startX = 26;
    int startY = 100;
//    int number = 1;
    
    for (int i = 0; i < 7; i++) {
        [self drawDeck:i startX:startX startY:startY number:i + 1 context:myContext];
        startX += cardWidth + 10;
    }

}

- (void) drawDeck:(int )index startX:(int)startX startY:(int)startY number:(int)number context:(CGContextRef)myContext {
    NSArray *deck = [_cardDeck objectAtIndex:index];
    [self drawCardAtDeck:deck startPosX:startX startPosY:startY startIndex:0 number:number context:myContext];
    [deck release];
    
}
- (void) drawCardAtDeck:(NSArray *)deckName startPosX:(int)startPosX startPosY:(int)startPosY startIndex:(int)index number:(int)number context:(CGContextRef)myContext {
    for (int i = 0; i < number; i++) {
        CGRect myRect = CGRectMake(startPosX, startPosY, cardWidth, cardHeight);
        UIImage *image = [UIImage imageNamed:[deckName objectAtIndex:index++]];
        CGContextAddRect(myContext, myRect);
        [image drawInRect:myRect];
        
        startPosY += 40;
    }
}

@end
