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

- (GTSFormCell *)getCellForTableView:(GTSFormTableView *)tableView {
    GTSNumberCell *cell = (GTSNumberCell *)[super getCellForTableView:tableView];
    [cell updateCellForElement:self andTableView:tableView];
    return cell;
}
@end
