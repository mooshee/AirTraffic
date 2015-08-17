//
//  AirTrafficViewController.m
//  AirTraffic
//
//  Created by Daniel Hallman on 8/17/15.
//
//

#import "AirTrafficViewController.h"
#import "AircraftQueue.h"
#import "AddAircraftViewController.h"

@interface AirTrafficViewController () <AddAircraftDelegate>

@property (nonatomic, strong) AircraftQueue *aircraftQueue;
@property (nonatomic, strong) NSArray *aircraftTypes;
@property (nonatomic, strong) NSArray *aircraftSizes;
@property (nonatomic, strong) NSNumberFormatter *numberFormatter;

@end

@implementation AirTrafficViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.aircraftTypes = @[@(ACTypePassenger), @(ACTypeCargo)];
    self.aircraftSizes = @[@(ACSizeSmall), @(ACSizeLarge)];
    
    [self hideQueueControls:false];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showAddAircraft"]) {
        UINavigationController *navController = segue.destinationViewController;
        AddAircraftViewController *addController = [navController.viewControllers firstObject];
        addController.addAircraftDelegate = self;
    }
}

#pragma mark - Actions

- (IBAction)startQueue:(id)sender {
    self.aircraftQueue = [[AircraftQueue alloc] init];
    
    [self showQueueControls:true];
}

- (void)addRandomAircraft:(id)sender {
    // Random type and size
    ACType type = [self.aircraftTypes[(arc4random() % self.aircraftTypes.count)] integerValue];
    ACSize size = [self.aircraftSizes[(arc4random() % self.aircraftSizes.count)] integerValue];
    
    Aircraft *aircraft = [[Aircraft alloc] initWithType:type size:size];
    NSLog(@"add random %@", aircraft);
    [self addAircraft:aircraft];
}

- (void)retreiveAircraft:(id)sender {
    Aircraft *aircraft = [self.aircraftQueue popFirstObject];
    NSLog(@"retreive %@", aircraft);
    
    [self updateLastRetrivedWithAircraft:aircraft];
    [self updateAircraftCount];
}

#pragma mark - Helpers

- (BOOL)queueStarted {
    return (self.aircraftQueue != nil);
}

- (void)showQueueControls:(BOOL)animated {
    [UIView animateWithDuration:animated ? 0.7 : 0.0 animations:^{
        self.statusView.alpha = 1.0;
        self.retrievButton.alpha = 1.0;
        self.addButton.alpha = 1.0;
        self.addRandomButton.alpha = 1.0;
        self.startButton.alpha = 0.0;
    }];
}

- (void)hideQueueControls:(BOOL)animated {
    [UIView animateWithDuration:animated ? 0.7 : 0.0 animations:^{
        self.statusView.alpha = 0.0;
        self.retrievButton.alpha = 0.0;
        self.addButton.alpha = 0.0;
        self.addRandomButton.alpha = 0.0;
        self.startButton.alpha = 1.0;
    }];
}

- (void)addAircraft:(Aircraft *)aircraft {
    [self.aircraftQueue addObject:aircraft];
    [self updateAircraftCount];
}

- (void)updateAircraftCount {
    NSUInteger count = self.aircraftQueue.count;
    
    if (self.numberFormatter == nil) {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        self.numberFormatter = numberFormatter;
    }
    
    self.aircraftCountLabel.text = [self.numberFormatter stringFromNumber:@(count)];
    
    // Disable retrieve button if the queue contains no aircraft
    self.retrievButton.enabled = (count > 0);
}

- (void)updateLastRetrivedWithAircraft:(Aircraft *)aircraft {
    self.lastRetrievedLabel.text = [aircraft displayString];
}

#pragma mark - AddAircraftDelegate

- (void)addAircraftController:(AddAircraftViewController *)controller didAddAircraft:(Aircraft *)aircraft {
    [self dismissViewControllerAnimated:true completion:^{
        // Add to the queue
        NSLog(@"add custom %@", aircraft);
        [self addAircraft:aircraft];
        
        // Show alert
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Aircraft Added!", nil)
                                                                       message:[aircraft displayString]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Dismiss", nil) style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:true completion:nil];
    }];
}

- (void)addAircraftControllerDidCancel:(AddAircraftViewController *)controller {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
