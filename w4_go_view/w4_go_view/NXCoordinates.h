//
//  NXCoordinates.h
//  w4_go_view
//
//  Created by Eunjoo Im on 2016. 3. 23..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXCoordinates : NSObject

@property int color;
@property int x;
@property int y;

- (id)initWithX:(int)x y: (int)y color:(int)color;

@end
