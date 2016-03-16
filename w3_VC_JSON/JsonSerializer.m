//
//  JsonSerializer.m
//  w3_VC_JSON
//
//  Created by Eunjoo Im on 2016. 3. 16..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "JsonSerializer.h"
#import "NXContent.h"
#import "NXComment.h"

@implementation JsonSerializer

NSData *data;

- (NSArray *)serializeToArray:(NSString*)json {
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *stringArray = [NSJSONSerialization JSONObjectWithData:data
                                                        options:0
                                                          error:nil];
    for (NSDictionary *rawDic in stringArray) {
        NSLog(@"rawString: %@", rawDic);
        NSArray *contentArray = [rawDic objectForKey:@"comments"];
        NSMutableArray *commentArray = [[NSMutableArray alloc]init];
        
        for (NSDictionary *comment in contentArray) {
            NXComment *newComment = [[NXComment alloc]initWithId:[comment objectForKey:@"id"]
                                                            user:[comment objectForKey:@"comment"]
                                                         comment:[comment objectForKey:@"comment"]];
            [commentArray addObject:newComment];
        }
        
        NXContent *newContent = [[NXContent alloc]initWithTitle:[rawDic objectForKey:@"title"] image:[rawDic objectForKey:@"image"] content:[rawDic objectForKey:@"content"] comments:commentArray];
        
        [resultArray addObject:newContent];
    }
    
    return resultArray;
}

@end
