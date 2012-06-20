#import "GTSPickerElement.h"
#import "GTSPickerCell.h"
#import "GTSPickerSpacedParser.h"

@implementation GTSPickerElement

@synthesize items = _items;
@synthesize valueParser = _valueParser;

@synthesize selectedItems = _selectedItems;

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

- (GTSPickerCell *)getCellForTableView:(GTSFormTableView *)tableView {
    GTSPickerCell *cell = (GTSPickerCell *)[super getCellForTableView:tableView];
    [cell updateCellForElement:self andTableView:tableView];
    return cell;
}


@end
