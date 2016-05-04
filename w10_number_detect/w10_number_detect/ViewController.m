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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyGestureRecognizer *gestureRecognizer = [[MyGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(respondToMyGesture:)];
    
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)respondToMyGesture:(MyGestureRecognizer*)rec {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
