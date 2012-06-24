#import "GTSPickerElement.h"
#import "GTSPickerCell.h"
#import "GTSPickerSpacedParser.h"

@implementation GTSPickerElement

@synthesize items = _items;
@synthesize valueParser = _valueParser;

@synthesize selectedItems = _selectedItems;
@synthesize selectedIndices = _selectedIndices;

- (id)init {
	self = [super init];
    if (self) {
        self.valueParser = [GTSPickerSpacedParser new];
    }
    return self;
}

- (id)initWithItems:(NSArray *)items value:(NSString *)value {
	self = [self init];
    if (self) {
        _items = items;
		self.text = value;
    }
    return self;
}

- (NSString *)cellReusableIdentifier {
    return @"GTSPickerCellIdentifier";
}

- (void)fetchValueIntoObject:(id)object {
    if (self.fetchKey) {
        [object setValue:self.selectedIndices forKeyPath:self.fetchKey];
    }
}

@end
