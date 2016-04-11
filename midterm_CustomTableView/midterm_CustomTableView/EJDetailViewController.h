//
//  EJDetailViewController.h
//  midterm_CustomTableView
//
//  Created by Eunjoo Im on 2016. 4. 11..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EJData.h"

@interface EJDetailViewController : UIViewController

@property (strong, nonatomic) EJData *data;
- (void) setDetailItem:(EJData *)data;

@end
