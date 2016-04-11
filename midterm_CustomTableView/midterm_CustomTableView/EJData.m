//
//  EJData.m
//  midterm_CustomTableView
//
//  Created by Eunjoo Im on 2016. 4. 11..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "EJData.h"

@implementation EJData

- (id)initWithTitle:(NSString *)title image:(NSString *)image date:(NSString *)date {
    self = [super init];
    
    if (self) {
        self.title = title;
        self.image = image;
        self.date = date;
    }
    
    return self;
}

@end
