//
//  NXContentModel.h
//  w3_VC_JSON
//
//  Created by Eunjoo Im on 2016. 3. 16..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXContent.h"

@interface NXContentModel : NSObject

@property NSArray *contents;

- (id) initWithContents:(NSArray *)contents;
- (NXContent *) randomContent;
- (NXContent *) itemAtIndex:(int)index;

@end
