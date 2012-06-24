#import "GTSBooleanElement.h"

@implementation GTSBooleanElement

@synthesize on = _on;

- (NSString *)cellReusableIdentifier {
    return @"GTSBooleanCellIdentifier";
}

- (void)fetchValueIntoObject:(id)object {
    if (self.fetchKey) {
        [object setValue:[NSNumber numberWithBool:self.on] forKeyPath:self.fetchKey];
    }
}
@end
