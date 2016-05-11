//
//  EJDataManager.m
//  w11_CoreData
//
//  Created by Eunjoo Im on 2016. 5. 11..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "EJDataManager.h"

@implementation EJDataManager

static id sharedInsctance = nil;

+ (void)initialize {
    if (self == [EJDataManager class]) {
        sharedInsctance = [[self alloc] init];
    }
}

+ (id)sharedInstance {
    return sharedInsctance;
}

- (void)addStudentWithId:(NSString *)studentId name:(NSString *)name gender:(BOOL)isMale grade:(NSUInteger)grade {
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    [object setValue:studentId forKey:@"id"];
    [object setValue:name forKey:@"name"];
    [object setValue:[NSNumber numberWithBool:isMale] forKey:@"gender"];
    [object setValue:[NSNumber numberWithInteger:grade] forKey:@"grade"];
    
    // Save the context.
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (NSUInteger)numbersOfStudents {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][0];
    return [sectionInfo numberOfObjects];
}

- (BOOL)isInsertedId:(NSString *) targetId {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][0];
    
    for (NSManagedObject *object in [sectionInfo objects]) {
        NSString *id = [[object valueForKey:@"id"] description];
        NSLog(@"id: %@", id);
        
        if ([id isEqualToString:targetId]) return YES;
    }
    return NO;
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:NO];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
     NSLog(@"controllerWillChangeContent");
     
     NSNotification *notification = [NSNotification notificationWithName:@"addStudent" object:self];
     [[NSNotificationCenter defaultCenter] postNotification:notification];
 }

@end
