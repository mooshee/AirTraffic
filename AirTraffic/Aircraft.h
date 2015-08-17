//
//  Aircraft.h
//  AirTraffic
//
//  Created by Daniel Hallman on 8/17/15.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ACType) {
    ACTypePassenger,
    ACTypeCargo
};

typedef NS_ENUM(NSInteger, ACSize) {
    ACSizeSmall,
    ACSizeLarge
};

extern NSString * NSStringFromACType(ACType value);
extern NSString * NSStringFromACSize(ACSize value);


@interface Aircraft : NSObject

#pragma mark - Properties

@property (readonly) ACType type;
@property (readonly) ACSize size;
@property (readonly) NSString *displayString;

#pragma mark - Init

- (instancetype)initWithType:(ACType)type size:(ACSize)size;

@end
