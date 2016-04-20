//
//  DetailViewController.m
//  w8_CFStreamSocket
//
//  Created by Eunjoo Im on 2016. 4. 20..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@end

@implementation DetailViewController

NSInputStream *detailInputStream;
NSOutputStream *detailOutputStream;
NSMutableData *myImageData;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self connectToCam];
    
    [self configureView];
}


- (void)connectToCam {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"127.0.0.1", 8000, &readStream, &writeStream);
    
    detailInputStream = (__bridge_transfer NSInputStream *)readStream;
    detailOutputStream = (__bridge_transfer NSOutputStream *)writeStream;
    [detailInputStream setDelegate:self];
    [detailOutputStream setDelegate:self];
    [detailInputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [detailOutputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [detailInputStream open];
    [detailOutputStream open];
}

- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    NSLog(@"stream event %u", streamEvent);
    
    switch (streamEvent) {
        case NSStreamEventOpenCompleted:
            NSLog(@"Stream opened");
            break;
            
        case NSStreamEventHasBytesAvailable: {
            

                uint8_t buffer[1024];
                unsigned int len = 8;
                unsigned int readedLen = 0;
                myImageData = [[NSMutableData alloc] init];
                
                [(NSInputStream *)theStream read:buffer maxLength:8];
                buffer[len] = "\0";
                long imageLength = atol((const char*)buffer);
                
                NSLog(@"imageLength: %ld", imageLength);
                
                readedLen = len;
                
                while (imageLength > readedLen) {
                    len = [detailInputStream read:buffer maxLength:sizeof(buffer)];
                    [myImageData appendBytes:buffer length:len];
                    readedLen += len;
                }
                
                NSLog(@"myData: %@", myImageData);
                
                _myImageView.image = [UIImage imageWithData:myImageData];
                
                uint8_t writeBuffer[3];
                writeBuffer[0] = "A";
                writeBuffer[0] = "C";
                writeBuffer[0] = "K";
                
                [detailOutputStream write:writeBuffer maxLength:sizeof(writeBuffer)];
            break;
        }
        case NSStreamEventErrorOccurred:
            NSLog(@"Can not connect to the host!");
            break;
        case NSStreamEventEndEncountered:
            NSLog(@"Closing stream...");
            [theStream close];
            [theStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            theStream = nil;
            break;
        default:
            NSLog(@"Unknown event");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:NO];
    [detailInputStream close];
    [detailOutputStream close];
}

@end
