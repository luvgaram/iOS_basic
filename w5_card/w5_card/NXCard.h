//
//  NXCard.h
//  w5_card
//
//  Created by Eunjoo Im on 2016. 3. 30..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXCard : NSObject

- (id)initWithType:(int)type Number:(int)number;
- (NSString*)cardName;

@end
