//
//  PriorityQueue.m
//  AirTraffic
//
//  Created by Daniel Hallman on 8/17/15.
//
//

#import "PriorityQueue.h"

#pragma mark - QNode

@interface QNode : NSObject

- (id)initWithObject:(id)object comparator:(NSComparator)comparator;

@property (readonly, strong) id object;
@property (readwrite, weak) NSComparator comparator;

@end

@implementation QNode

- (id)initWithObject:(id)object comparator:(NSComparator)comparator {
    if ((self = [super init])) {
        _object = object;
        _comparator = comparator;
    }
    return self;
}

@end

#pragma mark -

CFComparisonResult PriorityQueueComparisonCallback(const void *ptr1, const void *ptr2, void *info) {
    QNode *node1 = (__bridge QNode *)ptr1;
    QNode *node2 = (__bridge QNode *)ptr2;
    
    NSComparator comparator = [node1 comparator];
    return (CFComparisonResult) comparator(node1.object, node2.object);
}

@implementation PriorityQueue {
    CFBinaryHeapRef _heap;
}

#pragma mark - Init

- (instancetype)initWithComparator:(NSComparator)comparator {
    if ((self = [super init])){
        _comparator = [comparator copy];
        
        CFBinaryHeapCallBacks callbacks = {
            .version         = 0,
            .retain          = kCFStringBinaryHeapCallBacks.retain,
            .release         = kCFStringBinaryHeapCallBacks.release,
            .copyDescription = kCFStringBinaryHeapCallBacks.copyDescription,
            .compare         = &PriorityQueueComparisonCallback,
        };
        
        _heap = CFBinaryHeapCreate(kCFAllocatorDefault, 0, &callbacks, NULL);
    }
    return self;
}

- (void)dealloc {
    CFRelease(_heap);
}

#pragma mark - Properties

- (NSUInteger)count
{
    return (NSUInteger)CFBinaryHeapGetCount(_heap);
}


#pragma mark - Instance methods

- (id)firstObject {
    CFTypeRef cfNode = NULL;
    Boolean res = CFBinaryHeapGetMinimumIfPresent(_heap, (const void **)&cfNode);
    if (res) {
        QNode *node = (__bridge QNode *) cfNode;
        return node.object;
    } else {
        return nil;
    }
}

- (id)popFirstObject {
    CFTypeRef cfNode = NULL;
    Boolean success = CFBinaryHeapGetMinimumIfPresent(_heap, (const void **)&cfNode);
    if (success) {
        QNode *node = (__bridge QNode*)cfNode;
        CFTypeRef object = (__bridge CFTypeRef)(node.object);
        [self removeFirstObject];
        return (__bridge_transfer id) object;
    } else {
        return nil;
    }
}

- (void)removeFirstObject
{
    CFIndex count = CFBinaryHeapGetCount(_heap);
    NSAssert(count > 0, @"Attemt to remove from empty queue");
    CFBinaryHeapRemoveMinimumValue(_heap);
}

- (void)addObject:(id)object {
    QNode *node = [[QNode alloc] initWithObject:object comparator:self.comparator];
    CFBinaryHeapAddValue(_heap, (__bridge_retained void *)node);
}

- (void)removeAllObjects {
    CFBinaryHeapRemoveAllValues(_heap);
}

- (NSArray *)allObjects {
    CFIndex size = CFBinaryHeapGetCount(_heap);
    CFTypeRef *cfValues = malloc(size * sizeof(CFTypeRef));
    CFBinaryHeapGetValues(_heap, (const void **)cfValues);
    CFArrayRef nodes = CFArrayCreate(kCFAllocatorDefault, cfValues, size, &kCFTypeArrayCallBacks);
    CFIndex count = CFArrayGetCount(nodes);
    CFMutableArrayRef objects = CFArrayCreateMutable(kCFAllocatorDefault, count, &kCFTypeArrayCallBacks);
    for (CFIndex i = 0; i < count; i++) {
        QNode *node = (__bridge_transfer QNode *)CFArrayGetValueAtIndex(nodes, i);
        id object = node.object;
        CFArrayAppendValue(objects, (__bridge_retained CFTypeRef) object);
    }
    free(cfValues);
    return (__bridge_transfer NSMutableArray *) objects;
}

@end
