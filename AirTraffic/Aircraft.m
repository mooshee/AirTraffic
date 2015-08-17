//
//  Aircraft.m
//  AirTraffic
//
//  Created by Daniel Hallman on 8/17/15.
//
//

#import "Aircraft.h"

NSString * NSStringFromACType(ACType value) {
    switch (value) {
        case ACTypeCargo: return @"Cargo";
        case ACTypePassenger: return @"Passenger";
    }
    return nil;
}

NSString * NSStringFromACSize(ACSize value) {
    switch (value) {
        case ACSizeSmall: return @"Small";
        case ACSizeLarge: return @"Large";
    }
    return nil;
}

@implementation Aircraft

#pragma mark - Init

- (instancetype)initWithType:(ACType)type size:(ACSize)size {
    if ((self = [super init])) {
        _type = type;
        _size = size;
    }
    return self;
}

#pragma mark - Properties

- (NSString *)displayString {
    return [NSString stringWithFormat:@"%@ %@",
            NSStringFromACSize(self.size),
            NSStringFromACType(self.type)];
}

#pragma mark - Debug

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: type: %@, size: %@>",
            NSStringFromClass([self class]),
            NSStringFromACType(self.type),
            NSStringFromACSize(self.size)];
}

@end
