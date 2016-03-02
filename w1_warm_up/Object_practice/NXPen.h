//
//  NXPen.h
//  Object_practice
//
//  Created by Eunjoo Im on 2016. 3. 2..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXPen : NSObject

@property (strong, nonatomic) NSString *brand;
@property (strong, nonatomic) NSString *color;
@property (readwrite, nonatomic) int usage;

-(id)initWithBrand:(NSString *)aBrand;
-(void)printDescription;

@end
