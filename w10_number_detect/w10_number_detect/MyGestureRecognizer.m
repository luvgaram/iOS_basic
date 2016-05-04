//
//  MyGestureRecognizer.m
//  w10_number_detect
//
//  Created by Eunjoo Im on 2016. 5. 4..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "MyGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation MyGestureRecognizer

NSMutableArray *touchedPoints;
NSMutableArray *directions;
int directionCount;
NSNumber *one;
NSNumber *two;
NSNumber *three;
NSNumber *four;

- (void)reset {
    [super reset];
    self.state = UIGestureRecognizerStatePossible;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    one = [NSNumber numberWithInt:1];
    two = [NSNumber numberWithInt:2];
    three = [NSNumber numberWithInt:3];
    four = [NSNumber numberWithInt:4];
    
    touchedPoints = [[NSMutableArray alloc] init];
    directions = [[NSMutableArray alloc] init];
    
    UITouch *touch = [touches anyObject];
    CGPoint startPoint = [touch locationInView:self.view];
    [touchedPoints addObject:[NSValue valueWithCGPoint:startPoint]];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint movePoint = [touch locationInView:self.view];
    
    CGPoint prePoint = [[touchedPoints objectAtIndex:[touchedPoints count] - 1] CGPointValue];
    
    // 일정 거리 이상만 move로 넣기
    if ([self measureDistanceFirst:prePoint withSecond:movePoint] > 30) {
        [touchedPoints addObject:[NSValue valueWithCGPoint:movePoint]];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint endPoint = [touch locationInView:self.view];
    [touchedPoints addObject:[NSValue valueWithCGPoint:endPoint]];
    
    _result = [self checkGesture];
    
//    if (_result == -1) self.state = UIGestureRecognizerStateFailed;
    self.state = UIGestureRecognizerStateEnded;
}

- (int)checkGesture {
    NSUInteger touchCount = [touchedPoints count];
    NSLog(@"touchCount: %d", touchCount);

    if (touchCount < 1) return -1;
    [self recordDirections:touchCount];
    
    directionCount = [directions count];
    NSLog(@"directionCount: %d", directionCount);
    return [self checkNumberWithDirections];
}

- (int)checkNumberWithDirections {
    // 획이 1개면 1로 처리
    if (directionCount == 1) {
        NSLog(@"result: 1");
        return 1;
    }
    
    if (![[directions objectAtIndex:0] isEqualToNumber:one]) {
        if ([self checkOne] == 1) {
            NSLog(@"result: 1");
            return 1;
        } else if ([self checkZeroNSix] == 0) {
            NSLog(@"result: 0");
            return 0;
        } else if ([self checkZeroNSix] == 6) {
            NSLog(@"result: 6");
            return 6;
        } else {
            NSLog(@"no gesture!!!");
            return -1;
        }
    } else {
        if ([self checkTwoNThree]) {
            NSLog(@"result %d:", [self checkTwoNThree]);
            return [self checkTwoNThree];
        }
    }
    return -1;
}

- (int)checkZeroNSix {
    NSLog(@"check 0 begin");
    
    CGPoint startPoint = [[touchedPoints objectAtIndex:0] CGPointValue];
    CGPoint endPoint = [[touchedPoints objectAtIndex:[touchedPoints count] - 1] CGPointValue];
    
    if ([[directions objectAtIndex:0] isEqualToNumber:three] &&
        [[directions objectAtIndex:1] isEqualToNumber:two] &&
        [[directions objectAtIndex:2] isEqualToNumber:one] &&
        [[directions objectAtIndex:3] isEqualToNumber:four]) {
        
        if ([self measureDistanceFirst:startPoint withSecond:endPoint] < 50) {
            return 0;
        }
        
        if ([[directions objectAtIndex:directionCount - 1] isEqualToNumber:three] ||
            [[directions objectAtIndex:directionCount - 1] isEqualToNumber:four])
            return 6;
    }
    
    return -1;
}

- (int)checkTwoNThree {
    NSLog(@"check 3 begin");
    
    if (directionCount < 5) return 0;
    
    if (![[directions objectAtIndex:0] isEqualToNumber:one] ||
        ![[directions objectAtIndex:1] isEqualToNumber:two] ||
        ![[directions objectAtIndex:2] isEqualToNumber:three]) {
        NSLog(@"-1");
        return -1;
    }
    
    if ([[directions objectAtIndex:3] isEqualToNumber:one] || [[directions objectAtIndex:3] isEqualToNumber:four]) {
        NSLog(@"-1");
        return -1;
    } else if ([[directions objectAtIndex:directionCount - 1] isEqualToNumber:three] || [[directions objectAtIndex:directionCount - 1] isEqualToNumber:four]) {
        NSLog(@"3");
        return 3;
    } else {
        NSLog(@"2");
        return 2;
    }
}

- (int)checkOne {
    NSLog(@"check 1 begin");
    
    for (int i = 1; i < directionCount; i++) {
        NSLog(@"now direction [%d]: %@", i, [directions objectAtIndex:i]);
        
        if ([[directions objectAtIndex:i] isEqualToNumber:one] || directionCount > 3) {
            NSLog(@"no gesture!!!");
            return -1;
        }
    }
    return 1;
}

- (void)recordDirections:(NSUInteger)touchCount {
    CGPoint firstPoint = [[touchedPoints objectAtIndex:0] CGPointValue];
    
    // start direction
    NSNumber *direction = [self checkDirectionFirst:firstPoint with:[[touchedPoints objectAtIndex:1] CGPointValue]];
    
    [directions addObject:direction];
    NSLog(@"first direction %@", [directions objectAtIndex:0]);
    
    for (NSUInteger i = 1; i < touchCount; i++) {
        CGPoint currentPoint = [[touchedPoints objectAtIndex:i] CGPointValue];
        
        NSNumber *curDirection = [self checkDirectionFirst:[[touchedPoints objectAtIndex:i - 1] CGPointValue] with:currentPoint];
        
//        NSLog(@"curDirection: %@", curDirection);
        [self addDirectionIfChanged:curDirection];
    }
}

- (void)addDirectionIfChanged:(NSNumber*)curDirection {
    if (![curDirection isEqualToNumber:[directions objectAtIndex:[directions count] - 1]]) {
        [directions addObject:curDirection];
        NSLog(@"direction changed to %@", curDirection);
    }
}

- (NSNumber*)checkDirectionFirst:(CGPoint)first with:(CGPoint)second {
    Boolean checkX = [self checkXPositionFirst:first with:second];
    Boolean checkY = [self checkYPositionFirst:first with:second];
    
    if (checkX == YES && checkY == NO) return [NSNumber numberWithInt:1];
    if (checkX == YES && checkY == YES) return [NSNumber numberWithInt:2];
    if (checkX == NO && checkY == YES) return [NSNumber numberWithInt:3];
    if (checkX == NO && checkY == NO) return [NSNumber numberWithInt:4];
    
    return 0;
}

- (Boolean)checkXPositionFirst:(CGPoint)first with:(CGPoint)second {
    if (first.x < second.x) return YES;
    return NO;
}

- (Boolean)checkYPositionFirst:(CGPoint)first with:(CGPoint)second {
    if (first.y < second.y) return YES;
    return NO;
}

- (double)measureDistanceFirst:(CGPoint)first withSecond:(CGPoint) second {
    return sqrt((first.x - second.x) * (first.x - second.x) + (first.y - second.y) * (first.y - second.y));
}

@end
