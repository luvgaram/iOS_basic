//
//  DetailViewController.h
//  w6_dynamic_behaviour
//
//  Created by Eunjoo Im on 2016. 4. 4..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

