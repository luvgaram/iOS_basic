//
//  DetailViewController.m
//  w3_VC_JSON
//
//  Created by Eunjoo Im on 2016. 3. 16..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

// 한번만 불림
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"my content: %@", _content);
    _detailContent.text = _content.content;

    UIImage *detailImg = [UIImage imageNamed:_content.image];
    _detailImage.image = detailImg;
}

// 여러번 불림
- (void)viewWillAppear:(BOOL)animated {

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

@end
