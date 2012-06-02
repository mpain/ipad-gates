#import "GTSRowElement.h"
#import "GTSFormTableView.h"
#import "GTSFormCell.h"

@implementation GTSRowElement

- (NSString *)cellReusableIdentifier {
	return nil;
}

- (GTSFormCell *)getCellForTableView:(GTSFormTableView *)tableView {
	return [tableView dequeueReusableCellWithIdentifier:[self cellReusableIdentifier]];
}

@end
