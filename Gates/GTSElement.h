#import <Foundation/Foundation.h>

@interface GTSElement : NSObject

@property (nonatomic, assign, getter = isHidden) BOOL hidden;

- (void)fetchValueIntoObject:(id)object;

@end
