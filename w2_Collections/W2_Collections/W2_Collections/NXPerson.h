//
//  NXPerson.h
//  W2_Collections
//
//  Created by Eunjoo Im on 2016. 3. 9..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXPerson : NSObject

@property NSString *name;
@property NSNumber *number;
@property NSString *gender;
@property NSNumber *team;

- (id)initWithNumber:(NSNumber *)number name: (NSString *)name gender: (NSString *)gender team: (NSNumber *)tean;
- (NSComparisonResult)compareName:(NXPerson *)otherPerson;
- (NSComparisonResult)compareNumber:(NXPerson *)otherPerson;
- (NSComparisonResult)compareTeam:(NXPerson *)otherPerson;

@end
