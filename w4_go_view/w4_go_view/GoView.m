//
//  GoView.m
//  w4_go_view
//
//  Created by Eunjoo Im on 2016. 3. 23..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "GoView.h"

@implementation GoView

CGPoint touchedPoint;
UIImage *bgImage;
UIImage *whiteImage;
UIImage *blackImage;

int turn;
int stones[11][11];
int showStoneX = -1;
int showStoneY = -1;

- (void)awakeFromNib {
    turn = 0;
    bgImage = [UIImage imageNamed:@"oak"];
    whiteImage = [UIImage imageNamed:@"white"];
    blackImage = [UIImage imageNamed:@"black"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setTempStone:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setTempStone:touches];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    showStoneX = -1;
    showStoneY = -1;
    
    UITouch *aTouch = [touches anyObject];
    touchedPoint = [aTouch locationInView:self];

    int x = touchedPoint.x / 30;
    int y = (touchedPoint.y - 20) / 30;
    
    if (x < 0 || x > 10 || y < 0 || y > 10) return;
    
    if (stones[x][y] == 0) {
        turn++;
        stones[x][y] = (turn % 2) + 1;
    
        [self setNeedsDisplay];
    }
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        for (int i = 0; i < 11; i++) {
            for (int j = 0; j < 11; j++) {
                stones[i][j] = 0;
            }
        }
    }
    
    [self setNeedsDisplay];
}

- (void)setTempStone:(NSSet<UITouch *> *)touches {
    UITouch *aTouch = [touches anyObject];
    touchedPoint = [aTouch locationInView:self];
    
    showStoneX = touchedPoint.x / 30;
    showStoneY = (touchedPoint.y - 20) / 30;
    
    if (showStoneX < 0 || showStoneX > 10 || showStoneY < 0 || showStoneY > 10 || stones[showStoneX][showStoneY] != 0) {
        showStoneX = -1;
        showStoneY = -1;
    } else {
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    
    [bgImage drawInRect:rect];
    [self drawBoard];
    
    [self drawStones:myContext];

}

- (void)drawStones:(CGContextRef) myContext {
    for (int i = 0; i < 11; i++) {
        int countBlack = 0;
        int countWhite = 0;
        
        for (int j = 0; j < 11; j++) {
            if (stones[i][j] == 1) {
                [self drawWhiteWithX:i * 30 y:(j * 30) + 30 context:myContext];
                countWhite++;
            } else if (stones[i][j] == 2) {
                [self drawBlackWithX:i * 30 y:(j * 30) + 30 context:myContext];
                countBlack++;
            }
        }
        
        if (countBlack > countWhite) {
            CGRect blackCountRect = CGRectMake(i * 30, 350, 20, 10 * countBlack);
            [[UIColor blackColor] setFill];
            CGContextFillRect(myContext, blackCountRect);
        } else if (countWhite > countBlack) {
            CGRect whiteCountRect = CGRectMake(i * 30, 350, 20, 10 * countWhite);
            [[UIColor whiteColor] setFill];
            CGContextFillRect(myContext, whiteCountRect);
        }
    }
    
    [self showStoneLocation:myContext];
}

- (void)showStoneLocation:(CGContextRef) myContext {
    if (showStoneX != -1 && showStoneY != -1) {
        if (turn % 2 == 0) {
            [self drawBlackWithX:showStoneX * 30 y:(showStoneY * 30) + 30 context:myContext];
        } else {
            [self drawWhiteWithX:showStoneX * 30 y:(showStoneY * 30) + 30 context:myContext];
        }
    }
}

- (void)drawBlackWithX:(int)x y:(int)y context:(CGContextRef) myContext {
    CGRect rect = CGRectMake(x, y, 20, 20);
    CGContextAddRect(myContext, rect);
    [blackImage drawInRect:rect];
}

- (void)drawWhiteWithX:(int)x y:(int)y context:(CGContextRef) myContext {
    CGRect rect = CGRectMake(x, y, 20, 20);
    CGContextAddRect(myContext, rect);
    [whiteImage drawInRect:rect];
}


- (void)drawBoard {
    float x = 10;
    float y = 40;
    
    for (int i = 0; i < 11; i++) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        CGPoint startPoint = CGPointMake(x, 40.0);
        [path moveToPoint:startPoint];
        CGPoint nextPoint = CGPointMake(x, 340.0);
        [path addLineToPoint:nextPoint];
        [path setLineWidth:1.0];
        [path stroke];
        
        UIBezierPath *pathY = [UIBezierPath bezierPath];
        
        CGPoint startPointY = CGPointMake(10.0, y);
        [pathY moveToPoint:startPointY];
        CGPoint nextPointY = CGPointMake(310.0, y);
        [pathY addLineToPoint:nextPointY];
        [pathY setLineWidth:1.0];
        [pathY stroke];
        
        x += 30;
        y += 30;
    }
}

@end
