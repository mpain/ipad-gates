#import "GTSEditableElement.h"
#import "GTSEditableCell.h"

@implementation GTSEditableElement

@synthesize text;

- (NSString *)cellReusableIdentifier {
    return @"GTSEditableCellIdentifier";
}

- (void)fetchValueIntoObject:(id)object {
    if (self.fetchKey) {
        [object setValue:self.text forKeyPath:self.fetchKey];
    }
}
@end
