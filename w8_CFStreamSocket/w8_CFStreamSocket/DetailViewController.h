//
//  DetailViewController.h
//  w8_CFStreamSocket
//
//  Created by Eunjoo Im on 2016. 4. 20..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

