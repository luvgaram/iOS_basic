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
    
//    NSLog(@"절대값: %f", fabs(prePoint.x - movePoint.x) + fabs(prePoint.y - movePoint.y));
    
    // 일정 거리 이상만 move로 넣기
    if (fabs(prePoint.x - movePoint.x) + fabs(prePoint.y - movePoint.y) > 20) {
        [touchedPoints addObject:[NSValue valueWithCGPoint:movePoint]];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint endPoint = [touch locationInView:self.view];
    [touchedPoints addObject:[NSValue valueWithCGPoint:endPoint]];
    
    [self checkGesture];
    
    self.state = UIGestureRecognizerStateEnded;
}

- (void)checkGesture {
    NSUInteger touchCount = [touchedPoints count];
    NSLog(@"touchCount: %d", touchCount);

    if (touchCount < 1) return;
    [self recordDirections:touchCount];
    
    directionCount = [directions count];
    NSLog(@"directionCount: %d", directionCount);
    [self checkNumberWithDirections];
    
}

- (int)checkNumberWithDirections {
    int result = 0;
    
    // 획이 1개면 1로 처리
    if (directionCount == 1) {
        NSLog(@"result: 1");
        return 1;
    }
    
    if (![[directions objectAtIndex:0] isEqualToNumber:one]) {
        if ([self checkOne]) {
            NSLog(@"result: 1");
            return 1;
        } else {
            NSLog(@"no gesture!!!");
        }
    } else {
        if ([self checkThree]) {
            NSLog(@"result %d:", [self checkThree]);
            return [self checkThree];
        }
    }
    
    NSLog(@"result: %d", result);
    return result;
}

- (int)checkThree {
    NSLog(@"check 3 begin");
    int result = 0;
    
    if (directionCount < 5 || directionCount > 8) return 0;
    
    if (![[directions objectAtIndex:0] isEqualToNumber:one] ||
        ![[directions objectAtIndex:1] isEqualToNumber:two] ||
        ![[directions objectAtIndex:2] isEqualToNumber:three]) {
        NSLog(@"0");
        return 0;
    }
    
    if ([[directions objectAtIndex:3] isEqualToNumber:one] || [[directions objectAtIndex:3] isEqualToNumber:four]) {
        NSLog(@"0");
        return 0;
    } else if ([[directions objectAtIndex:directionCount - 1] isEqualToNumber:three] || [[directions objectAtIndex:directionCount - 1] isEqualToNumber:three]) {
        NSLog(@"3");
        return 3;
    } else {
        NSLog(@"2");
        return 2;
    }
}

- (BOOL)checkOne {
    NSLog(@"check 1 begin");
    
    for (int i = 1; i < directionCount; i++) {
        NSLog(@"now direction [%d]: %@", i, [directions objectAtIndex:i]);
        
        if ([[directions objectAtIndex:i] isEqualToNumber:one]) {
            NSLog(@"no gesture!!!");
            return NO;
        }
    }
    
    return YES;
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
//    if (directionCount > 1) return;
    
//    NSLog(@"direction is %@", curDirection);
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

@end
