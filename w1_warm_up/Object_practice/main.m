//
//  main.m
//  Object_practice
//
//  Created by Eunjoo Im on 2016. 3. 2..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXPen.h"
#import "NXPrintDirectory.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // NXPen
        NXPen *aNXPen = [[NXPen alloc] initWithBrand:@"monami"];
        [aNXPen setColor:@"red"];
        [aNXPen setUsage:10];
        [aNXPen printDescription];
        
        NXPen *anotherNXPen = [[NXPen alloc] initWithBrand:@"sharp"];
        [anotherNXPen setColor:@"blue"];
        [anotherNXPen setUsage:50];
        [anotherNXPen printDescription];
        
        // NXPrintDirectory instance method
        NXPrintDirectory *ls = [[NXPrintDirectory alloc]init];
        [ls NXDisplayAllFilesAtPath:@"/Users/eunjooim/Dropbox/garam/design"];
        
        [ls NXDisplayAllFilesAtPath:@"/Users/eunjooim/Dropbox/garam/design" filterByExtension:@"png"];
        
        // NXPrintDirectory class method
//        [NXPrintDirectory NXDisplayAllFilesAtPath:@"/Users/eunjooim/Dropbox/garam/design" filterByExtension:@"png"];
    }
    
    return 0;
}
