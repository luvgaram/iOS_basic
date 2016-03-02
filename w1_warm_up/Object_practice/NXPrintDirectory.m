//
//  NXPrintDirectory.m
//  Object_practice
//
//  Created by Eunjoo Im on 2016. 3. 2..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "NXPrintDirectory.h"

@implementation NXPrintDirectory

NSFileManager *fileManager;
NSDirectoryEnumerator *directoryEnumerator;

-(id)init {
    self = [super init];
    
    if (self) {
        fileManager = [NSFileManager defaultManager];
    }
    
    return self;
}

-(void)NXDisplayAllFilesAtPath:(NSString*)path {
    directoryEnumerator = [fileManager enumeratorAtPath:path];
    NSLog(@"--- %@ ---", path);
    while ((path = [directoryEnumerator nextObject]) != nil) {
        NSLog(@"%@",path);
    }
}

-(void)NXDisplayAllFilesAtPath:(NSString*)path
             filterByExtension:(NSString*)extension {
    directoryEnumerator = [fileManager enumeratorAtPath:path];
    NSLog(@"--- %@ ---", path);
    while ((path = [directoryEnumerator nextObject]) != nil) {
        if ([[path pathExtension] isEqualToString: extension]) {
            NSLog(@"%@",path);
        }
    }
}

+(void)NXDisplayAllFilesAtPath:(NSString*)path
             filterByExtension:(NSString*)extension {
    fileManager = [NSFileManager defaultManager];
    directoryEnumerator = [fileManager enumeratorAtPath:path];
    NSLog(@"--- %@ ---", path);
    while ((path = [directoryEnumerator nextObject]) != nil) {
        if ([path hasSuffix:extension]) {
            NSLog(@"%@",path);
        }
    }
}

@end
