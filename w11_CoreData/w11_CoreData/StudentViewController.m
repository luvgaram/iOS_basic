//
//  StudentViewController.m
//  w11_CoreData
//
//  Created by Eunjoo Im on 2016. 5. 11..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "StudentViewController.h"
#import "EJDataManager.h"
#import "EJTableViewCell.h"

@implementation StudentViewController

EJDataManager *dataManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataManager = [EJDataManager sharedInstance];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:) name:@"addStudent" object:nil];
}

- (void)receivedNotification:(NSNotification*)notification {
    
    NSLog(@"received notification");
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return [[dataManager.fetchedResultsController sections] count];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [dataManager.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"studentCell" forIndexPath:indexPath];
    NSManagedObject *object = [[dataManager fetchedResultsController] objectAtIndexPath:indexPath];
    [self configureCell:cell withObject:object];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [dataManager.fetchedResultsController managedObjectContext];
        [context deleteObject:[dataManager.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)configureCell:(EJTableViewCell *)cell withObject:(NSManagedObject *)object {
    cell.cellId.text = [[object valueForKey:@"id"] description];
    cell.cellName.text = [[object valueForKey:@"name"] description];
    cell.cellGrade.text = [[object valueForKey:@"grade"] description];
}

@end
