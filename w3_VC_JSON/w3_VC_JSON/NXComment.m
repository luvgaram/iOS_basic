//
//  NXComment.m
//  w3_VC_JSON
//
//  Created by Eunjoo Im on 2016. 3. 16..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "NXComment.h"

@implementation NXComment

- (id)initWithId:(NSNumber *)id user: (NSString *)user comment: (NSString *)comment {
    self = [super init];
    
    if (self) {
        self.id = id;
        self.user = user;
        self.comment = comment;
    }
    
    return self;
}

@end
