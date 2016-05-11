//
//  EJTableViewCell.h
//  w11_CoreData
//
//  Created by Eunjoo Im on 2016. 5. 11..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EJTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellId;
@property (weak, nonatomic) IBOutlet UILabel *cellName;
@property (weak, nonatomic) IBOutlet UILabel *cellGrade;

@end
