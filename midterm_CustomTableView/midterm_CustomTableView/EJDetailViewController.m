//
//  EJDetailViewController.m
//  midterm_CustomTableView
//
//  Created by Eunjoo Im on 2016. 4. 11..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "EJDetailViewController.h"

@interface EJDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *detailTitle;
@property (weak, nonatomic) IBOutlet UIImageView *detailImage;
@property (weak, nonatomic) IBOutlet UILabel *detailDate;

@end

@implementation EJDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureView];
}

- (void) setDetailItem:(EJData *)newData {
    if (self.data != newData) {
        self.data = newData;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.data) {
        self.detailTitle.text = [self.data title];
        
        NSLog(@"title: %@", [self.data title]);
        self.detailImage.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[self.data.image substringToIndex : 2] ofType:@"jpg"]];
        self.detailDate.text = [self.data date];
    }
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
