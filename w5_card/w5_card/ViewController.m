//
//  ViewController.m
//  w5_card
//
//  Created by Eunjoo Im on 2016. 3. 30..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "ViewController.h"
#import "SolitaireDeck.h"
#import "CardView.h"

@interface ViewController ()


@property (retain, nonatomic) IBOutlet CardView *myCanvas;

@end




@implementation ViewController
- (IBAction)testButton:(id)sender {
    SolitaireDeck *newDeck = [[SolitaireDeck alloc] init];

//    [newDeck displayCards];
    _myCanvas.cardDeck = [newDeck shuffleCards];
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

- (void)dealloc {
    [_myCanvas release];
    [_myCanvas release];
    [super dealloc];
}
@end
