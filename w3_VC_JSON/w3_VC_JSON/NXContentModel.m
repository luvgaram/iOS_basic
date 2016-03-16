//
//  NXContentModel.m
//  w3_VC_JSON
//
//  Created by Eunjoo Im on 2016. 3. 16..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "NXContentModel.h"

@implementation NXContentModel

- (id) initWithContents:(NSArray *)contents {
    self = [super init];
    
    if (self) {
        self.contents = contents;
    }
    
    return self;
}

- (NXContent *) randomContent {
    int value = arc4random() % _contents.count;
    return [self itemAtIndex:value];
}

- (NXContent *) itemAtIndex:(int)index {
    return [_contents objectAtIndex:index];
}

@end
