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

@interface StudentViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation StudentViewController

EJDataManager *dataManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataManager = [EJDataManager sharedInstance];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:) name:@"addStudent" object:nil];
}

- (void)receivedNotification:(NSNotification*)notification {
    NSLog(@"received notification");
    
    [self.tableView reloadData];
    [self.tableView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataManager numbersOfStudents];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"studentCell" forIndexPath:indexPath];
    NSManagedObject *object = [[dataManager fetchedResultsController] objectAtIndexPath:indexPath];
    [self configureCell:cell withObject:object];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)configureCell:(EJTableViewCell *)cell withObject:(NSManagedObject *)object {
    cell.cellId.text = [[object valueForKey:@"id"] description];
    cell.cellName.text = [[object valueForKey:@"name"] description];
    cell.cellGrade.text = [[object valueForKey:@"grade"] description];
    
    if ([[[object valueForKey:@"gender"] description] isEqualToString:@"1"]) cell.cellGender.text = @"M";
    else cell.cellGender.text = @"F";
}

@end
