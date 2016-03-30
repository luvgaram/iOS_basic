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
    UIImage *image;
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    
    int startX = 26;
    int startY = 100;
    
    CGRect myRect;
    
    NSArray *deck0 = [_cardDeck objectAtIndex:0];
    myRect = CGRectMake(startX, startY, cardWidth, cardHeight);
    image = [UIImage imageNamed:[deck0 objectAtIndex:0]];
    CGContextAddRect(myContext, myRect);
    [image drawInRect:myRect];
    
    
}

- (void) drawDeck:(NSArray *)deckName startPosX:(int)startPosX startPosY:(int)startPosY number:(int)number context:(CGContextRef *)context {
    for (int i = 0; i < number; i++) {
        
    }
}

@end
