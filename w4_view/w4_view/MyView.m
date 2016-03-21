//
//  MyView.m
//  w4_view
//
//  Created by Eunjoo Im on 2016. 3. 21..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "MyView.h"

@implementation MyView


- (void)drawRect:(CGRect)rect {
//    CGContextRef  myContext = UIGraphicsGetCurrentContext();
//    [[UIColor redColor] setFill];
//    UIRectFill(self.bounds);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGGradientRef gradient = [self gradient];
    CGPoint startPoint = CGPointMake(CGRectGetMidX(self.bounds), 0.0);
    CGPoint endPoint = CGPointMake(CGRectGetMidX(self.bounds),
                  CGRectGetMaxY(self.bounds));
    CGContextDrawLinearGradient(context, gradient,
                                startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    
    [self randomPoints];
    [self drawText:100 yPosition:300 canvasWidth:200 canvasHeight:150];
}

- (CGGradientRef) gradient {
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] = {
        1.0, 1.0, 1.0, 1.0,
        0.0, 0.5, 1.0, 0.8
    };
    return CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 2);
    
//    CGFloat rainbowColors[] = {
//        1.0, 0.0, 0.0, 1.0,
//        1.0, 0.5, 0.0, 1.0,
//        1.0, 1.0, 0.0, 1.0,
//        0.0, 1.0, 0.0, 1.0,
//        0.0, 1.0, 0.5, 1.0,
//        0.0, 0.0, 1.0, 1.0,
//        1.0, 0.0, 1.0, 1.0
//    };
//    CGFloat locations[] = {0, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7};
//
//    return CGGradientCreateWithColorComponents(baseSpace, rainbowColors, locations, 7);
}

- (void) randomPoints {
    CGRect window = [UIScreen mainScreen].bounds;
    int width = window.size.width - 1;
    int height = window.size.height - 1;
    
    for (int i = 0; i < 10; i++) {
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGPoint startPoint = CGPointMake(arc4random() % width, arc4random() % width);
        [path moveToPoint:startPoint];
        CGPoint nextPoint =  CGPointMake(arc4random() % height, arc4random() % height);
        [path addLineToPoint:nextPoint];
        [path setLineWidth:1.0];
        [path stroke];
    }
    
    for (int i = 0; i < 10; i++) {
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGPoint startPoint = CGPointMake(arc4random() % width, arc4random() % height);
        [path moveToPoint:startPoint];
        CGPoint nextPoint =  CGPointMake(arc4random() % width, arc4random() % height);
        [path addLineToPoint:nextPoint];
        [path setLineWidth:1.0];
        [path stroke];
    
        UIBezierPath *aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(arc4random() % width, arc4random() % height) radius:arc4random() % (width / 4) startAngle:0 endAngle:M_PI * 2 clockwise:NO];
        
        CGPoint aStartPoint = CGPointMake(arc4random() % width, arc4random() % height);
        [aPath moveToPoint:aStartPoint];
        CGPoint aNextPoint =  CGPointMake(arc4random() % height, arc4random() % height);
        [aPath addLineToPoint:aNextPoint];
        [aPath setLineWidth:1.0];
        
        [UIColor redColor];
        [UIColor blueColor];
        [UIColor greenColor];
        
        UIColor *fillColor = [self randomColor];
        [fillColor setFill];
        
        [aPath fill];
        [aPath stroke];
        
    }
}

- (void)drawText:(CGFloat)xPosition yPosition:(CGFloat)yPosition canvasWidth:(CGFloat)canvasWidth canvasHeight:(CGFloat)canvasHeight
{
    //Draw Text
    CGRect textRect = CGRectMake(xPosition, yPosition, canvasWidth, canvasHeight);
    NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 30], NSForegroundColorAttributeName: UIColor.grayColor, NSParagraphStyleAttributeName: textStyle};
    
    [@"Hello, World!" drawInRect: textRect withAttributes: textFontAttributes];
}

- (UIColor*) randomColor {
    int randomNum = arc4random() % 3;
    if (randomNum == 1) return [UIColor redColor];
    else if (randomNum == 2) return [UIColor blueColor];
    else return [UIColor greenColor];
}

@end
