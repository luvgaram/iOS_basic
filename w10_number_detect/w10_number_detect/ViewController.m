//
//  ViewController.m
//  w10_number_detect
//
//  Created by Eunjoo Im on 2016. 5. 4..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "ViewController.h"
#import "MyGestureRecognizer.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@end

@implementation ViewController

MyGestureRecognizer *gestureRecognizer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    gestureRecognizer = [[MyGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(respondToMyGesture:)];
    
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)respondToMyGesture:(MyGestureRecognizer*)rec {
    if (rec.state == UIGestureRecognizerStateEnded) {
        if (gestureRecognizer.result == -1)
            _myLabel.text = @"Sorry, try again! :(";
        else _myLabel.text = [NSString stringWithFormat:@"You wrote \"%d\"", gestureRecognizer.result];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
