//
//  MyGestureRecognizer.m
//  w10_multi_touchEvent
//
//  Created by Eunjoo Im on 2016. 5. 2..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "MyGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation MyGestureRecognizer

BOOL first;
BOOL second;

NSMutableArray *points;

- (void)reset {
    [super reset];
    
    points = nil;
    self.state = UIGestureRecognizerStatePossible;
    first = NO;
    second = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    points = [NSMutableArray array];
    UITouch *touch = [touches anyObject];
    [points addObject:[NSValue valueWithCGPoint:[touch locationInView:self.view]]];
    
    NSLog(@"touch began");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint previousPoint = [[points objectAtIndex:[points count] - 1] CGPointValue];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    if ((second == NO) && (previousPoint.x < currentPoint.x) && (previousPoint.y < currentPoint.y)) {
        NSLog(@"now going down right");
        [points addObject: [NSValue valueWithCGPoint:
                            [touch locationInView:self.view]]];
        first = YES;
    } else if ((first == YES) && (previousPoint.x < currentPoint.x) && (previousPoint.y > currentPoint.y)) {
        NSLog(@"now going up right");
        [points addObject: [NSValue valueWithCGPoint:
                            [touch locationInView:self.view]]];
        
        second = YES;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ((first == YES) && (second == YES)) {
        NSLog(@"checked!");
        self.state = UIGestureRecognizerStateEnded;
    } else self.state = UIGestureRecognizerStateFailed;
    
    first = NO;
    second = NO;
    
}
@end
