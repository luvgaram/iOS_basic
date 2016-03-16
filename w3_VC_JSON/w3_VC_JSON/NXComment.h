//
//  NXComment.h
//  w3_VC_JSON
//
//  Created by Eunjoo Im on 2016. 3. 16..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXComment : NSObject

@property NSNumber *id;
@property NSString *user;
@property NSString *comment;

- (id)initWithId:(NSNumber *)id user: (NSString *)user comment: (NSArray *)comment;

@end
