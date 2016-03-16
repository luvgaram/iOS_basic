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
    
    NSString *inputData = @"[{\"title\":\"\uc0c8\uae001\",\"image\":\"01.jpg\",\"content\":\"\uc601\ud654\ubcf4\ub7ec\uac00\uc790\",\"comments\":[{\"id\":1,\"user\":\"jobs\",\"comment\":\"apple\"},{\"id\":4,\"user\":\"cook\",\"comment\":\"apple\"}]},{\"title\":\"\ud1a0\uc774\uc2a4\ud1a0\ub9ac?\",\"image\":\"02.jpg\",\"content\":\"Pixar\",\"comments\":[]},{\"title\":\"ToyStory\",\"image\":\"03.jpg\",\"content\":\"\uc6b0\ub514\uac00\ucd5c\uace0\",\"comments\":[{\"id\":2,\"user\":\"bill\",\"comment\":\"Microsoft\"}]},{\"title\":\"\uadf9\uc7a5\uc740\",\"image\":\"04.jpg\",\"content\":\"\uc5b4\ub514\ub85c\",\"comments\":[{\"id\":4,\"user\":\"cook\",\"comment\":\"apple\"}]}]";
    
    JsonSerializer *serializer = [[JsonSerializer alloc]init];
    model = [[NXContentModel alloc]initWithContents:[serializer serializeToArray:inputData]];
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
