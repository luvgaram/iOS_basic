//
//  EJDataModel.h
//  midterm_CustomTableView
//
//  Created by Eunjoo Im on 2016. 4. 11..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EJDataModel : NSObject

@property NSMutableArray *itemArray;
@property NSMutableDictionary *itemDictionary;

- (void) refreshData;
- (void) initializeData;

@end
