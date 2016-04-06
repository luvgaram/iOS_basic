//
//  ViewController.m
//  w5_card
//
//  Created by Eunjoo Im on 2016. 3. 30..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "ViewController.h"
#import "SolitaireDeck.h"

@interface ViewController ()


@property (retain, nonatomic) IBOutlet UIView *myCanvas;

@end

@implementation ViewController

SolitaireDeck *newDeck;
NSArray *shuffledDeck;
int cardWidth = 130;
int cardHeight = 150;

- (IBAction)testButton:(id)sender {
    for (UIView *view in [_myCanvas subviews]) {
        if ([view isMemberOfClass:[UIImageView class]]) {
            view = nil;
            [view removeFromSuperview];
            [view release];
        }
    }
    [self addView];
}

- (void)saveCardDeck:(NSNotification*)notification {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *fileName = [NSString stringWithFormat:@"%@%@",paths[0], @"/deck.plist"];
    NSLog(@"saved deck: %@", shuffledDeck);
    [shuffledDeck writeToFile:fileName atomically:YES];

}

- (void)getCardDeck:(NSNotification*)notification {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *fileName = [NSString stringWithFormat:@"%@%@",paths[0], @"/deck.plist"];
    
    if (!shuffledDeck) {
        NSLog(@"get deck from plist");
        shuffledDeck = [[NSArray alloc] initWithContentsOfFile:fileName];
    }
    
    NSLog(@"deck from plist: %@", shuffledDeck);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveCardDeck:) name:@"saveDeck" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCardDeck:) name:@"getDeck" object:nil];
    
    [self addView];
}

- (void)addView {
    newDeck = [[SolitaireDeck alloc] init];
    
    NSLog(@"addView: %@", shuffledDeck);
    
    if (!shuffledDeck) {
        newDeck = [[SolitaireDeck alloc] init];
        shuffledDeck = [newDeck shuffleCards];
//        [shuffledDeck retain];
    };
    
    NSLog(@"addedView: %@", shuffledDeck);
    
    int startX = 26;
    int startY = 100;
    
    for (int i = 0; i < 7; i++) {
        [self drawDeck:shuffledDeck index:i startX:startX startY:startY number:i + 1];
        startX += cardWidth + 10;
    }
    
    [self drawCardAtLastDeck:[shuffledDeck objectAtIndex:7] startPosX:26 startPosY:500];
    
//    [shuffledDeck release];
//    [newDeck release];
}

- (UIImage *)makeCardImageView:(NSString *)cardName {
    return [UIImage imageNamed:cardName];
}

- (void)drawDeck:(NSArray *)cardDeck index:(int)index startX:(int)startX startY:(int)startY number:(int)number {
    
    NSArray *deck = [cardDeck objectAtIndex:index];
    [deck retain];
    
    [self drawCardAtDeck:deck startPosX:startX startPosY:startY startIndex:0 number:number];
    
    [deck release];
}


- (void)addImageView: (NSString *)imageName startPosX:(int)startPosX startPosY:(int)startPosY {
    UIImage *image = [self makeCardImageView:imageName];
    
    UIImageView *cardImage = [[UIImageView alloc] initWithImage:image];
    [cardImage setFrame:CGRectMake(startPosX, startPosY, cardWidth, cardHeight)];
    
    [_myCanvas addSubview:cardImage];
   
    [image release];
    [cardImage release];   
}


- (void)drawCardAtDeck:(NSArray *)deckName startPosX:(int)startPosX startPosY:(int)startPosY startIndex:(int)index number:(int)number {
    
    for (int i = 0; i < number; i++) {
        [self addImageView:[deckName objectAtIndex:index++] startPosX:startPosX startPosY:startPosY];
        
        startPosY += 40;
    }
}

- (void)drawCardAtLastDeck:(NSArray *)cardDeck startPosX:(int)startPosX startPosY:(int)startPosY {
    for (int i = 0; i < 24; i++) {
        [self addImageView:[cardDeck objectAtIndex:i] startPosX:startPosX startPosY:startPosY];
        
        startPosX += 24;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_myCanvas release];
    [super dealloc];
}
@end
