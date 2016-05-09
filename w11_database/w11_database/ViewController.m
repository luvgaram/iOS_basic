//
//  ViewController.m
//  w11_database
//
//  Created by Eunjoo Im on 2016. 5. 9..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "ViewController.h"
#include <sqlite3.h>
#import "NXMusic.h"
#import "NXTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

NSMutableArray *dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self getDataFromDB];
    
    
}

- (void)getDataFromDB {
    sqlite3 *db;
    char *sql;
    int rc;
    char **sql_results;
    int recordCount;
    int colomnCount;
    char *zErrMsg = 0;
    

    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"top25" ofType:@"db"];
    NSLog(@"filePath: %@", filePath);
    
    const char *cfilename = [filePath UTF8String];
    
    rc = sqlite3_open(cfilename, &db);
    
    if (rc) {
        NSLog(@"can't open database: %s", sqlite3_errmsg(db));
    } else {
        NSLog(@"open database successfully");
        dataArray = [[NSMutableArray alloc]init];
        
        sql = "SELECT * FROM tbl_songs";
        
        sqlite3_get_table(db, sql, &sql_results, &recordCount, &colomnCount, &zErrMsg);
        
        NSLog(@"recordCount: %d", recordCount);
        NSLog(@"colomnCount: %d", colomnCount);
        
        NXMusic *newMusic = [[NXMusic alloc] init];
        int index = 0;
        
        for (int i = 0; i < (recordCount + 1); i++) {
            if (i < 1) {
                index += 4;
                continue;
            }
            
            newMusic = [[NXMusic alloc] init];
            
            for (int j = 0; j < colomnCount; j++) {
                if (j == 0) {
                    newMusic.id = (int)(sql_results[index + j] - '0');
                } else if (j == 1) {
                    newMusic.title = [NSString stringWithUTF8String:sql_results[index + j]];
                } else if (j == 2) {
                    newMusic.category = [NSString stringWithUTF8String:sql_results[index + j]];
                } else if (j == 3) {
                    newMusic.image = [NSString stringWithUTF8String:sql_results[index + j]];
                    NSLog(@"[%d] %@", index, newMusic.title);
                }
            }
            
            [dataArray addObject:newMusic];
            
            index += 4;
            
        }
        
        NSLog(@"dataArray: %@", dataArray);
    }
    
    sqlite3_close(db);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - tableViewDetail
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    EJData *data;
//    
//    if (hasHeader) {
//        NSArray *sortedKeys = [self shortedKeys];
//        
//        NSLog(@"%@", sortedKeys);
//        
//        NSString *key = sortedKeys[indexPath.section];
//        NSArray *dataArray = [self.dataModel.itemDictionary objectForKey:key];
//        data = [dataArray objectAtIndex:(int)indexPath.row];
//    } else {
//        data = self.dataModel.itemArray[indexPath.row];
//    }
//    EJDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
//    [controller setDetailItem:data];
//    controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
//    controller.navigationItem.leftItemsSupplementBackButton = YES;
//    [self.navigationController pushViewController:controller animated:YES];
//    
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSLog(@"indexPath: %ld", (long)indexPath.row);
    NXMusic *object;
    
    object = [dataArray objectAtIndex:(int)indexPath.row];
    
    cell.titleLabel.text = object.title;
    cell.categoryLabel.text = object.category;
  
    NSLog(@"title: %@, %@", object.title, object.category);
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.dataModel.itemArray removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//    }
//}
@end
