//
//  ViewController.m
//  w10_multi_touchEvent
//
//  Created by Eunjoo Im on 2016. 5. 2..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "ViewController.h"
#import "MyGestureRecognizer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyGestureRecognizer *gestureRecognizer = [[MyGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(respondToMyGesture:)];
    
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)respondToMyGesture:(MyGestureRecognizer*)rec {
    if (rec.state == UIGestureRecognizerStateEnded) {
        [[[UIAlertView alloc] initWithTitle:@"checked!"
                                    message:@"체크 확인!"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
