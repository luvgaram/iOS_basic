//
//  NXPersonModel.m
//  W2_Collections
//
//  Created by Eunjoo Im on 2016. 3. 9..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "NXPersonModel.h"
#import "NXPerson.h"

@implementation NXPersonModel

NSMutableArray *personList;
NSMutableDictionary *personDictionary;

- (id)init {
    self = [super init];
    
    if (self) {
        personList = [NSMutableArray arrayWithCapacity: 10];
//        NSString *filePath = @"/Users/eunjooim/Dropbox/garam/2016_1/iOS_basic/iOS_basic/w2_Collections/persons.txt";
        
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *filePath = [mainBundle pathForResource:@"persons" ofType:@"txt"];
//        NSString *fileContents = [[NSString alloc] initWithContentsOfFile:filePath];

        
        
        NSError *error;
        NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        
        if (error)
            NSLog(@"Error reading file: %@", error.localizedDescription);
        
        NSLog (@"%@", fileContents);
        
        NSArray *personArray = [fileContents componentsSeparatedByString:@"\n"];
        personDictionary = [NSMutableDictionary dictionary];
        
        for (NSString *person in personArray) {
            NSArray *items = [person componentsSeparatedByString:@","];
            NSNumber *number = [NSNumber numberWithInteger:[[items objectAtIndex:1]integerValue]];
            
//            BOOL gender = [[items objectAtIndex:2]isEqualToString:@"M"];
            NXPerson *newPerson = [[NXPerson alloc] initWithNumber:[NSNumber numberWithInteger:[[items objectAtIndex:1] integerValue]]
                                                              name:[NSString stringWithFormat:[items objectAtIndex:0]]
                                                            gender:[NSString stringWithFormat:[items objectAtIndex:2]]
                                                              team:[NSNumber numberWithInteger:[[items objectAtIndex:3] integerValue]]];

            NSDictionary *aPerson = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [NSString stringWithFormat:[items objectAtIndex:0]],@"name",
                                     [NSNumber numberWithInteger:[[items objectAtIndex:1] integerValue]],@"number",
                                     [NSString stringWithFormat:[items objectAtIndex:2]],@"gender",
                                     [NSNumber numberWithInteger:[[items objectAtIndex:3] integerValue]],@"team",
                                     nil];

            [personDictionary setObject: newPerson forKey:number];
            
            NSLog(@"number: %@", number);
            NSLog(@"%@", [personDictionary objectForKey:number]);
            
            [personList addObject:newPerson];
        }
    }
    
    NSLog(@"count of personDictionary: %ld", [personDictionary count]);
    return self;
}

- (int)population {
    return [personList count];
}

- (NSString*)personNameAtIndex:(int)index {
    NXPerson *targetPerson = [personList objectAtIndex:index];
    return targetPerson.name;
}

- (NSNumber*)personNumberAtIndex:(int)index {
    NXPerson *targetPerson = [personList objectAtIndex:index];
    return targetPerson.number;
}

- (BOOL)isMaleAtIndex:(int)index {
    NXPerson *targetPerson = [personList objectAtIndex:index];
    NSString *targetGender = targetPerson.gender;
    return [targetGender isEqualToString:@"M"];
}

- (NSNumber*)personßTeamAtIndex:(int)index {
    NXPerson *targetPerson = [personList objectAtIndex:index];
    return targetPerson.team;
}

- (NXPerson*)getPersonObjetAtIndex:(int)index {
    return [personList objectAtIndex:index];
}

- (NSString*)findPersonNameByNumber:(NSNumber*)number {
    NXPerson *targetPerson = [personDictionary objectForKey:number];
    return targetPerson.name;
}

- (NSNumber*)findPersonNumberByName:(NSString*)name {
//    NSArray *allPeople = [personDictionary allValues];
    
    for (NXPerson *targetPerson in personList) {
        NSString *targetName = targetPerson.name;
        if ([targetName isEqualToString:name]) {
            return targetPerson.number;
        }
    }
    return NULL;
}

- (NSArray*) sortedByName {
    return [personList sortedArrayUsingSelector:@selector(compareName:)];
    
}

- (NSArray*) sortedByNumber {
    return [personList sortedArrayUsingSelector:@selector(compareNumber:)];
}

- (NSArray*) sortedByTeam {
    return [personList sortedArrayUsingSelector:@selector(compareTeam:)];
}

- (NSString*) showNamesSortedByNumber {
    NSMutableString *personName = [NSMutableString string];
    NSArray *tempArray = [self sortedByNumber];
    for (NXPerson *person in tempArray) {
        [personName appendString:@", "];
        [personName appendString:person.name];
        NSLog(@"%@", personName);
        
    }
    return personName;
}

- (NSArray*) filterByTeam:(NSNumber*)team {
    NSMutableArray *targetPeople = [NSMutableArray arrayWithCapacity: 10];
    for (NXPerson *targetPerson in personList) {
        if ([targetPerson.team intValue] == [team intValue]) {
            [targetPeople addObject:targetPerson];
        }
    }
    return targetPeople;
}

- (NSArray*) filterByGender:(NSString*)gender {
    NSMutableArray *targetPeople = [NSMutableArray arrayWithCapacity: 10];
    for (NXPerson *targetPerson in personList) {
        NSString *targetGender = targetPerson.gender;
        if ([targetGender isEqualToString: gender]) {
            [targetPeople addObject:targetPerson];
        }
    }
    return targetPeople;
}

- (NSArray*) filterDistinctByLastName {
    NSMutableArray *targetPeople = [NSMutableArray arrayWithCapacity: 10];
    NSMutableSet *lastNames = [NSMutableSet setWithCapacity:10] ;
    
    for (NXPerson *targetPerson in personList) {
        NSString *targetName = targetPerson.name;
        NSString *newLastName = [targetName substringWithRange:NSMakeRange(0, 1)];
        [lastNames addObject:newLastName];
    }
    
    for (NSString *lastName in lastNames) {
        [targetPeople addObject:lastName];
    }
    return targetPeople;
}

@end
