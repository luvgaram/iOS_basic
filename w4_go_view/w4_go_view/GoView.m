//
//  GoView.m
//  w4_go_view
//
//  Created by Eunjoo Im on 2016. 3. 23..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "GoView.h"
#import "NXCoordinates.h"

@implementation GoView

CGPoint touchedPoint;

UIImage *bgImage;
UIImage *whiteImage;
UIImage *blackImage;
int turn;
NSMutableArray *stonesArray;
int stones[11][11];

- (void)awakeFromNib {
    stonesArray = [[NSMutableArray alloc]init];
    turn = 0;
    bgImage = [UIImage imageNamed:@"oak"];
    whiteImage = [UIImage imageNamed:@"white"];
    blackImage = [UIImage imageNamed:@"black"];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UITouch *aTouch = [touches anyObject];
    touchedPoint = [aTouch locationInView:self];
    

    int x = touchedPoint.x / 30;
    int y = (touchedPoint.y - 20) / 30;
    
    if (stones[x][y] == 0) {
        turn++;
    
        NSLog(@"%d: [%d, %d]", turn, x, y);
        NXCoordinates *newStone = [[NXCoordinates alloc]initWithX:x y:y color:turn % 2];
    
        [stonesArray addObject:newStone];
    
        stones[x][y] = (turn % 2) + 1;
    
        [self setNeedsDisplay];
    }
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        for (int i = 0; i < 12; i++) {
            for (int j = 0; j < 12; j++) {
                stones[i][j] = 0;
            }
        }
    }
    
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    CGContextRef myContext = UIGraphicsGetCurrentContext();

    [bgImage drawInRect:rect];
    [self drawBoard];
    
    for (int i = 0; i < 12; i++) {
        for (int j = 0; j < 12; j++) {
            if (stones[i][j] == 1) {
                CGRect blackRect = CGRectMake(i * 30, (j * 30) + 30, 20, 20);
                CGContextAddRect(myContext, blackRect);
                [blackImage drawInRect:blackRect];
            } else if (stones[i][j] == 2) {
                CGRect whiteRect = CGRectMake(i * 30, (j * 30) + 30, 20, 20);
                CGContextAddRect(myContext, whiteRect);
                [whiteImage drawInRect:whiteRect];
            }
        }
    }
    
//    for (NXCoordinates *stone in stonesArray) {
//        int posX = stone.x;
//        int posY = stone.y;
//        
//        if (stone.color == 1) {
//            CGRect whiteRect = CGRectMake(posX * 30, (posY * 30) + 30, 20, 20);
//            CGContextAddRect(myContext, whiteRect);
//            [whiteImage drawInRect:whiteRect];
//        } else {
//            CGRect blackRect = CGRectMake(posX * 30, (posY * 30) + 30, 20, 20);
//            CGContextAddRect(myContext, blackRect);
//            [blackImage drawInRect:blackRect];
//        }
//        
//        NSLog(@"%d: [%d, %d]", stone.color, posX * 30, (posY * 30) + 30);
//    }
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
