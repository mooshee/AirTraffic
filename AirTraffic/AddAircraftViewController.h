//
//  AddAircraftViewController.h
//  AirTraffic
//
//  Created by Daniel Hallman on 8/17/15.
//
//

#import <UIKit/UIKit.h>

@class Aircraft;
@class AddAircraftViewController;

@protocol AddAircraftDelegate <NSObject>

@required

- (void)addAircraftController:(AddAircraftViewController *)controller didAddAircraft:(Aircraft *)aircraft;
- (void)addAircraftControllerDidCancel:(AddAircraftViewController *)controller;

@end


@interface AddAircraftViewController : UITableViewController

@property (nonatomic, weak) id<AddAircraftDelegate> addAircraftDelegate;

@property (nonatomic, weak) IBOutlet UISegmentedControl *typeSegControl;
@property (nonatomic, weak) IBOutlet UISegmentedControl *sizeSegControl;

- (IBAction)addAircraft:(id)sender;
- (IBAction)cancel:(id)sender;

@end
