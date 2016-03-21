//
//  ViewController.m
//  w4_view
//
//  Created by Eunjoo Im on 2016. 3. 21..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet MyView *myCanvas;

@end

@implementation ViewController

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_myCanvas setNeedsDisplay];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
