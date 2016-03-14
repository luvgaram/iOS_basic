//
//  Detail2ViewController.m
//  w3_MVC
//
//  Created by Eunjoo Im on 2016. 3. 14..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "Detail2ViewController.h"

@interface Detail2ViewController ()

@end

@implementation Detail2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)toRoot:(id)sender {
        [[self navigationController] popToRootViewControllerAnimated:YES];
}
@end
