//
//  AirTrafficViewController.h
//  AirTraffic
//
//  Created by Daniel Hallman on 8/17/15.
//
//

#import <UIKit/UIKit.h>

@interface AirTrafficViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIView *statusView;
@property (nonatomic, weak) IBOutlet UILabel *aircraftCountLabel;
@property (nonatomic, weak) IBOutlet UILabel *lastRetrievedLabel;

@property (nonatomic, weak) IBOutlet UIButton *startButton;
@property (nonatomic, weak) IBOutlet UIButton *addButton;
@property (nonatomic, weak) IBOutlet UIButton *addRandomButton;
@property (nonatomic, weak) IBOutlet UIButton *retrievButton;

- (IBAction)startQueue:(id)sender;
- (IBAction)addRandomAircraft:(id)sender;
- (IBAction)retreiveAircraft:(id)sender;

@end
