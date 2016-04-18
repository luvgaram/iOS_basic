//
//  EJDataModel.m
//  midterm_CustomTableView
//
//  Created by Eunjoo Im on 2016. 4. 11..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "EJDataModel.h"
#import "EJData.h"
#import "Reachability.h"

@implementation EJDataModel

    char *data = "[{\"title\":\"초록\",\"image\":\"01.jpg\",\"date\":\"20150116\"},\ {\"title\":\"장미\",\"image\":\"02.jpg\",\"date\":\"20160505\"},\ {\"title\":\"낙엽\",\"image\":\"03.jpg\",\"date\":\"20141212\"},\ {\"title\":\"계단\",\"image\":\"04.jpg\",\"date\":\"20140301\"},\ {\"title\":\"벽돌\",\"image\":\"05.jpg\",\"date\":\"20150101\"},\ {\"title\":\"바다\",\"image\":\"06.jpg\",\"date\":\"20150707\"},\ {\"title\":\"벌레\",\"image\":\"07.jpg\",\"date\":\"20140815\"},\ {\"title\":\"나무\",\"image\":\"08.jpg\",\"date\":\"20161231\"},\ {\"title\":\"흑백\",\"image\":\"09.jpg\",\"date\":\"20150102\"},\ {\"title\":\"나비\",\"image\":\"10.jpg\",\"date\":\"20141225\"}]";

    NetworkStatus remoteHostStatus;

- (id) init {
    self = [super init];
    
    if (self) {
        // JSON to itemArray
        
        Reachability *reachability = [Reachability reachabilityWithHostName:@"125.209.192.123"];
        remoteHostStatus = [reachability currentReachabilityStatus];
        
        NSData *newData;
        
        if (remoteHostStatus == NotReachable) {
            NSLog(@"reachbility: NotReachable");
            newData = [self getJsonFromChar];
        } else {
            NSLog(@"reachbility: Reachable");
            newData = [self getJsonFromURL];
        }
        
        [self serializingJSON:newData];
        
        // sort with title
        [self initializeData];
    }
    
    return self;
}

- (NSData *)getJsonFromURL {
    NSString *urlString = @"http://125.209.194.123/json.php";
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    return data;
}

- (NSData *)getJsonFromChar {
    NSString *fileContents = [NSString stringWithUTF8String:data];
    return [fileContents dataUsingEncoding:NSUTF8StringEncoding];
}
- (void) serializingJSON:(NSData *)newData{
    self.itemArray = [[NSMutableArray alloc] init];
    
    NSArray *stringArray = [NSJSONSerialization JSONObjectWithData:newData options:0 error:nil];
    
    for (NSDictionary *rawDic in stringArray) {
//        EJData *newData = [[EJData alloc]initWithTitle:[rawDic objectForKey:@"title"]
//                                                 image:[rawDic objectForKey:@"image"]
//                                                  date:[rawDic objectForKey:@"date"]];
        NSData *image;
        NSString *imageName = [rawDic objectForKey:@"image"];
        
        if (remoteHostStatus == NotReachable) {
            NSLog(@"isReachable: NO");
            NSString *filePath = [[NSBundle mainBundle] pathForResource:[imageName substringToIndex : 2] ofType:@"jpg"];
            image = [NSData dataWithContentsOfFile:filePath];
        } else {
            NSLog(@"isReachable: YES");
            NSString *urlString = [NSString stringWithFormat:@"http://125.209.194.123/demo/%@", imageName];
            NSURL *url = [NSURL URLWithString:urlString];
            image = [[NSData alloc] initWithContentsOfURL:url];
        }
        
        EJData *newData = [[EJData alloc]initWithTitle:[rawDic objectForKey:@"title"]
                                                 image:image
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
