//
//  NXTableViewCell.h
//  w11_database
//
//  Created by Eunjoo Im on 2016. 5. 9..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@end
