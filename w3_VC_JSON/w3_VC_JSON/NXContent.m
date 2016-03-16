//
//  NXContent.m
//  w3_VC_JSON
//
//  Created by Eunjoo Im on 2016. 3. 16..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "NXContent.h"

@implementation NXContent

- (id)initWithTitle:(NSString *)title image: (NSString *)image content: (NSString *)content comments: (NSArray *)comments {
    self = [super init];
    
    if (self) {
        self.title = title;
        self.image = image;
        self.content = content;
        self.comments = comments;
    }
    
    return self;
}

@end
