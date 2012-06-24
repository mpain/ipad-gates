#import "GTSNumberElement.h"
#import "GTSNumberCell.h"

@implementation GTSNumberElement

@synthesize number = _number;
@synthesize fractionDigits = _fractionDigits;

- (id)init {
	self = [super init];
	if (self) {
		_number = NSDecimalNumber.zero;
	}
	return self;
}

- (NSString *)cellReusableIdentifier {
    return @"GTSNumberCellIdentifier";
}

- (void)fetchValueIntoObject:(id)object {
    if (self.fetchKey) {
        [object setValue:self.number forKeyPath:self.fetchKey];
    }
}
@end
