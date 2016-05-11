//
//  EditViewController.h
//  w11_CoreData
//
//  Created by Eunjoo Im on 2016. 5. 11..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *idTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *gradeTextField;
@property (weak, nonatomic) IBOutlet UISwitch *genderSwitch;


@end
