//
//  NXContent.h
//  w3_VC_JSON
//
//  Created by Eunjoo Im on 2016. 3. 16..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXContent : NSObject

@property NSString *title;
@property NSString *image;
@property NSString *content;
@property NSArray *comments;

- (id)initWithTitle:(NSString *)title image: (NSString *)image content: (NSString *)content comments: (NSArray *)comments;

@end
