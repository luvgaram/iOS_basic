//
//  CardView.m
//  w5_card
//
//  Created by Eunjoo Im on 2016. 3. 30..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "CardView.h"

@implementation CardView

//int myCardWidth = 130;
//int myCardHeight = 150;

- (void)awakeFromNib {
}

//- (void)addSubview:(UIView *)view CardName:(NSString *)cardName PosX:(int)x PosY:(int)y {
//    [super addSubview:view];
//    
//    UIImage *image = [UIImage imageNamed:cardName];
//    UIImageView *cardImage = [[UIImageView alloc] initWithImage:image];
//    [cardImage setFrame:CGRectMake(x, y, myCardWidth, myCardHeight)];
//}
//
//- (void)drawRect:(CGRect)rect {
//    CGContextRef myContext = UIGraphicsGetCurrentContext();
//    
//    int startX = 26;
//    int startY = 100;
////    int number = 1;
//    
//    for (int i = 0; i < 7; i++) {
//        [self drawDeck:i startX:startX startY:startY number:i + 1 context:myContext];
//        startX += myCardWidth + 10;
//    }
//    [self drawLastDeckWithContext:myContext];
//}
//
//- (void) drawDeck:(int)index startX:(int)startX startY:(int)startY number:(int)number context:(CGContextRef)myContext {
//    NSArray *deck = [_cardDeck objectAtIndex:index];
//    [self drawCardAtDeck:deck startPosX:startX startPosY:startY startIndex:0 number:number context:myContext];
//    [deck release];
//}
//
//- (void) drawLastDeckWithContext:(CGContextRef)myContext {
//    [self drawCardAtLastDeck:26 startPosY:500 context:myContext];
//}
//
//- (void) drawCardAtDeck:(NSArray *)deckName startPosX:(int)startPosX startPosY:(int)startPosY startIndex:(int)index number:(int)number context:(CGContextRef)myContext {
//    
//    for (int i = 0; i < number; i++) {
//        CGRect myRect = CGRectMake(startPosX, startPosY, myCardWidth, myCardHeight);
//        UIImage *image = [UIImage imageNamed:[deckName objectAtIndex:index++]];
//        CGContextAddRect(myContext, myRect);
//        [image drawInRect:myRect];
//        
//        startPosY += 40;
//    }
//}
//
//- (void) drawCardAtLastDeck:(int)startPosX startPosY:(int)startPosY context:(CGContextRef)myContext {
//    
//    NSArray *lastDeck = [_cardDeck objectAtIndex:[_cardDeck count] - 1];
//    
//    for (int i = 0; i < 24; i++) {
//        CGRect myRect = CGRectMake(startPosX, startPosY, myCardWidth, myCardHeight);
//        UIImage *image = [UIImage imageNamed:[lastDeck objectAtIndex:i]];
//        CGContextAddRect(myContext, myRect);
//        [image drawInRect:myRect];
//        
//        startPosX += 24;
//    }
//    
//    [lastDeck release];
//}

@end
