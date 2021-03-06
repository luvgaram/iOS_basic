//
//  EJAlbumViewController.m
//  midterm_CustomTableView
//
//  Created by Eunjoo Im on 2016. 4. 11..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "EJAlbumViewController.h"
#import "EJDataModel.h"
#import "EJData.h"
#import "EJTableViewCell.h"
#import "EJDetailViewController.h"

@interface EJAlbumViewController () <NSURLConnectionDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property EJDataModel *dataModel;

@end

@implementation EJAlbumViewController

#pragma mark - initializing

BOOL hasHeader;
NSMutableData *imageData;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:) name:@"initialized" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:) name:@"refreshed" object:nil];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.dataModel = [[EJDataModel alloc] init];
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshTable)];
    self.navigationItem.rightBarButtonItem = refreshButton;
    hasHeader = NO;
    
    imageData = [[NSMutableData alloc] initWithCapacity:10];
    NSString *url = @"http://125.209.194.123/demo/Image_100.jpg";
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(nonnull NSData *)data {
    //MTU 데이터 나눠받을 때마다
    [imageData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //전체 다 받은 이후
    UIImage *image = [UIImage imageWithData:imageData];
}

- (void)receivedNotification:(NSNotification*)notification {
    [self.tableView reloadData];
}

- (void) refreshTable {
    hasHeader = YES;
    [self.dataModel refreshData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - tableViewDetail

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EJData *data;
    
    if (hasHeader) {
        NSArray *sortedKeys = [self shortedKeys];
        
        NSLog(@"%@", sortedKeys);
        
        NSString *key = sortedKeys[indexPath.section];
        NSArray *dataArray = [self.dataModel.itemDictionary objectForKey:key];
        data = [dataArray objectAtIndex:(int)indexPath.row];
    } else {
        data = self.dataModel.itemArray[indexPath.row];
    }
    EJDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    [controller setDetailItem:data];
    controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    controller.navigationItem.leftItemsSupplementBackButton = YES;
    [self.navigationController pushViewController:controller animated:YES];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (hasHeader) {
        NSLog(@"[self.dataModel.itemDictionary count]: %d", [self.dataModel.itemDictionary count]);
        return [self.dataModel.itemDictionary count];
    }
    else return 1;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (hasHeader) {

        
        NSArray *sortedKeys = [self shortedKeys];
        
        return sortedKeys[section];
    }
    
    return NULL;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (hasHeader) {
        NSArray *sortedKeys = [self shortedKeys];
        
        NSString *key = sortedKeys[section];
        
        NSLog(@"[[self.dataModel.itemDictionary objectForKey:key] count]: %d", [[self.dataModel.itemDictionary objectForKey:key] count]);
        return [[self.dataModel.itemDictionary objectForKey:key] count];
    }
    return [self.dataModel.itemArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSLog(@"indexPath: %ld", (long)indexPath.row);
    EJData *object;
    
    if (hasHeader) {
        NSArray *sortedKeys = [self shortedKeys];
        
        NSLog(@"%@", sortedKeys);
        
        NSString *key = sortedKeys[indexPath.section];
        NSArray *dataArray = [self.dataModel.itemDictionary objectForKey:key];
        object = [dataArray objectAtIndex:(int)indexPath.row];
    } else {
        object = [self.dataModel.itemArray objectAtIndex:(int)indexPath.row];
    }
    
    cell.backgroundImage.image = [UIImage imageWithData:object.image];
    cell.backgroundImage.contentMode = UIViewContentModeCenter;
    
    cell.titleLabel.text = object.title;
    cell.detailLabel.text = object.date;
    
    NSLog(@"title: %@, %@", object.title, object.date);
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataModel.itemArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}

#pragma mark - shake

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (UIEventSubtypeMotionShake) {
        NSLog(@"I'm shaking!");
        hasHeader = NO;
        [self.dataModel initializeData];
    }
}

#pragma mark - for Dictionary

- (NSArray *)shortedKeys {
    NSArray *allKeys = [self.dataModel.itemDictionary allKeys];
    return [allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

@end
