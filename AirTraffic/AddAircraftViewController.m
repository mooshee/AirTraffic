//
//  AddAircraftViewController.m
//  AirTraffic
//
//  Created by Daniel Hallman on 8/17/15.
//
//

#import "AddAircraftViewController.h"
#import "Aircraft.h"

@interface AddAircraftViewController ()

@end

@implementation AddAircraftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions

- (IBAction)addAircraft:(id)sender {
    ACType type;
    if (self.typeSegControl.selectedSegmentIndex == 0) {
        type = ACTypePassenger;
    } else {
        type = ACTypeCargo;
    }
    
    ACSize size;
    if (self.sizeSegControl.selectedSegmentIndex == 0) {
        size = ACSizeSmall;
    } else {
        size = ACSizeLarge;
    }
    
    Aircraft *aircraft = [[Aircraft alloc] initWithType:type size:size];
    
    if (self.addAircraftDelegate) {
        [self.addAircraftDelegate addAircraftController:self didAddAircraft:aircraft];
    }
}

- (IBAction)cancel:(id)sender {
    if (self.addAircraftDelegate) {
        [self.addAircraftDelegate addAircraftControllerDidCancel:self];
    }
}

@end
