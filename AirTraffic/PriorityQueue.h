//
//  PriorityQueue.h
//  AirTraffic
//
//  Created by Daniel Hallman on 8/17/15.
//
//

#import <Foundation/Foundation.h>

@interface PriorityQueue : NSObject

#pragma mark - Properties

@property (readonly) NSUInteger count;

@property (readonly, copy) NSComparator comparator;

#pragma mark - Init

- (instancetype)initWithComparator:(NSComparator)comparator;

#pragma mark - Instance methods

- (id)firstObject;

- (id)popFirstObject;

- (void)addObject:(id)object;

- (void)removeAllObjects;

- (NSArray *)allObjects;

@end
