//
//  ViewController.m
//  w9_BlockGCD
//
//  Created by Eunjoo Im on 2016. 4. 25..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonWidthConstraint;
- (IBAction)buttonClicked:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClicked:(id)sender {
    [UIView animateWithDuration:1.0
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         _firstButton.backgroundColor = [UIColor yellowColor];
                         _firstButton.alpha = 0.5;

                         _buttonWidthConstraint.constant = 140;
                         _buttonHeightConstraint.constant = 40;
                         _buttonLeftConstraint.constant = 140;
                         _buttonTopConstraint.constant = 300;
                         [_firstButton setTitle:@"clicked" forState:UIControlStateNormal];
                         [self.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished){
                         _firstButton.backgroundColor = [UIColor lightGrayColor];
                         _firstButton.alpha = 1;
                         _buttonWidthConstraint.constant = 100;
                         _buttonHeightConstraint.constant = 100;
                         _buttonLeftConstraint.constant = 40;
                         _buttonTopConstraint.constant = 46;
                         [_firstButton setTitle:@"first" forState:UIControlStateNormal];
//                         [self.view layoutIfNeeded];
                     }];
}
@end
