//
//  MyView.m
//  w10_number_detect
//
//  Created by Eunjoo Im on 2016. 5. 4..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "MyView.h"

@implementation MyView

NSMutableArray *touchedPoint;

- (void)awakeFromNib {

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    touchedPoint = [[NSMutableArray alloc] init];
    
    UITouch *touch = [touches anyObject];
    CGPoint startPoint = [touch locationInView:self];
    [touchedPoint addObject:[NSValue valueWithCGPoint:startPoint]];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint movePoint = [touch locationInView:self];
    [touchedPoint addObject:[NSValue valueWithCGPoint:movePoint]];
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint endPoint = [touch locationInView:self];
    [touchedPoint addObject:[NSValue valueWithCGPoint:endPoint]];
    
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    [self drawLine];
}

- (void)drawLine {
    NSUInteger touchCount = [touchedPoint count];
    if (touchCount < 2) return;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    float lineWitdh = 3.0;
    
    CGPoint startPoint = [[touchedPoint objectAtIndex:0] CGPointValue];
    [path moveToPoint:startPoint];
    
    for (NSUInteger i = 1; i < touchCount; i++) {
        CGPoint nextPoint = [[touchedPoint objectAtIndex:i] CGPointValue];
        [path addLineToPoint:nextPoint];
        [path setLineWidth:lineWitdh];
        [path stroke];
    }
}

@end
