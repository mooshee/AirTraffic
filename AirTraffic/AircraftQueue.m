//
//  AircraftQueue.m
//  AirTraffic
//
//  Created by Daniel Hallman on 8/17/15.
//
//

#import "AircraftQueue.h"

@implementation AircraftQueue

- (instancetype)init {
    self = [self initWithComparator:^NSComparisonResult(id obj1, id obj2) {
        Aircraft *aircraft1 = (Aircraft *)obj1;
        Aircraft *aircraft2 = (Aircraft *)obj2;
        
        if (aircraft1.type == aircraft2.type) {
            
            if (aircraft1.size == aircraft2.size) {
                return NSOrderedSame;
            }
            // Large AC’s of a given type have removal precedence over Small AC’s of the same type.
            else if (aircraft1.size == ACSizeLarge) {
                return NSOrderedAscending;
            }
            else {
                return NSOrderedDescending;
            }
        }
        // Passenger AC’s have removal precedence over Cargo AC’s
        else if (aircraft1.type == ACTypePassenger) {
            return NSOrderedAscending;
        }
        else {
            return NSOrderedDescending;
        }
    }];
    
    if (self) {
        return self;
    } else {
        return nil;
    }
}

@end
