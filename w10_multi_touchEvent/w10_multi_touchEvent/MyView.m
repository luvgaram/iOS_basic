//
//  MyView.m
//  w10_multi_touchEvent
//
//  Created by Eunjoo Im on 2016. 5. 2..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "MyView.h"

@implementation MyView

CGPoint point1;
CGPoint point2;

- (void)awakeFromNib {
    self.backgroundColor = [UIColor blueColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    point1 = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    point2 = [touch locationInView:self];
    
    CGFloat diff = sqrt((point2.x - point1.x) * (point2.x - point1.x) + (point2.y - point1.y) * (point2.y - point1.y));
    
    self.alpha = 1 - (diff / 600.0f);
//    NSLog(@"alpha: %f", self.alpha);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.alpha = 1;
    
    // plus mission 1: random color
    if ([[event allTouches] count] == 2) {
        CGFloat red = arc4random_uniform(255) / 255.0;
        CGFloat green = arc4random_uniform(255) / 255.0;
        CGFloat blue = arc4random_uniform(255) / 255.0;
        UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        
        self.backgroundColor = color;
    }
    
    // plus mission 2: touch events
    UITouch *touch = [touches anyObject];
    NSUInteger tapCount = [touch tapCount];

    switch (tapCount) {
        case 2:
            self.backgroundColor = [UIColor whiteColor];
            break;
            
        case 3:
            self.backgroundColor = [UIColor blackColor];
            break;
            
        case 4:
            self.backgroundColor = [UIColor blueColor];
            break;
        
        default:
            break;
    }
}

@end
