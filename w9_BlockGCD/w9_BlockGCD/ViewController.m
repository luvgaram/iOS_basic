//
//  ViewController.m
//  w9_BlockGCD
//
//  Created by Eunjoo Im on 2016. 4. 25..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonWidthConstraint;
- (IBAction)buttonClicked:(id)sender;
- (IBAction)bookButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClicked:(id)sender {
    [UIView animateWithDuration:1.0
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         _firstButton.backgroundColor = [UIColor yellowColor];
                         _firstButton.alpha = 0.5;

                         _buttonWidthConstraint.constant = 140;
                         _buttonHeightConstraint.constant = 40;
                         _buttonLeftConstraint.constant = 140;
                         _buttonTopConstraint.constant = 300;
                         [_firstButton setTitle:@"clicked" forState:UIControlStateNormal];
                         [self.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished){
                         _firstButton.backgroundColor = [UIColor lightGrayColor];
                         _firstButton.alpha = 1;
                         _buttonWidthConstraint.constant = 100;
                         _buttonHeightConstraint.constant = 100;
                         _buttonLeftConstraint.constant = 40;
                         _buttonTopConstraint.constant = 46;
                         [_firstButton setTitle:@"first" forState:UIControlStateNormal];
//                         [self.view layoutIfNeeded];
                     }];
}

- (IBAction)bookButtonClicked:(id)sender {
    _progressBar.progress = 0;
//    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t aQueue = dispatch_get_main_queue();
    dispatch_async(aQueue, ^{
        [self workingProgress];
    });
}

-(void)workingProgress {
    NSString *bookfile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                             pathForResource:@"bookfile" ofType:@".txt"]  encoding:NSUTF8StringEncoding error:nil];
    int length = bookfile.length;
    int spaceCount = 0;
    float progress = 0;
    unichar aChar;
    for (int nLoop=0; nLoop<length; nLoop++) {
        aChar = [bookfile characterAtIndex:nLoop];
        if (aChar==' ') spaceCount++;
        progress = (float)nLoop / (float)length;
        _progressBar.progress = progress;
    }
    [[[UIAlertView alloc] initWithTitle:@"완료"
                                message:[NSString stringWithFormat:@"찾았다 %d개",spaceCount]
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil, nil] show];
}
      
@end
