//
//  NXPerson.m
//  W2_Collections
//
//  Created by Eunjoo Im on 2016. 3. 9..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "NXPerson.h"

@implementation NXPerson

- (id)initWithNumber:(NSNumber *)number name: (NSString *)name gender: (NSString *)gender team: (NSNumber *)team {
    self = [super init];
    
    if (self) {
        self.number = number;
        self.name = name;
        self.gender = gender;
        self.team = team;
    }
    
    return self;
}

- (NSComparisonResult)compareName:(NXPerson *)otherPerson {
    return [self.name compare:otherPerson.name];
}

- (NSComparisonResult)compareNumber:(NXPerson *)otherPerson {
    return [self.number compare:otherPerson.number];
}

- (NSComparisonResult)compareTeam:(NXPerson *)otherPerson {
    return [self.team compare:otherPerson.team];
}

@end
