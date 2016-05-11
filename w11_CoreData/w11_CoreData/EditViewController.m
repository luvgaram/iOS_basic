//
//  EditViewController.m
//  w11_CoreData
//
//  Created by Eunjoo Im on 2016. 5. 11..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "EditViewController.h"
#import "EJDataManager.h"

@implementation EditViewController

EJDataManager *ejDataManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    ejDataManager = [EJDataManager sharedInstance];
}


- (IBAction)SaveButtonClicked:(id)sender {
    NSString *studentId = self.idTextField.text;
    NSString *name = self.nameTextField.text;
    BOOL isMale = [self.genderSwitch isOn];
    NSUInteger grade = [self.gradeTextField.text integerValue];
    
    [ejDataManager addStudentWithId:studentId name:name gender:isMale grade:grade];
    [ejDataManager controllerWillChangeContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
