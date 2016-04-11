//
//  EJData.h
//  midterm_CustomTableView
//
//  Created by Eunjoo Im on 2016. 4. 11..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EJData : NSObject

@property NSString *title;
@property NSString *image;
@property NSString *date;

- (id)initWithTitle:(NSString *)title image:(NSString *)image date:(NSString *)date;

@end
