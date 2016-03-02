//
//  NXPrintDirectory.h
//  Object_practice
//
//  Created by Eunjoo Im on 2016. 3. 2..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXPrintDirectory : NSObject

-(void)NXDisplayAllFilesAtPath:(NSString*)path;
-(void)NXDisplayAllFilesAtPath:(NSString*)path
               filterByExtension:(NSString*)extension;
+(void)NXDisplayAllFilesAtPath:(NSString*)path
             filterByExtension:(NSString*)extension;

@end
