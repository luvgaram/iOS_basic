//
//  EJDataModel.m
//  midterm_CustomTableView
//
//  Created by Eunjoo Im on 2016. 4. 11..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "EJDataModel.h"
#import "EJData.h"

@implementation EJDataModel

    char *data = "[{\"title\":\"초록\",\"image\":\"01.jpg\",\"date\":\"20150116\"},\ {\"title\":\"장미\",\"image\":\"02.jpg\",\"date\":\"20160505\"},\ {\"title\":\"낙엽\",\"image\":\"03.jpg\",\"date\":\"20141212\"},\ {\"title\":\"계단\",\"image\":\"04.jpg\",\"date\":\"20140301\"},\ {\"title\":\"벽돌\",\"image\":\"05.jpg\",\"date\":\"20150101\"},\ {\"title\":\"바다\",\"image\":\"06.jpg\",\"date\":\"20150707\"},\ {\"title\":\"벌레\",\"image\":\"07.jpg\",\"date\":\"20140815\"},\ {\"title\":\"나무\",\"image\":\"08.jpg\",\"date\":\"20161231\"},\ {\"title\":\"흑백\",\"image\":\"09.jpg\",\"date\":\"20150102\"},\ {\"title\":\"나비\",\"image\":\"10.jpg\",\"date\":\"20141225\"}]";

- (id) init {
    self = [super init];
    
    if (self) {
        // JSON to itemArray
        [self serializingJSON];
        
        // sort with title
        [self initializeData];
    }
    
    return self;
}

- (void) serializingJSON {
    NSString *fileContents = [NSString stringWithUTF8String:data];
    NSData *newData = [fileContents dataUsingEncoding:NSUTF8StringEncoding];
    
    self.itemArray = [[NSMutableArray alloc] init];
    
    NSArray *stringArray = [NSJSONSerialization JSONObjectWithData:newData options:0 error:nil];
    
    for (NSDictionary *rawDic in stringArray) {
        EJData *newData = [[EJData alloc]initWithTitle:[rawDic objectForKey:@"title"]
                                                 image:[rawDic objectForKey:@"image"]
                                                  date:[rawDic objectForKey:@"date"]];
        [self.itemArray addObject: newData];
    }
    
    NSLog(@"itemArray: %@", self.itemArray);
}

- (void) initializeData {
    self.itemArray = [[NSMutableArray alloc] initWithArray:[self sortArrayWith:@"title"]];
    NSLog(@"sorted: %@", self.itemArray);
    
    // post noti : initialized
    [[NSNotificationCenter defaultCenter] postNotificationName:@"initialized" object:self];
}

- (void) refreshData {
    self.itemArray = [[NSMutableArray alloc] initWithArray:[self sortArrayWith:@"date"]];
    NSLog(@"sorted: %@", self.itemArray);
    
    self.itemDictionary = [NSMutableDictionary dictionary];
//    NSMutableSet *keySet = [NSMutableSet set];
    
    NSString *year = @"1800";
    
    for (EJData *data in self.itemArray) {
        
        if (![[data.date substringToIndex : 4]isEqualToString:year]) {
            NSMutableArray *newArray = [[NSMutableArray alloc] init];
            [newArray addObject:data];
            year = [data.date substringToIndex : 4];
            
            [self.itemDictionary setObject:newArray forKey:year];
            
        } else {
            NSMutableArray *newArray = [self.itemDictionary objectForKey:year];
            [newArray addObject:data];
        }
    }
    
    NSLog(@"dictionary : %@", self.itemDictionary);
    
    // post noti : refreshed
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshed" object:self];

}

- (NSArray *) sortArrayWith:(NSString *)comparator {
    NSArray *sortedArray;
    sortedArray = [self.itemArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSString *first;
        NSString *second;
        
        if ([comparator isEqualToString:@"title"]) {
            first = [(EJData*)a title];
            second = [(EJData*)b title];
        } else if ([comparator isEqualToString:@"date"]) {
            first = [(EJData*)a date];
            second = [(EJData*)b date];
        }
        
        return [first compare:second];
    }];
    
    return sortedArray;
}


@end
