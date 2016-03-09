//
//  NXPersonModel.h
//  W2_Collections
//
//  Created by Eunjoo Im on 2016. 3. 9..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXPerson.h"

@interface NXPersonModel : NSObject

- (int)population;
- (NSString*)personNameAtIndex:(int)index;
- (NSNumber*)personNumberAtIndex:(int)index;
- (BOOL)isMaleAtIndex:(int)index;
- (NSNumber*)personTeamAtIndex:(int)index;
- (NXPerson*)getPersonObjetAtIndex:(int)index;

- (NSString*)findPersonNameByNumber:(NSNumber*)number;
- (NSNumber*)findPersonNumberByName:(NSString*)name;
- (NSArray*) sortedByName;
- (NSArray*) sortedByNumber;
- (NSArray*) sortedByTeam;

- (NSArray*) filterByTeam:(NSNumber*)team;
- (NSArray*) filterByGender:(NSString*)gender;
- (NSArray*) filterDistinctByLastName;

@end
