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
BOOL isIdInserted;
BOOL isNameInserted;
BOOL isGradeInserted;

- (void)viewDidLoad {
    [super viewDidLoad];
    ejDataManager = [EJDataManager sharedInstance];
    
    isIdInserted = NO;
    isNameInserted = NO;
    isGradeInserted = NO;
    self.saveButton.enabled = NO;
}

- (IBAction)idTextChanged:(id)sender {
    NSString *targetID = self.idTextField.text;
    
    if (targetID.length > 0 && ![ejDataManager isInsertedId:targetID]) isIdInserted = YES;
    else isIdInserted = NO;
    
    [self swichSaveButtonStatus];
}

- (IBAction)nameTextChanged:(id)sender {
    if (self.nameTextField.text.length > 0) isNameInserted = YES;
    else isNameInserted = NO;
    
    [self swichSaveButtonStatus];
}

- (void)swichSaveButtonStatus {
    if (isIdInserted && isNameInserted && isGradeInserted) self.saveButton.enabled = YES;
    else self.saveButton.enabled = NO;
}

- (IBAction)gradeTextChanged:(id)sender {
    
    NSLog(@"length: %d", self.gradeTextField.text.length);
    if (self.gradeTextField.text.length > 0) {
        isGradeInserted = YES;
    } else {
        isGradeInserted = NO;
    }
    
    if (isIdInserted && isNameInserted && isGradeInserted) self.saveButton.enabled = YES;
}

- (IBAction)SaveButtonClicked:(id)sender {
    NSString *studentId = self.idTextField.text;
    NSString *name = self.nameTextField.text;
    BOOL isMale = [self.genderSwitch isOn];
    NSUInteger grade = [self.gradeTextField.text integerValue];
    
    self.idTextField.text = @"";
    self.nameTextField.text = @"";
    self.gradeTextField.text = @"";
    
    [ejDataManager addStudentWithId:studentId name:name gender:isMale grade:grade];
//    [ejDataManager controllerWillChangeContent];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
