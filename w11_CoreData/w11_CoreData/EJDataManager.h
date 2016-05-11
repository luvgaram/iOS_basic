//
//  EJDataManager.h
//  w11_CoreData
//
//  Created by Eunjoo Im on 2016. 5. 11..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface EJDataManager : NSObject <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+ (id)sharedInstance;
- (void)addStudentWithId:(NSString *)studentId name:(NSString *)name gender:(BOOL)isMale grade:(NSUInteger)grade;
- (NSUInteger)numbersOfStudents;
- (BOOL)isInsertedId:(NSString *) targetId;

@end
