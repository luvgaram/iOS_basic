//
//  main.m
//  W2_Collections
//
//  Created by Eunjoo Im on 2016. 3. 9..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXPersonModel.h"
#import "NXPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NXPersonModel *aPersonModel = [[NXPersonModel alloc]init];
        int count = [aPersonModel population];

        for (int i = 0; i < count; i++) {
            NSLog(@"personNameAtIndex %d, %@", i, [aPersonModel personNameAtIndex:i]);
            NSLog(@"personNumberAtIndex %d, %@", i, [aPersonModel personNumberAtIndex:i]);
            NSLog(@"isMaleAtIndex %d, %hhd", i, [aPersonModel isMaleAtIndex:i]);
//            NSLog(@"personTeamAtIndex %d, %@", i, [aPersonModel personTeamAtIndex: i]);
            NSLog(@"getPersonObjetAtIndex %d, %@", i, [aPersonModel getPersonObjetAtIndex: i]);
        }
        
        NSLog(@"name of 141072, %@",[aPersonModel findPersonNameByNumber:[NSNumber numberWithInt:141072]]);
        NSLog(@"number of 임은주, %@", [aPersonModel findPersonNumberByName: @"임은주"]);
        
        NSArray *sortedByName = [aPersonModel sortedByName];
        for (NXPerson *aPerson in sortedByName) {
            NSLog(@"%@", aPerson.name);
        }
        
        NSArray *sortedByNumber = [aPersonModel sortedByNumber];
        for (NXPerson *aPerson in sortedByName) {
            NSLog(@"%@", aPerson.number);
        }
        
        NSArray *sortedByTeam = [aPersonModel sortedByTeam];
        for (NXPerson *aPerson in sortedByTeam) {
            NSLog(@"%@", aPerson.team);
        }
        
        NSArray *filteredByTeam = [aPersonModel filterByTeam:[NSNumber numberWithInt:1]];
        for (NXPerson *aPerson in filteredByTeam) {
            NSLog(@"team 1: %@", aPerson.name);
        }
        
        NSArray *filteredByGender = [aPersonModel filterByGender:@"M"];
        for (NXPerson *aPerson in filteredByGender) {
            NSLog(@"Male: %@", aPerson.name);
        }
        
        NSArray *filteredByLastName = [aPersonModel filterDistinctByLastName];
        for (NSString *aPerson in filteredByLastName) {
            NSLog(@"Male: %@\*", aPerson);
        }

    }
    return 0;
}
