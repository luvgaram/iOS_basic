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
- (IBAction)countButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
- (IBAction)listCountButtonClicked:(id)sender;

@end

@implementation ViewController

NSMutableArray *wordArray;
NSString *bookfile;

- (void)viewWillAppear:(BOOL)animated {
    [self getJsonFromURL];
    bookfile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                   pathForResource:@"bookfile" ofType:@".txt"]  encoding:NSUTF8StringEncoding error:nil];
}

- (void)getJsonFromURL {
    NSString *urlString = @"http://125.209.194.123/wordlist.php";
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    [self serializingJSON:data];
}

- (void) serializingJSON:(NSData *)newData{
    wordArray = [[NSMutableArray alloc] init];
    
    NSArray *stringArray = [NSJSONSerialization JSONObjectWithData:newData options:0 error:nil];

    for (int i = 0; i < stringArray.count; i++) {
        NSString *word = stringArray[i];
        [wordArray addObject: word];
    }
}

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
                          [NSThread sleepForTimeInterval:1.0];
                         _firstButton.backgroundColor = [UIColor lightGrayColor];
                         _firstButton.alpha = 1;
                         _buttonWidthConstraint.constant = 100;
                         _buttonHeightConstraint.constant = 100;
                         _buttonLeftConstraint.constant = 40;
                         _buttonTopConstraint.constant = 46;
                         [_firstButton setTitle:@"first" forState:UIControlStateNormal];
                         [self.view layoutIfNeeded];
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

- (void)workingProgress {
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
      
- (IBAction)countButtonClicked:(id)sender {
    NSString *searchString = _searchTextField.text;

    NSInteger result = [self countOfSubstring:searchString atContents:bookfile];
    [self showAlert:[NSString stringWithFormat:@"[%@] 검색 횟수: %d회 ", _searchTextField.text, result]];
    
}

- (IBAction)listCountButtonClicked:(id)sender {
    [self countList];
}

- (void)showAlert:(NSString *) string {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"카운트 결과"
                                                    message:string
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)countList {
    NSMutableArray *operationArray = [[NSMutableArray alloc] initWithCapacity:wordArray.count];
    NSMutableDictionary *wordCountDic = [[NSMutableDictionary alloc] initWithCapacity:wordArray.count];
    NSBlockOperation *myBlockOperation;
    
    for (NSInteger i = 0; i < wordArray.count; i++) {
        myBlockOperation = [NSBlockOperation blockOperationWithBlock:^{
            NSNumber *number = [NSNumber numberWithInt:[self countOfSubstring:wordArray[i] atContents:bookfile]];
            [wordCountDic setObject:number forKey:wordArray[i]];
        }];
        
        [operationArray insertObject:myBlockOperation atIndex:i];
    }
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    [queue setMaxConcurrentOperationCount:wordArray.count];
    [queue addOperations:operationArray waitUntilFinished:NO];
    [queue waitUntilAllOperationsAreFinished];
    
    NSNumber *min = [NSNumber numberWithInt:NSIntegerMax];
    NSNumber *max = [NSNumber numberWithInt:0];
    
    NSString *minKey;
    NSString *maxKey;
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    for (NSString *key in [wordCountDic allKeys]) {
        NSNumber *currentNumber = [wordCountDic objectForKey:key];
        
        
        if (currentNumber.intValue <= min.intValue) {
            minKey = key;
            min = currentNumber;
        }
        
        if (currentNumber.intValue >= max.intValue) {
            maxKey = key;
            max = currentNumber;
        }
        
        [resultString appendString:key];
        [resultString appendString:@" - "];
        [resultString appendFormat:@"%@", currentNumber];
        [resultString appendString:@", "];
    }
    
    [resultString appendFormat:@"min: %@ - %@, max: %@ - %@", minKey, min, maxKey, max];
    
    NSLog(@"min: %@: %@회, max: %@: %@회", minKey, min, maxKey, max);
    [self showAlert:resultString];
}



- (NSUInteger)countOfSubstring:(NSString *)substring atContents:(NSString *)contents {

    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:substring options:NSRegularExpressionCaseInsensitive error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:contents options:0 range:NSMakeRange(0, [contents length])];
    NSLog(@"Found %i", numberOfMatches);
    
    return numberOfMatches;
}
@end
