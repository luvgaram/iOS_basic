//
//  MasterViewController.m
//  w8_CFStreamSocket
//
//  Created by Eunjoo Im on 2016. 4. 20..
//  Copyright © 2016년 Jay Im. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
@import CFNetwork;

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

NSInputStream *inputStream;
//NSOutputStream *outputStream;
NSMutableData *myData;
int byteIndex = 1024;
NSString *output;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    myData = [[NSMutableData alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"127.0.0.1", 7000, &readStream, &writeStream);
    
    inputStream = (__bridge_transfer NSInputStream *)readStream;
    [inputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
}

- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    NSLog(@"stream event %u", streamEvent);
    
    switch (streamEvent) {
        case NSStreamEventOpenCompleted:
            NSLog(@"Stream opened");
            break;
        case NSStreamEventHasSpaceAvailable: {
            uint8_t *readBytes = (uint8_t *)[myData mutableBytes];
            readBytes += byteIndex; // ivar
            int data_len = [myData length];
            unsigned int len = ((data_len - byteIndex >= 1024) ? 1024 : (data_len - byteIndex));
            uint8_t buf[len];
            (void)memcpy(buf, readBytes, len);
            len = [(NSOutputStream *)theStream write:(const uint8_t *)buf maxLength:len];
            NSLog(@"Sending buffer of len: %d", len);
            byteIndex += len;
            break;
        }
            
        case NSStreamEventHasBytesAvailable:
            if (theStream == inputStream) {
                uint8_t buffer[1024];
                int len;
                
                while ([inputStream hasBytesAvailable]) {
                    len = [inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {
                        output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                        NSTimeInterval timeInterval = [output doubleValue];
                        
                        if (output != nil) {
                            NSLog(@"server said: %@", output);
                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                            [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:9 * 60 * 60]];
                            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                            
                            NSDate* now = [NSDate dateWithTimeIntervalSince1970:timeInterval];
                            NSString *localDateString = [dateFormatter stringFromDate:now];
                            
                            NSLog(@"now: %@", localDateString);
                            
                            // insert row
                            [self.objects insertObject:localDateString atIndex:0];
                        
                            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                        }
                    }
                }
            }
            break;
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

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
