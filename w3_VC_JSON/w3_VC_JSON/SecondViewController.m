//
//  SecondViewController.m
//  w3_VC_JSON
//
//  Created by Eunjoo Im on 2016. 3. 16..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "SecondViewController.h"
#import "JsonSerializer.h"
#import "NXContentModel.h"
#import "NXContent.h"
#import "DetailViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

NXContentModel *model;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JsonSerializer *serializer = [[JsonSerializer alloc]init];
    NSString *rawData = [serializer getStringFromJson:@"data"];
    model = [[NXContentModel alloc]initWithContents:[serializer serializeToArray:rawData]];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        DetailViewController *detailVC = (DetailViewController*)segue.destinationViewController;
        detailVC.content = [model randomContent];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
