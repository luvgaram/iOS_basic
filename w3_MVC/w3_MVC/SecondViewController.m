//
//  SecondViewController.m
//  w3_MVC
//
//  Created by Eunjoo Im on 2016. 3. 14..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "SecondViewController.h"
#import "NXPersonModel.h"
#import "NXPerson.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

NXPersonModel *aPersonModel;

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSBundle *mainBundle = [NSBundle mainBundle];
//    NSString *filePath = [mainBundle pathForResource:@"persons" ofType:@"txt"];
//    NSString *fileContents = [[NSString alloc] initWithContentsOfFile:filePath];
//    NSLog (@"%@", fileContents);
    
    aPersonModel = [[NXPersonModel alloc]init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)findNumber:(id)sender {
    NSString *targetName = [_targetName text ];
    NSLog(@"number of targetName, %@", [aPersonModel findPersonNumberByName: targetName]);

    _searchResult.text = [NSString stringWithFormat:@"%@", [[aPersonModel findPersonNumberByName: targetName] stringValue]];

}
- (IBAction)showList:(id)sender {
    _tempList.text = [aPersonModel showNamesSortedByNumber];
    
}

@end
